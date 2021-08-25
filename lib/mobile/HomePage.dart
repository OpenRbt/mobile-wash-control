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
  String currentProgramName = "";
  int currentProgramID;

  HomePageData(this.id, this.name, this.ip, this.hash, this.status, this.info, this.currentBalance, this.currentProgramName, this.currentProgramID);
  HomePageData.fromStationStatus(StationStatus status) {
    this.id = status.id ?? 0;
    this.ip = status.ip ?? "___.___.___.___";
    this.name = status.name ?? "";
    this.hash = status.hash ?? "";
    this.status = status.status?.value ?? "";
    this.info = status.info ?? "";
    this.currentBalance = status.currentBalance ?? 0;
    this.currentProgramID = status.currentProgram ?? 0;
    if (status?.currentProgramName != null) {
      var tmp = status.currentProgramName.indexOf('-');
      if (tmp < status.currentProgramName.length) {
        this.currentProgramName = status.currentProgramName.substring(tmp + 1);
      } else {
        this.currentProgramName = status.currentProgramName;
      }
    }
  }
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);

  bool _firstLoad = true;
  List<HomePageData> _homePageData = List();

  Timer _updateTimer;

  void initState() {
    super.initState();
  }

  void _getStations(SessionData sessionData) async {
    bool redraw = false;
    _updateTimer.cancel();
    try {
      var res = await sessionData.client.status();
      res.stations = res.stations.where((element) => element.hash != null).toList();
      var tmpHomepage = List.generate((res.stations.length), (index) {
        return HomePageData.fromStationStatus(res.stations[index]);
      });
      tmpHomepage.sort(
        (a, b) => a.id.compareTo(b.id),
      );
      redraw = _homePageData != tmpHomepage;
      if (redraw) _homePageData = tmpHomepage;
    } catch (e) {
      print("Exception when calling DefaultApi->Status in HomePage: $e\n");
      showInfoSnackBar(_scaffoldKey, _isSnackBarActive, "Произошла ошибка при запросе к api", Colors.red);
    }
    if (!mounted) {
      return;
    }
    _updateTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _getStations(sessionData);
    });
    if (redraw) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;
    if (_firstLoad) {
      _updateTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        _getStations(sessionData);
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
            children: List.generate(
              _homePageData?.length ?? 0,
              (index) {
                bool isOnline = _homePageData[index].status == "online";
                return Padding(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 1,
                        ),
                      ],
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                              child: Container(
                                color: isOnline ? Colors.green : Colors.red,
                                child: Column(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        var args = PostMenuArgs(
                                          _homePageData[index].id,
                                          _homePageData[index].ip,
                                          _homePageData[index].hash,
                                          _homePageData[index].currentProgramID,
                                          sessionData,
                                        );
                                        if (_updateTimer.isActive) {
                                          _updateTimer.cancel();
                                        }
                                        Navigator.pushNamed(context, "/mobile/editPost", arguments: args).then((value) {
                                          _updateTimer = Timer.periodic(Duration(seconds: 1), (timer) {
                                            _getStations(sessionData);
                                          });
                                          setState(() {});
                                        });
                                      },
                                      child: Column(
                                        children: [
                                          Text(
                                            _homePageData[index].name,
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          Divider(
                                            thickness: 2,
                                          ),
                                          Text(
                                            "Баланс: ${_homePageData[index].currentBalance}",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            "IP: ${_homePageData[index].ip}",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(top: 5, bottom: 5),
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Text("Текущая программа:"),
                                    Divider(
                                      thickness: 3,
                                    ),
                                    Text(
                                      _homePageData[index].currentProgramID == 0 ? (isOnline ? "Ожидание клиента" : "") : _homePageData[index].currentProgramName ?? "Загрузка...",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
