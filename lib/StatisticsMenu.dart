import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';

class StatisticsMenu extends StatefulWidget {
  @override
  _StatisticsMenuState createState() => _StatisticsMenuState();
}

class _StatisticsMenuState extends State<StatisticsMenu> {
  _StatisticsMenuState() : super();

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;

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
                              child: TextFormField(
                                onChanged: (s){print('1 ' + s);},
                                  onEditingComplete: (){print('2 ');},
                                  onFieldSubmitted: (s){print('3 ');},
                                  onSaved: (s){print('4 ' + s);},
                                  onTap: (){print('5 ');},
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
                              child: TextFormField(
                                  onChanged: (s){print('1 ' + s);},
                                  onEditingComplete: (){print('2 ');},
                                  onFieldSubmitted: (s){print('3 ');},
                                  onSaved: (s){print('4 ' + s);},
                                  onTap: (){print('5 ');},
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
                              onPressed: () {print('Pressed refresh button');},
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
                          ])
                        ]..addAll(List.generate(8, (index) {
                            return createTableRow(List.filled(6, ''));
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
