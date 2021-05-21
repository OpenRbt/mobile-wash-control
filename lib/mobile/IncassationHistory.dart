import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';

class IncassationHistoryArgs {
  final int stationID;
  final SessionData sessionData;
  IncassationHistoryArgs(this.stationID, this.sessionData);
}

class IncassationHistory extends StatefulWidget {
  @override
  _IncassationHistoryState createState() => _IncassationHistoryState();
}

class _IncassationHistoryState extends State<IncassationHistory> {
  _IncassationHistoryState() : super();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);

  bool _firstLoad = true;
  bool _updating = false;

  DateTime _startDate = DateTime.now().add(
    new Duration(days: -31),
  );
  DateTime _endDate = DateTime.now().add(
    new Duration(days: 1, seconds: -1),
  );

  List<CollectionReportWithUser> _incassations = [];
  int _totalNal = 0;
  int _totalBeznal = 0;

  void _GetIncassation(IncassationHistoryArgs incassationHistoryArgs) async {
    if (_updating) {
      return;
    }
    print("FROM: $_startDate, TO: $_endDate");
    _updating = true;

    try {
      var args = StationCollectionReportDatesArgs();
      args.id = incassationHistoryArgs.stationID;
      args.startDate = _startDate.millisecondsSinceEpoch ~/ 1000;
      args.endDate = _endDate.millisecondsSinceEpoch ~/ 1000;
      _incassations =
        await incassationHistoryArgs.sessionData.client
          .stationCollectionReportDates(args);

      _totalNal = 0;
      _totalBeznal = 0;
      for (int i = 0; i < _incassations.length; i++) {
        _totalNal += (_incassations[i].banknotes ?? 0) + (_incassations[i].coins ?? 0);
        _totalBeznal += _incassations[i].electronical ?? 0;
      }
    }
    on ApiException catch (e) {
      if (e.code != 404) {
        print(
            "Exception when calling DefaultApi->/station-collection-report-dates: $e\n");
        showInfoSnackBar(_scaffoldKey, _isSnackBarActive,
            "Произошла ошибка при запросе к api", Colors.red);
      } else {}
    } catch (e) {
      if (!(e is ApiException)) {
        print("Other Exception: $e\n");
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
          print("NEW SELECTED: $_endDate");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    IncassationHistoryArgs incassationHistoryArgs =
        ModalRoute.of(context).settings.arguments;

    final AppBar appBar = AppBar(
      title: Text("История инкассаций | Пост ${incassationHistoryArgs.stationID}"),
    );

    if (_firstLoad) {
      _GetIncassation(incassationHistoryArgs);
      _firstLoad = false;
    }

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar,
      body: OrientationBuilder(
        builder: (context, orientation) {
          return RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(
                Duration(milliseconds: 500),
              );
              _GetIncassation(incassationHistoryArgs);
            },
            child: Container(
              width: screenW,
              height: screenH,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Период с ",
                        style: TextStyle(fontSize: 16),
                      ),
                      RaisedButton(
                        onPressed: () => _selectStartDate(context),
                        child: Text(
                            "${_startDate.day}.${_startDate.month}.${_startDate.year}"),
                      ),
                      Text(
                        " по ",
                        style: TextStyle(fontSize: 16),
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
                            _GetIncassation(incassationHistoryArgs);
                            setState(() {});
                          }),
                    ],
                  ),
                  SizedBox(height: 10),
                  Table(
                    border: TableBorder.all(
                        color: Colors.black,
                        width: 1,
                        style: BorderStyle.solid),
                    children: [
                      createTableRow([
                        'Дата/Время',
                        'Нал',
                        'Безнал',
                      ])
                    ]
                      ..addAll(
                        List.generate(_incassations.length, (index) {
                          return createTableRow([
                            formatDateTime(DateTime.fromMillisecondsSinceEpoch(_incassations[index].ctime * 1000)),
                            (_incassations[index].banknotes ?? 0) + (_incassations[index].coins ?? 0),
                            _incassations[index].electronical ?? 0,
                          ]);
                        }),
                      )
                      ..add(
                        createTableRow(["Итого", _totalNal, _totalBeznal]),
                      ),
                  ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
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

String formatDateTime(DateTime datetime){
  return "${datetime.year.toString()}-${datetime.month.toString().padLeft(2, '0')}-${datetime.day.toString().padLeft(2, '0')} ${datetime.hour.toString()}:${datetime.minute.toString()}:${datetime.second.toString()}";
}