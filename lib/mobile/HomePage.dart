import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';
import 'dart:async';

import 'package:mobile_wash_control/mobile/PostMenuEdit.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class HomePageData {
  int id;
  String name;
  String ip;
  String hash;
  String status;
  String info;
  int currentBalance;
  int currentProgramID;
  String currentProgramName;

  HomePageData(this.id, this.name, this.ip, this.hash, this.status, this.info, this.currentBalance, this.currentProgramID);
  HomePageData.fromStationStatus(StationStatus status) {
    this.id = status.id ?? 0;
    this.ip = status.ip ?? "___.___.___.___";
    this.name = status.name ?? "";
    this.hash = status.hash ?? "";
    this.status = status.status?.value ?? "";
    this.info = status.info ?? "";
    this.currentBalance = status.currentBalance ?? 0;
    this.currentProgramID = status.currentProgram ?? -1;
    this.currentProgramName = status.currentProgramName ?? "";
  }
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);

  bool _firstLoad = true;
  List<HomePageData> _homePageData = List.generate(12, (index) {
    return HomePageData(
        -1, "Loading...", "...", "...", "...", "...", -1, "IDLE", -1);
  });

  Timer _updateTimer;

  void initState() {
    super.initState();
  }

  void _getPrograms(SessionData sessionData) async {
    _programsTimer.cancel();
    try {
      var args14 = ProgramsArgs();
      _programs = await sessionData.client.programs(args14);
    } catch (e) {
      print("Exception when calling DefaultApi->programs in HomePage: $e\n");
      showInfoSnackBar(_scaffoldKey, _isSnackBarActive, "Произошла ошибка при запросе к api", Colors.red);
    }
    if (!mounted) {
      return;
    }
    _programsTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      _getPrograms(sessionData);
    });
  }

  void _getStations() async {
    bool redraw = false;
    _updateTimer.cancel();

    try {
      List<StationStatus> stations = GlobalStations.info.values.toList();
      var tmpHomepage = List.generate((stations.length), (index) {
        return HomePageData.fromStationStatus(stations[index]);
      });
      redraw = _homePageData != tmpHomepage;
      _homePageData = tmpHomepage;
    } catch (e) {
      print("ERROR:\n$e");
    }
    if (!mounted) {
      return;
    }
    _updateTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _getStations();
    });

    if (redraw) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;
    if (_firstLoad) {
      _updateTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        _getStations();
      });
      _firstLoad = false;
    }

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Главная"),
      ),
      drawer: prepareDrawer(context, Pages.Main, sessionData),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            padding: const EdgeInsets.all(10),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
            childAspectRatio: 1,
            children: List.generate(_homePageData?.length ?? 0, (index) {
              var activeProgramIndex = _homePageData[index].currentProgramID;

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                    width: (screenW - (orientation == Orientation.portrait ? 3 : 5) * 10),
                    child: FlatButton(
                      color: _homePageData[index].status == "online" ? Colors.lightGreen : Colors.red,
                      highlightColor: _homePageData[index].status == "online" ? Colors.lightGreenAccent : Colors.redAccent,
                      disabledColor: Colors.red,
                      disabledTextColor: Colors.black,
                      onPressed: _homePageData[index].id == -1
                          ? null
                          : () {
                              var args = PostMenuArgs(
                                _homePageData[index].id,
                                _homePageData[index].ip,
                                _homePageData[index].hash,
                                _homePageData[index].currentProgramID,
                                _programs,
                                sessionData,
                              );
                              if (_updateTimer.isActive) {
                                _updateTimer.cancel();
                              }
                              if (_programsTimer.isActive) {
                                _programsTimer.cancel();
                              }
                              Navigator.pushNamed(context, "/mobile/editPost", arguments: args).then((value) {
                                _updateTimer = Timer.periodic(Duration(seconds: 1), (timer) {
                                  _getStations();
                                });
                                _programsTimer = Timer.periodic(Duration(seconds: 10), (timer) {
                                  _getPrograms(sessionData);
                                });
                                setState(() {});
                              });
                            },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_homePageData[index].name),
                          Text("Баланс: ${_homePageData[index].currentBalance ?? '__'}"),
                          Text("IP: ${_homePageData[index].ip}"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 115,
                    child: DecoratedBox(
                      child: Center(
                        child: SizedBox(
                          height: 100,
                          child: DecoratedBox(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(_homePageData[index].name),
                                  Text(
                                    "Текущая программа",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                    thickness: 3,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      activeProgramIndex > 0 ? _homePageData[index]?.currentProgramName : (activeProgramIndex == -1 ? "Загрузка..." : "Ожидание клиента"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 115,
                            child: DecoratedBox(
                              child: Center(
                                child: SizedBox(
                                  height: 100,
                                  child: DecoratedBox(
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Текущая программа",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Divider(
                                            color: Colors.grey,
                                            thickness: 3,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Text(_homePageData[index]
                                                .currentProgramName),
                                          ),
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey, width: 3),
                                    ),
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(color: Colors.grey),
                            ),
                          )
                        ],
                      );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    if (_updateTimer != null && _updateTimer.isActive) {
      _updateTimer.cancel();
    }
    super.dispose();
  }
}
