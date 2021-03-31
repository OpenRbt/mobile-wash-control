import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';

class DStatisticsPage extends StatefulWidget {
  @override
  _DStatisticsPageState createState() => _DStatisticsPageState();
}

class _DStatisticsPageState extends State<DStatisticsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);

  bool _byDate = false;

  bool _firstLoad = true;
  bool _updating = false;
  Map<int, StationReport> _reports = new Map();

  StationReport _total = StationReport();

  DateTime _startDate = DateTime.now().add(
    new Duration(days: -31),
  );
  DateTime _endDate = DateTime.now().add(
    new Duration(days: 1, seconds: -1),
  );

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;

    if (_total.moneyReport == null) {
      _total.moneyReport = MoneyReport();
      _total.moneyReport.banknotes = 0;
      _total.moneyReport.coins = 0;
      _total.moneyReport.electronical = 0;
      _total.moneyReport.service = 0;
      _total.moneyReport.carsTotal = 0;
    }
    if (_firstLoad) {
      _getStatistics(sessionData);
      _firstLoad = false;
    }

    var screenW = MediaQuery.of(context).size.width;
    var screenH = MediaQuery.of(context).size.height;
    screenW = screenW > 1280 ? screenW / 4 * 3 : 960;

    return Scaffold(
      key: _scaffoldKey,
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Период с ",
                  style: TextStyle(fontSize: 32),
                ),
                RaisedButton(
                  onPressed: () => _selectStartDate(context),
                  child: Text(
                      "${_startDate.day}.${_startDate.month}.${_startDate.year}"),
                ),
                Text(
                  " по ",
                  style: TextStyle(fontSize: 32),
                ),
                RaisedButton(
                  onPressed: () => _selectEndDate(context),
                  child: Text(
                      "${_endDate.day}.${_endDate.month}.${_endDate.year}"),
                ),
                IconButton(
                    icon: Icon(
                      Icons.update,
                      color: _updating ? Colors.yellow : Colors.green,
                    ),
                    onPressed: () {
                      _getStatistics(sessionData);
                      setState(() {});
                    }),
              ],
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Вывод: ",
                  style: TextStyle(fontSize: 32),
                ),
                SizedBox(
                  width: screenW / 3 * 2,
                  child: DropdownButton(
                      isExpanded: true,
                      value: _byDate,
                      items: [
                        DropdownMenuItem(
                          value: false,
                          child: Text("С последней инкассации"),
                        ),
                        DropdownMenuItem(
                          value: true,
                          child: Text("По датам"),
                        )
                      ],
                      onChanged: (newValue) {
                        _byDate = newValue;
                        setState(() {});
                      }),
                )
              ],
            ),
            SizedBox(height: 25),
            SizedBox(
              width: screenW / 5 * 4,
              child: Table(
                border: TableBorder.all(
                    color: Colors.black, width: 1, style: BorderStyle.solid),
                children: [
                  createTableRow([
                    'пост',
                    'наличные',
                    'банк. карта',
                    'сервисные',
                    'авто',
                    'ср. чек'
                  ])
                ]
                  ..addAll(
                    List.generate(_reports.length, (index) {
                      return createTableRow([
                        _reports.keys.elementAt(index),
                        (_reports.values
                                    .elementAt(index)
                                    .moneyReport
                                    .banknotes ??
                                0) +
                            (_reports.values
                                    .elementAt(index)
                                    .moneyReport
                                    .coins ??
                                0),
                        _reports.values
                                .elementAt(index)
                                .moneyReport
                                .electronical ??
                            0,
                        _reports.values.elementAt(index).moneyReport.service ??
                            0,
                        _reports.values
                                .elementAt(index)
                                .moneyReport
                                .carsTotal ??
                            0,
                        (_reports.values
                                        .elementAt(index)
                                        .moneyReport
                                        .carsTotal !=
                                    null &&
                                _reports.values
                                        .elementAt(index)
                                        .moneyReport
                                        .carsTotal >
                                    0)
                            ? ((((_reports.values
                                                .elementAt(index)
                                                .moneyReport
                                                .banknotes ??
                                            0) +
                                        (_reports.values
                                                .elementAt(index)
                                                .moneyReport
                                                .coins ??
                                            0) +
                                        (_reports.values
                                                .elementAt(index)
                                                .moneyReport
                                                .electronical ??
                                            0) +
                                        (_reports.values
                                                .elementAt(index)
                                                .moneyReport
                                                .service ??
                                            0)) /
                                    _reports.values
                                        .elementAt(index)
                                        .moneyReport
                                        .carsTotal))
                                .toStringAsFixed(2)
                            : 0
                      ]);
                    }),
                  )
                  ..add(
                    createTableRow([
                      "Итого",
                      _total.moneyReport.banknotes + _total.moneyReport.coins,
                      _total.moneyReport.electronical,
                      _total.moneyReport.service,
                      _total.moneyReport.carsTotal,
                      _total.moneyReport.carsTotal > 0
                          ? ((_total.moneyReport.banknotes +
                                      _total.moneyReport.coins +
                                      _total.moneyReport.electronical +
                                      _total.moneyReport.service) /
                                  _total.moneyReport.carsTotal)
                              .toStringAsFixed(2)
                          : 0,
                    ]),
                  ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Моторесурс',
                style: TextStyle(fontSize: 32),
              ),
            ),
            SizedBox(height: 5),
            Center(
              child: Wrap(
                children: List.generate(
                  8,
                  (index) => createMoto(index + 1),
                ),
              ),
            )
          ]);
        },
      ),
    );
  }

  void _getStatistics(SessionData sessionData) async {
    if (_updating) {
      return;
    }
    print("FROM: $_startDate, TO: $_endDate");
    _updating = true;
    List<Future<StationReport>> reportsTmp = new List();
    for (int i = 0; i < 12; i++) {
      try {
        if (_byDate) {
          var args = StationReportDatesArgs();
          args.id = i + 1;
          args.startDate = _startDate.millisecondsSinceEpoch ~/ 1000;
          args.endDate = _endDate.millisecondsSinceEpoch ~/ 1000;
          reportsTmp.add(
            sessionData.client.stationReportDates(args),
          );
        } else {
          var args = StationReportCurrentMoneyArgs();
          args.id = i + 1;
          reportsTmp.add(
            sessionData.client.stationReportCurrentMoney(args),
          );
        }
      } on ApiException catch (e) {
        if (e.code != 404) {
          print(
              "Exception when calling DefaultApi->/station-report-dates: $e\n");
          showInfoSnackBar(_scaffoldKey, _isSnackBarActive,
              "Произошла ошибка при запросе к api", Colors.red);
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
          print(
              "Exception when calling DefaultApi->/station-report-dates: $e\n");
          showInfoSnackBar(_scaffoldKey, _isSnackBarActive,
              "Произошла ошибка при запросе к api", Colors.red);
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
        _total.moneyReport.banknotes += _reports[i].moneyReport.banknotes;
        _total.moneyReport.coins += _reports[i].moneyReport.coins;
        _total.moneyReport.electronical += _reports[i].moneyReport.electronical;
        _total.moneyReport.service += _reports[i].moneyReport.service;
        _total.moneyReport.carsTotal += _reports[i].moneyReport.carsTotal;
      }
    }

    if (!mounted) {
      return;
    }

    _updating = false;
    setState(() {});
  }

  Future<Null> _selectStartDate(BuildContext context) async {
    {
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _startDate,
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
      );

      if (!mounted) {
        return;
      }
      setState(() {
        if (picked != null && picked != _startDate) {
          _startDate = picked;
        }
      });
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

      if (!mounted) {
        return;
      }
      setState(() {
        if (picked != null && picked != _endDate) {
          _endDate = picked;
          _endDate = _endDate.add(
            Duration(days: 1, seconds: -1),
          );
          print("NEW SELECTD: $_endDate");
        }
      });
    }
  }

  Widget createMoto(int number) {
    return Column(children: [
      Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            'пост ' + number.toString(),
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
      Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(''),
        ),
      ),
      Container(
        width: 100,
        height: 50,
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
            style: TextStyle(fontSize: 24),
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
            child: SizedBox(
              height: 25,
              child: Center(
                child: Text(
                  val.toString(),
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            )),
      );
    }
    return TableRow(children: result);
  }
}