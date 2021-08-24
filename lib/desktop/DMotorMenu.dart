import 'package:flutter/material.dart';
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

  bool _firstLoad = true;
  bool _updating = false;

  List<StationStat> _stationStats = new List();

  void GetMotorStats(SessionData sessionData) async {
    if (_updating) {
      return;
    }
    _updating = true;
    try {
      var args = ArgStationStat();
      _stationStats = await sessionData.client.stationStatCurrent(args: args);
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
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Text(
                                              "Пост ${index + 1}",
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: List.generate(_stationStats[index].programStats.length, (programIndex) {
                                              return Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    child: Text(
                                                      "${_stationStats[index].programStats[programIndex].programName}",
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    child: Text(
                                                      "${_stationStats[index].programStats[programIndex].timeOn} сек",
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                          ),
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
}

Widget createMoto(int number) {
  return Column(children: [
    Container(
      width: 60,
      height: 18,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Center(
        child: Text(
          'пост ' + number.toString(),
        ),
      ),
    ),
    Container(
      width: 60,
      height: 18,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Center(
        child: Text(''),
      ),
    ),
    Container(
      width: 60,
      height: 18,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black),
        ),
        color: Colors.white,
        disabledColor: Colors.white,
        onPressed: () {
          print("Pressed " + number.toString() + " post reset button");
        },
        child: Text(
          "сброс",
          style: TextStyle(fontSize: 16),
        ),
      ),
    ),
    SizedBox(height: 20)
  ]);
}

TableRow createTableRow(List values) {
  List<TableCell> result = [];
  for (var val in values) {
    result.add(
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(
          child: Text(
            val.toString(),
          ),
        ),
      ),
    );
  }
  return TableRow(children: result);
}
