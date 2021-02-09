import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'client/api.dart';

class StatisticsMenu extends StatefulWidget {
  @override
  _StatisticsMenuState createState() => _StatisticsMenuState();
}

class _StatisticsMenuState extends State<StatisticsMenu> {
  _StatisticsMenuState() : super();
  bool _firstLoad = true;
  bool _updating = false;
  List<StationReport> _reports = new List();
  DateTime _startDate = DateTime.now().add(new Duration(days: -31));
  DateTime _endDate = DateTime.now();

  void _GetStatistics(SessionData sessionData) async {
    if (_updating) {
      return;
    }
    _updating = true;
    List<Future<StationReport>> reportsTmp = new List();
    List<StationReport> reports = new List();
    for (int i = 0; i < 8; i++) {
      try {
        var args = Args();
        args.id = i + 1;
        args.startDate = (_startDate.millisecondsSinceEpoch/1000).toInt();
        args.endDate = (_endDate.millisecondsSinceEpoch/1000).toInt();
        print("${args.startDate} | ${args.endDate}");
        reportsTmp.add(sessionData.client.stationReportDates(args));
      } catch (e) {}
    }

    for (int i = 0; i < reportsTmp.length; i++) {
      try {
        reports.add(await reportsTmp[i]);
      } catch (e) {
        print("Exception when calling DefaultApi->/station-report-dates:");
      }
    }
    print("Recieved reports: ${reports.length}");
    if (!mounted) {
      return;
    }

    setState(() {
      _reports = reports;
    });
    _updating = false;
  }

  Future<Null> _selectStartDate(BuildContext context) async {
    {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: _startDate,
          firstDate: DateTime.now().add(new Duration(days: -365)),
          lastDate: DateTime.now().add(new Duration(days: 1)));

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
          firstDate: DateTime.now().add(new Duration(days: -365)),
          lastDate: DateTime.now().add(new Duration(days: 1)));

      if (!mounted) {
        return;
      }
      setState(() {
        if (picked != null && picked != _endDate) {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;

    final AppBar appBar = AppBar(
      title: Text("Статистика"),
    );

    if (_firstLoad){
      _GetStatistics(sessionData);
      _firstLoad = false;
    }

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: appBar,
        drawer: prepareDrawer(context, Pages.Statistics, sessionData),
        body: OrientationBuilder(
          builder: (context, orientation) {
            return new Container(
                width: screenW,
                height: screenH,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Период с ", style: TextStyle(fontSize: 16)),
                          RaisedButton(
                            onPressed: () => _selectStartDate(context),
                            child: Text(
                                "${_startDate.day}.${_startDate.month}.${_startDate.year}"),
                          ),
                          Text(" по ", style: TextStyle(fontSize: 16)),

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
                                _GetStatistics(sessionData);
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
                            'пост',
                            'наличные',
                            'банк. карта',
                            'сервисные',
                            'авто',
                            'ср. чек'
                          ])
                        ]..addAll(List.generate(_reports.length, (index) {
                            return createTableRow([index+1,_reports[index].moneyReport.banknotes,_reports[index].moneyReport.electronical,_reports[index].moneyReport.service, _reports[index].moneyReport.carsTotal, 0]);
                          })),
                      ),
                      SizedBox(height: 10),
                      Center(
                          child: Text('Моторесурс',
                              style: TextStyle(fontSize: 22))),
                      SizedBox(height: 5),
                      Center(
                          child: Wrap(
                              children: List.generate(
                                  8, (index) => createMoto(index + 1))))
                    ])));
          },
        ));
  }
}

Widget createMoto(int number) {
  return Column(children: [
    Container(
        width: 80,
        height: 18,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Center(child: Text('пост ' + number.toString()))),
    Container(
        width: 80,
        height: 18,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Center(child: Text(''))),
    Container(
        width: 80,
        height: 18,
        child: RaisedButton(
            shape:
                RoundedRectangleBorder(side: BorderSide(color: Colors.black)),
            color: Colors.white,
            disabledColor: Colors.white,
            onPressed: () {
              print("Pressed " + number.toString() + " post reset button");
            },
            child: Text("сброс", style: TextStyle(fontSize: 16)))),
    SizedBox(height: 20)
  ]);
}

TableRow createTableRow(List values) {
  List<TableCell> result = [];
  for (var val in values) {
    result.add(TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Center(child: Text(val.toString())),
    ));
  }
  return TableRow(children: result);
}