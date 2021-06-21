import 'package:flutter/material.dart';
import 'package:mobile_wash_control/desktop/DEditPost.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:flutter/services.dart';
import 'package:mobile_wash_control/client/api.dart';
import 'dart:async';

import 'package:mobile_wash_control/PagesUtils/PagesArgs.dart';
import 'package:mobile_wash_control/PagesUtils/ServerRequests/Homepage.dart';

class DHomePage extends StatefulWidget {
  @override
  _DHomePageState createState() => _DHomePageState();
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

class _DHomePageState extends State<DHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);

  SessionData _sessionData;

  Timer _updateTimer;

  bool _firstLoad = true;
  List<HomePageData> _homePageData = List.generate(12, (index) {
    return HomePageData(
        -1, "Loading...", "...", "...", "...", "...", -1, "IDLE", -1);
  });

  void _getStations(SessionData sessionData) async {
    bool redraw = false;
    if (_updateTimer != null && _updateTimer.isActive) {
      _updateTimer.cancel();
    }
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
            res.stations[index].ip ?? "___.___.___.___",
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

    if (!_updateTimer.isActive) {
      _updateTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        _getStations(sessionData);
      });
    }

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
    _sessionData = sessionData;
    var screenW = MediaQuery.of(context).size.width;
    var screenH = MediaQuery.of(context).size.height;

    double DrawerSize = 256;

    var width = screenW - DrawerSize;
    var height = screenH;

    return Scaffold(
      key: _scaffoldKey,
      body: Row(
        children: [
          DGetDrawer(screenH, DrawerSize, context, Pages.Main, sessionData),
          SizedBox(
            height: screenH,
            width: width,
            child: Column(
              children: [
                SizedBox(
                  height: screenH,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: GetHomePageGrid(width, height),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> GetHomePageGrid(double sizeX, double sizeY) {
    List<Widget> res = List();

    int lineCount = (_homePageData.length / 3.0).ceil() + 1;

    for (int i = 0; i < _homePageData.length; i += 3) {
      res.add(GetHomePageRow(sizeX, sizeY / lineCount, i));
    }
    return res;
  }

  Widget GetHomePageRow(double width, double height, int startID) {
    var boxWidth = width / 10 * 3;
    return SizedBox(
      height: height,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          3,
          (index) {
            var pos = startID + index;
            if (pos >= _homePageData.length) {
              return SizedBox(
                height: height,
                width: boxWidth,
              );
            }
            return SizedBox(
              height: height,
              width: boxWidth,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(blurRadius: 4, color: Colors.black),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: height / 4,
                      width: boxWidth,
                      child: FlatButton(
                        color: _homePageData[pos].status == "online"
                            ? Colors.lightGreen
                            : Colors.red,
                        highlightColor: _homePageData[pos].status == "online"
                            ? Colors.lightGreenAccent
                            : Colors.redAccent,
                        disabledColor: Colors.red,
                        disabledTextColor: Colors.black,
                        onPressed: () => OpenPostEditPage(pos),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_homePageData[pos].name),
                            Text(
                                "Баланс: ${_homePageData[pos].currentBalance ?? '__'}"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height / 4,
                      width: boxWidth,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: _homePageData[pos].status == "online"
                              ? Colors.white
                              : Colors.grey,
                          boxShadow: [
                            BoxShadow(blurRadius: 2, color: Colors.black),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "IP: ${_homePageData[pos].ip}",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height / 4,
                      width: boxWidth,
                      child: Center(
                        child: Text(
                          "Текущая программа",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height / 4,
                      width: boxWidth,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(blurRadius: 2, color: Colors.black),
                          ],
                        ),
                        child: Center(
                          child: Text(_homePageData[pos].currentProgramName,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void OpenPostEditPage(int index) {
    var args = PostMenuArgs(
        _homePageData[index].id,
        _homePageData[index].ip,
        _homePageData[index].hash,
        _homePageData[index].currentProgramID,
        _sessionData);
    if (_updateTimer.isActive) {
      _updateTimer.cancel();
    }
    Navigator.pushNamed(context, "/desktop/home/edit", arguments: args)
        .then((value) {
      _getStations(_sessionData);
      _updateTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        _getStations(_sessionData);
      });
      setState(() {});
    });
  }

  void initState() {
    super.initState();
  }
}
