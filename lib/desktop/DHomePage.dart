import 'package:flutter/material.dart';
import 'package:mobile_wash_control/desktop/DEditPost.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:flutter/services.dart';
import 'package:mobile_wash_control/client/api.dart';
import 'dart:async';

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

  Timer _updateTimer;
  Map<int, List<InlineResponse2001Buttons>> _stationProgramsButtons = Map();
  Map<int, Map<int, String>> _stationLabels = Map();

  bool _firstLoad = true;
  List<HomePageData> _homePageData = List.generate(12, (index) {
    return HomePageData(
        -1, "Loading...", "...", "...", "...", "...", -1, "IDLE", -1);
  });

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

    var screenW = MediaQuery.of(context).size.width;
    var screenH = MediaQuery.of(context).size.height;

    var width = screenW - screenW / 4;
    var height = screenH;
    return Scaffold(
      key: _scaffoldKey,
      body: Row(
        children: [
          DGetDrawer(screenH, screenW / 4, context, Pages.Main, sessionData),
          SizedBox(
            height: screenH,
            width: width,
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(10),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 4,
              childAspectRatio: (width / 4) / (height / 3),
              children: List.generate(
                _homePageData?.length ?? 0,
                (index) {
                  var activeProgramIndex =
                      _homePageData[index].currentProgramID;
                  return _homePageData[index].hash == ""
                      ? SizedBox()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 60,
                              width: width / 4,
                              child: FlatButton(
                                color: _homePageData[index].status == "online"
                                    ? Colors.green
                                    : Colors.red,
                                highlightColor:
                                    _homePageData[index].status == "online"
                                        ? Colors.greenAccent
                                        : Colors.redAccent,
                                disabledColor: Colors.red,
                                disabledTextColor: Colors.black,
                                onPressed: () {
                                  var args = DEditPostArgs(
                                      _homePageData[index].id,
                                      _homePageData[index].ip,
                                      _homePageData[index].hash,
                                      _homePageData[index].currentProgramID,
                                      _stationProgramsButtons[
                                          _homePageData[index].id],
                                      this._homePageData[index].currentBalance,
                                      sessionData);
                                  if (_updateTimer.isActive) {
                                    _updateTimer.cancel();
                                  }
                                  Navigator.pushNamed(
                                          context, "/desktop/home/edit",
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
            ),
          ),
        ],
      ),
    );
  }

  void initState() {
    super.initState();
  }
}
