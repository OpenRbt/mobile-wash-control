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
  final String hash;
  final String status;
  final String info;
  final int currentBalance;
  int currentProgramID;

  HomePageData(this.id, this.name, this.hash, this.status, this.info,
      this.currentBalance, this.currentProgramID);
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);

  bool _firstLoad = true;
  List<HomePageData> _homePageData = List.generate(12, (index) {
    return HomePageData(-1, "Loading...", "...", "...", "...", -1, -1);
  });

  Timer _updateTimer;
  Timer _updateLabelsTimer;

  List<Program> _programs;
  Map<int, List<InlineResponse2001Buttons>> _stationProgramsButtons = Map();
  Map<int, Map<int, String>> _stationLabels = Map();

  void initState() {
    super.initState();
  }

  void _getLabels(SessionData sessionData) async {
    bool redraw = false;
    try {
      if (!mounted) {
        return;
      }
      var args14 = ProgramsArgs();
      _programs = await sessionData.client.programs(args14);

      for (int i = 0; i < _homePageData.length; i++) {
        try {
          var args = StationButtonArgs();
          args.stationID = _homePageData[i].id;
          var res = await sessionData.client.stationButton(args);

          Map<int, String> labels = Map();

          if (res.buttons != null) {
            _stationProgramsButtons[i + 1] = res.buttons;

            for (int i = 0; i < res.buttons.length; i++) {
              if (res.buttons[i].buttonID != null) {
                Program program = _programs
                    .where((element) => element.id == res.buttons[i].programID)
                    .first;
                if (program != null) {
                  String label = program.name.length > 0 ? program.name[0] : "";
                  if (program.name.length > 0 &&
                      program.name.lastIndexOf(" ") > 0 &&
                      program.name.lastIndexOf(" ") + 1 < program.name.length) {
                    label += program.name[program.name.lastIndexOf(" ") + 1];
                  }
                  labels[res.buttons[i].buttonID - 1] = label;
                }
              }
            }
          }
          redraw = _stationLabels[_homePageData[i].id] != labels;
          _stationLabels[_homePageData[i].id] = labels;
        } catch (e) {}
      }
    } catch (e) {
      print("Exception when calling DefaultApi->Status in HomePage: $e\n");
      showInfoSnackBar(_scaffoldKey, _isSnackBarActive,
          "Произошла ошибка при запросе к api", Colors.red);
    }
    if (redraw) setState(() {});
  }

  void _getStations(SessionData sessionData) async {
    bool redraw = false;
    try {
      var res = await sessionData.client.status();
      res.stations =
          res.stations.where((element) => element.id != null).toList();
      if (!mounted) {
        return;
      }
      var tmpHomepage = List.generate((res.stations.length), (index) {
        return HomePageData(
            res.stations[index].id ?? index + 1,
            res.stations[index].name ?? "Station ${index + 1}",
            res.stations[index].hash ?? "",
            res.stations[index].status.value ?? "",
            res.stations[index].info ?? "",
            res.stations[index].currentBalance ?? 0,
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
    if (redraw) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;
    if (_firstLoad) {
      _getStations(sessionData);
      _getLabels(sessionData);
      _updateTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        _getStations(sessionData);
      });
      _updateLabelsTimer = Timer.periodic(Duration(seconds: 10), (timer) {
        _getLabels(sessionData);
      });
      _firstLoad = false;
    }

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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 50,
                    width: 165,
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
                                  _homePageData[index].hash,
                                  _homePageData[index].currentProgramID,
                                  _stationProgramsButtons[
                                      _homePageData[index].id],
                                  _programs,
                                  sessionData);
                              _updateTimer.cancel();
                              _updateLabelsTimer.cancel();
                              Navigator.pushNamed(context, "/mobile/home/editPost",
                                      arguments: args)
                                  .then((value) {
                                _getStations(sessionData);
                                _updateTimer = Timer.periodic(
                                    Duration(seconds: 1), (timer) {
                                  _getStations(sessionData);
                                  _updateLabelsTimer = Timer.periodic(
                                      Duration(seconds: 10), (timer) {
                                    _getLabels(sessionData);
                                  });
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
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 115,
                    width: 165,
                    child: DecoratedBox(
                      child: GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        children: List.generate(6, (btnIndex) {
                          return Padding(
                            padding: EdgeInsets.all(5),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: (btnIndex + 1 == activeProgramIndex)
                                    ? Colors.lightGreenAccent
                                    : Colors.white,
                              ),
                              child: Center(
                                child: Text(_stationLabels[index + 1] != null
                                    ? (_stationLabels[index + 1][btnIndex] ??
                                        "")
                                    : ""),
                              ),
                            ),
                          );
                          // return SizedBox(
                          //   child: Padding(
                          //     padding: EdgeInsets.all(5),
                          //     child: FlatButton(
                          //       padding: EdgeInsets.zero,
                          //       color: (btnIndex + 1 == activeProgramIndex)
                          //           ? Colors.lightGreenAccent
                          //           : Colors.white,
                          //       onPressed: () {},
                          //       child: Text(_stationLabels[index + 1] != null
                          //           ? (_stationLabels[index + 1][btnIndex] ??
                          //               "")
                          //           : ""),
                          //     ),
                          //   ),
                          // );
                        }),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                      ),
                    ),
                  )
                ],
              );
            }),
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
    if (_updateLabelsTimer != null && _updateLabelsTimer.isActive) {
      _updateLabelsTimer.cancel();
    }
    super.dispose();
  }
}
