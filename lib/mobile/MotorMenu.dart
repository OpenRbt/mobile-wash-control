import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';

class MotorMenu extends StatefulWidget {
  @override
  _MotorMenuState createState() => _MotorMenuState();
}

class _MotorMenuState extends State<MotorMenu> {
  _MotorMenuState() : super();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);

  bool _firstLoad = true;
  bool _updating = false;

  List<StationStat> _stationStats = new List();
  List<bool> _ProgramStat = new List();

  int _paddingValue = 0;

  void GetMotorStats(SessionData sessionData) async {
    if (_updating) {
      return;
    }
    _updating = true;
    try {
      var args = ArgStationStat();
      _stationStats = await sessionData.client.stationStatCurrent(args: args);
      _ProgramStat = List.filled(_stationStats.length, true);
      _stationStats.forEach((element) {
        element.relayStats.forEach((relay) {
          if ("${relay.switchedCount}".length > _paddingValue) {
            _paddingValue = "${relay.switchedCount}".length;
          }
        });
      });
      setState(() {});
    } on ApiException catch (e) {
      if (e.code != 404) {
        print("Exception when calling DefaultApi->/station-report-dates: $e\n");
        showInfoSnackBar(_scaffoldKey, _isSnackBarActive, "Произошла ошибка при запросе к api", Colors.red);
      } else {}
    } catch (e) {
      if (!(e is ApiException)) {
        print("Other Exception: $e\n");
      }
    }
    _updating = false;
  }

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;

    final AppBar appBar = AppBar(
      title: Text("Моторесурс"),
    );

    if (_firstLoad) {
      GetMotorStats(sessionData);
      _firstLoad = false;
    }

    double screenH = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - appBar.preferredSize.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar,
      drawer: prepareDrawer(context, Pages.Motors, sessionData),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(
                Duration(milliseconds: 500),
              );
              GetMotorStats(sessionData);
            },
            child: _stationStats.length > 0
                ? Container(
                    width: screenW,
                    height: screenH,
                    child: Column(
                      children: [
                        Container(
                          height: screenH,
                          child: ListView(children: [
                            Container(
                              height: screenH,
                              width: screenW,
                              child: ListView(
                                padding: EdgeInsets.all(0),
                                physics: PageScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                children: List.generate(_stationStats.length, (index) {
                                  return Container(
                                    padding: EdgeInsets.all(8),
                                    child: Container(
                                      height: screenH - 100,
                                      width: screenW - 16,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(color: Colors.black, blurRadius: 2.5),
                                        ],
                                      ),
                                      child: ListView(
                                        children: [
                                          Container(
                                            child: Text(
                                              "Пост ${index + 1}",
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  _ProgramStat[index] = true;
                                                  setState(() {});
                                                },
                                                child: Text(
                                                  "Статистика программ",
                                                  style: TextStyle(
                                                    color: _ProgramStat[index] ? Colors.green : null,
                                                    fontWeight: _ProgramStat[index] ? FontWeight.bold : null,
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  _ProgramStat[index] = false;
                                                  setState(() {});
                                                },
                                                child: Text(
                                                  "Статистика реле",
                                                  style: TextStyle(
                                                    color: !_ProgramStat[index] ? Colors.green : null,
                                                    fontWeight: !_ProgramStat[index] ? FontWeight.bold : null,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: _ProgramStat[index] ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.spaceEvenly,
                                            children: !_ProgramStat[index]
                                                ? [
                                                    Container(
                                                      padding: EdgeInsets.all(5),
                                                      child: Text(
                                                        "Общее время работы насоса",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.all(5),
                                                      child: Text(
                                                        "${_SecondsToTime(_stationStats[index].pumpTimeOn)}",
                                                        textAlign: TextAlign.right,
                                                      ),
                                                    ),
                                                  ]
                                                : [],
                                          ),
                                          Row(
                                            mainAxisAlignment: _ProgramStat[index] ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.spaceEvenly,
                                            children: _ProgramStat[index]
                                                ? [
                                                    Container(
                                                      padding: EdgeInsets.all(5),
                                                      child: Text(
                                                        "Программа",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.all(5),
                                                      child: Text(
                                                        "Время работы",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ]
                                                : [
                                                    Container(
                                                      padding: EdgeInsets.all(5),
                                                      child: Text(
                                                        "Реле",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.all(5),
                                                      child: Text(
                                                        "Включений",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.all(5),
                                                      child: Text(
                                                        "Время работы",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                          ),
                                          Column(
                                            children: _ProgramStat[index] ? ProgramsCollumn(index, screenW / 3) : RelayCollumn(index, screenW / 4),
                                          ),
                                          Container(
                                              child: TextButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                      "Сбросить статистику",
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    content: Text("Вы уверены, что хотите сбросить статистику?"),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () async {
                                                            bool res = await ResetStats(_stationStats[index].stationID, sessionData);
                                                            if (res) {
                                                              GetMotorStats(sessionData);
                                                            }
                                                            Navigator.pop(context);
                                                          },
                                                          child: Text("Да")),
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                          child: Text("Нет"))
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Text(
                                              "Сбросить статистику",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  )
                : Container(
                    height: screenH,
                    width: screenW,
                    child: Center(
                      child: Text(
                        "Нет статистики по моторесурсу",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  List<Widget> RelayCollumn(int index, double Width) {
    return List.generate(_stationStats[index].relayStats.length, (relayIndex) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: Width,
            padding: EdgeInsets.all(5),
            child: Text(
              "Реле ${_stationStats[index].relayStats[relayIndex].relayID}",
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            width: Width,
            padding: EdgeInsets.all(5),
            child: Text(
              "${_stationStats[index].relayStats[relayIndex].switchedCount}".padLeft(_paddingValue, ' '),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: Width,
            padding: EdgeInsets.all(5),
            child: Text(
              "${_SecondsToTime(_stationStats[index].relayStats[relayIndex].totalTimeOn ?? 0)}",
              textAlign: TextAlign.right,
            ),
          ),
        ],
      );
    });
  }

  List<Widget> ProgramsCollumn(int index, double Width) {
    return List.generate(_stationStats[index].programStats.length, (programIndex) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: Width,
            padding: EdgeInsets.all(5),
            child: Text(
              "${_stationStats[index].programStats[programIndex].programName}",
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            width: Width,
            padding: EdgeInsets.all(5),
            child: Text(
              "${_SecondsToTime(_stationStats[index].programStats[programIndex].timeOn ?? 0)}",
              textAlign: TextAlign.right,
            ),
          ),
        ],
      );
    });
  }

  Future<bool> ResetStats(int stationID, SessionData sessionData) async {
    try {
      var args = ArgResetStationStat(stationID: stationID);
      var res = await sessionData.client.resetStationStat(args: args);
    } catch (e) {
      return false;
    }
    return true;
  }

  String _SecondsToTime(int seconds) {
    String res = "";
    if (seconds > 3600) {
      res += "${seconds ~/ 3600} ч.\n";
    }
    if (seconds > 60) {
      res += "${(seconds % 3600) ~/ 60} мин.\n";
    }
    res += "${seconds % 60} сек.";
    return res;
  }
}
