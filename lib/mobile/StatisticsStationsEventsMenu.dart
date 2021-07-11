import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';

class StatisticsStationsEventsMenu extends StatefulWidget {
  @override
  _StatisticsStationsEventsMenuState createState() =>
      _StatisticsStationsEventsMenuState();
}

class _StatisticsStationsEventsMenuState
    extends State<StatisticsStationsEventsMenu> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);

  bool _firstLoad = true;
  bool _updating = false;

  DateTime _startDate = DateTime.now().add(
    new Duration(days: -1),
  );
  DateTime _endDate = DateTime.now().add(
    new Duration(days: 1, seconds: -1),
  );

  Map<int, StationEventReport> _eventsReports = Map();

  final List<String> dropDownNames = [
    "Краткий отчет",
    "Пост 1",
    "Пост 2",
    "Пост 3",
    "Пост 4",
    "Пост 5",
    "Пост 6",
    "Пост 7",
    "Пост 8",
    "Пост 9",
    "Пост 10",
    "Пост 11",
    "Пост 12"
  ];
  final List<int> dropDownValues = List.generate(13, (index) {
    return index;
  });
  int _dropdownValue = 0;

  void _GetEvents(SessionData sessionData) async {
    if (_updating) {
      return;
    }
    _updating = true;
    List<Future<StationEventReport>> tmpReports = List();
    for (int i = 1; i <= 12; i++) {
      try {
        var args = StationEventsByDateArgs();
        args.stationID = i;
        args.startDate = _startDate.millisecondsSinceEpoch ~/ 1000;
        args.endDate = _endDate.millisecondsSinceEpoch ~/ 1000;
        tmpReports.add(sessionData.client.stationEventsByDate(args));
      } on ApiException catch (e) {
        if (e.code != 404) {
          print(
              "Exception when calling DefaultApi->/station-events-report-dates: $e\n");
          showInfoSnackBar(_scaffoldKey, _isSnackBarActive,
              "Произошла ошибка при запросе к api", Colors.red);
        } else {}
      }
    }
    Map<int, StationEventReport> reports = Map();
    for (int i = 0; i < tmpReports.length; i++) {
      try {
        reports
            .addAll({(i + 1): (await tmpReports[i] ?? StationEventReport())});
      } on ApiException catch (e) {
        if (e.code != 404) {
          print(
              "Exception when calling DefaultApi->/station-report-dates: $e\n");
          showInfoSnackBar(_scaffoldKey, _isSnackBarActive,
              "Произошла ошибка при запросе к api", Colors.red);
        } else {
          var tmp = StationEventReport();
          tmp.events = List();
          reports.addAll({(i + 1): tmp});
        }
      } catch (e) {
        if (!(e is ApiException)) {
          print("Other Exception: $e\n");
        }
      }
      reports[i + 1].events.sort((a, b) => b.ctime.compareTo(a.ctime));
    }
    _eventsReports = reports;
    setState(() {});
    _updating = false;
  }

  Future<Null> _selectDateRange(BuildContext context) async {
    {
      final DateTimeRange range = await showDateRangePicker(
          context: context,
          firstDate: DateTime(2020),
          lastDate: DateTime.now().add(Duration(days: 1)));

      if (!mounted || range == null) {
        return;
      }
      setState(() {
        _startDate = range.start;
        _endDate = range.end;
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

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;

    if (_firstLoad) {
      _firstLoad = false;
      _GetEvents(sessionData);
    }

    final AppBar appBar = AppBar(
      title: Text("Статистика событий"),
    );

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    double height = screenH - appBar.preferredSize.height;
    return Scaffold(
      appBar: appBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: screenW,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Период:",
                  style: TextStyle(fontSize: 16),
                ),
                RaisedButton(
                  onPressed: () => _selectDateRange(context),
                  child: Text(
                      "${_startDate.day}.${_startDate.month}.${_startDate.year} - ${_endDate.day}.${_endDate.month}.${_endDate.year}"),
                ),
                IconButton(
                  icon: Icon(
                    Icons.update,
                    color: _updating ? Colors.yellow : Colors.green,
                  ),
                  onPressed: () {
                    _GetEvents(sessionData);
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          SizedBox(
              height: 50,
              width: screenW,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(blurRadius: 1.5)]),
                child: SizedBox(
                  child: DropdownButton(
                    value: _dropdownValue,
                    items: List.generate(dropDownNames.length, (index) {
                      return DropdownMenuItem(
                        child: Text(" - " + dropDownNames[index]),
                        value: dropDownValues[index],
                      );
                    }),
                    isExpanded: true,
                    isDense: false,
                    onChanged: (newVal) {
                      _dropdownValue = newVal;
                      setState(() {});
                    },
                  ),
                ),
              )),
          _GetReportsTable(_dropdownValue, height - 100 - 41, screenW)
        ],
      ),
    );
  }

  Widget _GetReportsTable(int stationID, double h, double w) {
    return SizedBox(
      height: h,
      width: w,
      child: stationID != 0
          ? Column(
              children: [
                _createWidgetTableRow(
                    ["Модуль", "Статус", "Инфо", "Дата"], 50, w,
                    customCollumnSize: {0: 75, 1: 75, 3: 150}),
                SizedBox(
                  height: h - 50,
                  width: w,
                  child: ListView.builder(
                      itemCount: _eventsReports[stationID]?.events?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        StationEvent event =
                            _eventsReports[stationID].events[index];
                        DateTime time = DateTime.fromMillisecondsSinceEpoch(
                            (event.ctime ?? 0) * 1000);
                        return _createWidgetTableRow(
                            [
                              "${event.module ?? ""}",
                              "${event.status}",
                              "${event.info ?? ""}",
                              "${event.ctime != null ? DateFormat('dd.MM.yyyy HH:mm:ss').format(time) : ""}",
                            ],
                            25,
                            w,
                            customCollumnSize: {0: 75, 1: 75, 3: 150},
                            borderColor: Colors.grey,
                            centerText: false);
                      }),
                )
              ],
            )
          : ListView(
              children: [
                _createWidgetTableRow(
                    ["ПОСТ", "OK", "WARNING", "ERROR", "CRITICAL"], 50, w),
              ]..addAll(
                  List.generate(
                    12,
                    (index) {
                      return _createWidgetTableRow([
                        "${index + 1}",
                        "${_eventsReports[index + 1]?.events?.where((element) => element.status == "OK")?.length ?? 0}",
                        "${_eventsReports[index + 1]?.events?.where((element) => element.status == "WARNING")?.length ?? 0}",
                        "${_eventsReports[index + 1]?.events?.where((element) => element.status == "ERROR")?.length ?? 0}",
                        "${_eventsReports[index + 1]?.events?.where((element) => element.status == "CRITICAL")?.length ?? 0}"
                      ], 25, w, borderColor: Colors.grey);
                    },
                  ),
                ),
            ),
    );
  }

  Widget _createWidgetTableRow(List<String> values, double height, double width,
      {bool centerText = true,
      bool centerFirst = true,
      Map<int, double> customCollumnSize,
      Color borderColor = Colors.black}) {
    if (customCollumnSize == null) {
      customCollumnSize = Map();
    }
    return Row(
      children: List.generate(values.length, (index) {
        return customCollumnSize[index] != null
            ? Container(
                height: height,
                width: customCollumnSize[index],
                decoration:
                    BoxDecoration(border: Border.all(color: borderColor)),
                child: centerText || (centerFirst && index == 0)
                    ? Center(
                        child: Text(values[index]),
                      )
                    : Text(
                        values[index],
                        textAlign: TextAlign.center,
                      ),
              )
            : Expanded(
                child: Container(
                  height: height,
                  decoration:
                      BoxDecoration(border: Border.all(color: borderColor)),
                  child: centerText || (centerFirst && index == 0)
                      ? Center(
                          child: Text(values[index]),
                        )
                      : Text(
                          values[index],
                        ),
                ),
              );
      }),
    );
  }

  TableRow _createTableRow(List<String> values,
      {double rowHeight = 25.0,
      bool centerText = true,
      bool centerFirst = true}) {
    List<TableCell> result = [];
    int i = 0;
    for (var val in values) {
      result.add(
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: SizedBox(
            height: rowHeight,
            child: centerText || (centerFirst && i == 0)
                ? Center(
                    child: Text(val),
                  )
                : Text(
                    val,
                    textAlign: TextAlign.center,
                  ),
          ),
        ),
      );
      i++;
    }
    return TableRow(children: result);
  }
}
