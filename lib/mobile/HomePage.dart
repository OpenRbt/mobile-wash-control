import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    this.currentProgramID = status.currentProgram ?? 0;
    this.currentProgramName = status.currentProgramName ?? "";
  }
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);

  bool _firstLoad = true;
  List<HomePageData> _homePageData = List.generate(12, (index) {
    return HomePageData(-1, "Loading...", "", "", "", "", -1, -1);
  });

  Timer _updateTimer;

  void initState() {
    super.initState();
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
          return ListView.builder(
              itemCount: _homePageData.length ~/ 2 + _homePageData.length % 2,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: screenW,
                  child: Row(
                    children: [
                      Expanded(child: (index * 2) < _homePageData.length && _homePageData[index * 2].hash != "" ? _stationWidget(index: (index * 2), sessionData: sessionData) : Container()),
                      Expanded(child: (index * 2 + 1) < _homePageData.length && _homePageData[index * 2 + 1].hash != "" ? _stationWidget(index: (index * 2 + 1), sessionData: sessionData) : Container()),
                    ],
                  ),
                );
              });
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

  Widget _stationWidget({int index = 0, SessionData sessionData}) {
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
                                _getStations();
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
  }
}
