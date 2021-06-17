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
  final int id;
  final String name;
  final String ip;
  final String hash;
  final String status;
  final String info;
  final int currentBalance;
  final String currentProgramName;
  final int currentProgramID;

  HomePageData(this.id, this.name, this.ip, this.hash, this.status, this.info,
      this.currentBalance, this.currentProgramName, this.currentProgramID);
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

  void _getStations(SessionData sessionData) async {
    bool redraw = false;
    _updateTimer.cancel();
    try {
      if (!mounted) {
        return;
      }
      var res = await sessionData.client.status();
      res.stations =
          res.stations.where((element) => element.id != null).toList();
      var tmpHomepage = List.generate((res.stations.length), (index) {
        return HomePageData(
            res.stations[index].id ?? index + 1,
            res.stations[index].name ?? "Station ${index + 1}",
            res.stations[index].ip ?? "",
            res.stations[index].hash ?? "",
            res.stations[index].status.value ?? "",
            res.stations[index].info ?? "",
            res.stations[index].currentBalance ?? 0,
            res.stations[index].currentProgramName ?? "Загрузка...",
            res.stations[index].currentProgram ?? -1);
      });

      tmpHomepage.sort(
        (a, b) => a.id.compareTo(b.id),
      );
      redraw = _homePageData != tmpHomepage;
      if (redraw) _homePageData = tmpHomepage;
    } catch (e) {
      print("Exception when calling DefaultApi->Status in HomePage: $e\n");
      showInfoSnackBar(_scaffoldKey, _isSnackBarActive,
          "Произошла ошибка при запросе к api", Colors.red);
    }
    Future.delayed(Duration(milliseconds: 500), () {
      if (!_updateTimer.isActive) {
        _updateTimer = Timer.periodic(Duration(seconds: 1), (timer) {
          _getStations(sessionData);
        });
      }
    });
    if (redraw) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;
    if (_firstLoad) {
      _getStations(sessionData);
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
                var activeProgramIndex = _homePageData[index].currentProgramID;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60,
                      width: (screenW -
                          (orientation == Orientation.portrait ? 3 : 5) * 10),
                      child: FlatButton(
                        color: _homePageData[index].status == "online"
                            ? Colors.lightGreen
                            : Colors.red,
                        highlightColor: _homePageData[index].status == "online"
                            ? Colors.lightGreenAccent
                            : Colors.redAccent,
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
                                    sessionData);
                                if (_updateTimer.isActive) {
                                  _updateTimer.cancel();
                                }
                                Navigator.pushNamed(context, "/mobile/editPost",
                                        arguments: args)
                                    .then((value) {
                                  _getStations(sessionData);
                                  _updateTimer = Timer.periodic(
                                      Duration(seconds: 1), (timer) {
                                    _getStations(sessionData);
                                  });
                                  setState(() {});
                                });
                              },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_homePageData[index].name),
                            Text(
                                "Баланс: ${_homePageData[index].currentBalance ?? '__'}"),
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
                                border:
                                    Border.all(color: Colors.grey, width: 3),
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
