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
  Map<int, StationReport> _reports = new Map();

  StationReport _total = StationReport();

  void _GetStatistics(SessionData sessionData) async {
    if (_updating) {
      return;
    }
    _updating = true;
    List<Future<StationReport>> reportsTmp = new List();
    for (int i = 0; i < 12; i++) {
      try {
        var args = StationReportCurrentMoneyArgs();
        args.id = i + 1;
        reportsTmp.add(
          sessionData.client.stationReportCurrentMoney(args),
        );
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
    }

    for (int i = 0; i < reportsTmp.length; i++) {
      try {
        _reports.addAll({(i + 1): (await reportsTmp[i] ?? StationReport())});
      } on ApiException catch (e) {
        if (e.code != 404) {
          print("Exception when calling DefaultApi->/station-report-dates: $e\n");
          showInfoSnackBar(_scaffoldKey, _isSnackBarActive, "Произошла ошибка при запросе к api", Colors.red);
        } else {
          var tmp = StationReport();
          tmp.moneyReport = MoneyReport();
          tmp.moneyReport.banknotes = 0;
          tmp.moneyReport.coins = 0;
          tmp.moneyReport.electronical = 0;
          tmp.moneyReport.service = 0;
          tmp.moneyReport.carsTotal = 0;
          _reports.addAll({(i + 1): tmp});
        }
      } catch (e) {
        if (!(e is ApiException)) {
          print("Other Exception: $e\n");
        }
      }
    }
    print("Recieved reports: ${_reports.length}");

    _total = StationReport();
    _total.moneyReport = MoneyReport();
    _total.moneyReport.banknotes = 0;
    _total.moneyReport.coins = 0;
    _total.moneyReport.electronical = 0;
    _total.moneyReport.service = 0;
    _total.moneyReport.carsTotal = 0;

    for (int i = 0; _reports != null && i < _reports.length; i++) {
      if (_reports[i] != null) {
        _total.moneyReport.banknotes += _reports[i].moneyReport.banknotes ?? 0;
        _total.moneyReport.coins += _reports[i].moneyReport.coins ?? 0;
        _total.moneyReport.electronical += _reports[i].moneyReport.electronical ?? 0;
        _total.moneyReport.service += _reports[i].moneyReport.service ?? 0;
        _total.moneyReport.carsTotal += _reports[i].moneyReport.carsTotal ?? 0;
      }
    }

    if (!mounted) {
      return;
    }

    _updating = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;

    final AppBar appBar = AppBar(
      title: Text("Моторесурс"),
    );

    if (_total.moneyReport == null) {
      _total.moneyReport = MoneyReport();
      _total.moneyReport.banknotes = 0;
      _total.moneyReport.coins = 0;
      _total.moneyReport.electronical = 0;
      _total.moneyReport.service = 0;
      _total.moneyReport.carsTotal = 0;
    }
    if (_firstLoad) {
      _GetStatistics(sessionData);
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
              _GetStatistics(sessionData);
            },
            child: Container(
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
                          children: List.generate(_reports.length, (index) {
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
                                      children: List.generate(15, (index) {
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              child: Text(
                                                "Some info $index:",
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              child: Text("${(index + 1) * 100} сек"),
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
