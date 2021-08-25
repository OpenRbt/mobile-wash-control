import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';

class DMotorMenu extends StatefulWidget {
  @override
  _DMotorMenuState createState() => _DMotorMenuState();
}

class _DMotorMenuState extends State<DMotorMenu> {
  _DMotorMenuState() : super();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);

  bool _ByDate = false;
  DateTime _startDate = DateTime.now().add(
    new Duration(days: -31),
  );
  DateTime _endDate = DateTime.now().add(
    new Duration(days: 1, seconds: -1),
  );

  bool _firstLoad = true;
  bool _updating = false;

  List<StationStat> _stationStats = new List();
  List<bool> _ProgramStat = new List();

  int _paddingValue = 0;

  ScrollController _scrollController;

  void initState() {
    _scrollController = new ScrollController();
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void GetMotorStats(SessionData sessionData) async {
    if (_updating) {
      return;
    }
    _updating = true;
    try {
      _paddingValue = 0;
      if (_ByDate) {
        var args = ArgStationStatDates(
          startDate: _startDate.millisecondsSinceEpoch ~/ 1000,
          endDate: _endDate.millisecondsSinceEpoch ~/ 1000,
        );
        _stationStats = await sessionData.client.stationStatDates(args: args);
      } else {
        var args = ArgStationStat();
        _stationStats = await sessionData.client.stationStatCurrent(args: args);
      }
      _ProgramStat = List.filled(_stationStats.length, true);
      _stationStats.forEach((element) {
        element.programStats.forEach((program) {
          if (program?.programName != null) {
            var tmp = program.programName.indexOf('-');
            if (tmp < program.programName.length) {
              program.programName = program.programName.substring(tmp + 1);
            }
          }
        });
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

    if (_firstLoad) {
      GetMotorStats(sessionData);
      _firstLoad = false;
    }

    double screenH = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    double screenW = MediaQuery.of(context).size.width;

    double DrawerSize = 256;

    var width = screenW - DrawerSize;
    var height = screenH;

    var _Collumns = width ~/ 400;

    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.lightGreen,
          borderRadius: BorderRadiusDirectional.circular(25),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                if (!_updating) GetMotorStats(sessionData);
              },
              icon: Icon(Icons.refresh),
            ),
            Icon(_ByDate ? Icons.calendar_today : null),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return AlertDialog(
                            title: Text("Настройки отображения"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("По датам: "),
                                    TextButton(
                                      onPressed: () {
                                        _ByDate = !_ByDate;
                                        setState(() {});
                                      },
                                      child: Text(
                                        "${_ByDate ? "Да" : "Нет"}",
                                        style: TextStyle(color: _ByDate ? Colors.green : Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Начальная дата: "),
                                    TextButton(
                                      onPressed: () async {
                                        await _selectStartDate(context);
                                        setState(() {});
                                      },
                                      child: Text("${_startDate.day}.${_startDate.month}.${_startDate.year}"),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Конечная дата: "),
                                    TextButton(
                                      onPressed: () async {
                                        await _selectEndDate(context);
                                        setState(() {});
                                      },
                                      child: Text("${_endDate.day}.${_endDate.month}.${_endDate.year}"),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  GetMotorStats(sessionData);
                                },
                                child: Text("Закрыть"),
                              ),
                            ],
                          );
                        });
                      });
                },
                icon: Icon(Icons.settings))
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: _stationStats.length > 0
          ? Row(
              children: [
                DGetDrawer(screenH, DrawerSize, context, Pages.Motors, sessionData),
                Container(
                  width: width,
                  height: height,
                  child: Column(
                    children: [
                      Container(
                        height: height,
                        width: width,
                        decoration: BoxDecoration(),
                        child: RawScrollbar(
                          thumbColor: Colors.grey,
                          controller: _scrollController,
                          isAlwaysShown: true,
                          thickness: 10,
                          radius: Radius.circular(5),
                          child: ListView(
                            controller: _scrollController,
                            padding: EdgeInsets.only(bottom: 10),
                            physics: PageScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children: List.generate(_stationStats.length, (index) {
                              return Container(
                                padding: EdgeInsets.all(8),
                                child: Container(
                                  height: height - 100,
                                  width: (width) / _Collumns - 16,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(color: Colors.black, blurRadius: 2.5),
                                    ],
                                  ),
                                  child: ListView(
                                    children: [
                                      Container(
                                        height: 25,
                                        child: Text(
                                          "Пост ${_stationStats[index].stationID}",
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
                                        children: _ProgramStat[index] ? ProgramsCollumn(index, (width - 16) / _Collumns / 3) : RelayCollumn(index, (width - 16) / _Collumns / 4),
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
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Row(
            children: [
              DGetDrawer(screenH, DrawerSize, context, Pages.Motors, sessionData),
              Container(
                  height: screenH,
                  width: width,
                  child: Center(
                    child: Text(
                      "Нет статистики по моторесурсу",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
            ],
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

  Future<Null> _selectStartDate(BuildContext context) async {
    {
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _startDate,
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
      );

      if (picked != null && picked != _startDate) {
        _startDate = picked;
      }
      setState(() {});
    }
  }

  Future<Null> _selectEndDate(BuildContext context) async {
    {
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _endDate,
        firstDate: DateTime(2020),
        lastDate: DateTime.now().add(
          new Duration(days: 1),
        ),
      );

      if (picked != null && picked != _endDate) {
        _endDate = picked;
        _endDate = _endDate.add(
          Duration(days: 1, seconds: -1),
        );
      }
    }
  }
}
