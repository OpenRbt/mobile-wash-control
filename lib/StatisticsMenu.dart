import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';

class StatisticsMenuArgs {}

class StatisticsMenu extends StatefulWidget {
  @override
  _StatisticsMenuState createState() => _StatisticsMenuState();
}

class _StatisticsMenuState extends State<StatisticsMenu> {
  _StatisticsMenuState() : super();
  SessionData sessionData;

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      title: Text("Статистика"),
    );

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
                          SizedBox(width: 5),
                          Expanded(
                              child: TextField(
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.0),
                                      ),
                                      hintText: "дата начала"))),
                          SizedBox(width: 5),
                          Text(" по ", style: TextStyle(fontSize: 16)),
                          SizedBox(width: 5),
                          Expanded(
                              child: TextField(
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.0),
                                      ),
                                      hintText: "дата конца"))),
                          SizedBox(width: 5),
                          RaisedButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.black)),
                              //textColor: Colors.white,
                              //disabledColor: Colors.grey,
                              //disabledTextColor: Colors.black,
                              onPressed: () {},
                              child: Text("обновить",
                                  style: TextStyle(fontSize: 18)))
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
                          ]),
                          createTableRow(List.filled(6, '')),
                          createTableRow(List.filled(6, '')),
                          createTableRow(List.filled(6, '')),
                          createTableRow(List.filled(6, '')),
                          createTableRow(List.filled(6, '')),
                          createTableRow(List.filled(6, '')),
                          createTableRow(List.filled(6, '')),
                          createTableRow(List.filled(6, '')),
                        ],
                      ),
                      SizedBox(height: 10),
                      Center(child: Text('Моторесурс', style: TextStyle(fontSize: 22))),
                      SizedBox(height: 5),
                      Center(child:
                      Wrap(children: [
                        createPack(1),
                        createPack(2),
                        createPack(3),
                        createPack(4),
                        createPack(5),
                        createPack(6),
                        createPack(7),
                        createPack(8),
                      ]))
                    ])));
          },
        ));
  }
}

Widget createPack(int number) {
  return Column(children: [
  Container(
      width: 80,
      height: 18,
  decoration: BoxDecoration(
  border: Border.all(color: Colors.black)
  ), child: Center(child:Text('пост ' + number.toString()))),
    Container(
      width: 80,
        height: 18,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black)
        ), child:  Center(child:Text(''))),
    Container(
        width: 80,
        height: 18,
        child:RaisedButton(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black)),
              color: Colors.white,
              disabledColor: Colors.white,
              onPressed: () {
                print("Pressed " + number.toString() + " post button");
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
