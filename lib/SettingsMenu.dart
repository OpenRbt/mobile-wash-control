import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';

class SettingsMenuArgs {}

class SettingsMenu extends StatefulWidget {
  @override
  _SettingsMenuState createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  _SettingsMenuState() : super();
  SessionData sessionData;

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      title: Text("Настройки"),
    );

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar,
      drawer: prepareDrawer(context, Pages.Settings, sessionData),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return new ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                        width: screenW / 3,
                        child: Text("Дата "),
                      ),
                      SizedBox(
                        height: 50,
                        width: screenW / 3,
                        child: Text("Время "),
                      ),
                      SizedBox(
                        height: 50,
                        width: screenW / 3,
                        child: Text("Темп "),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 110,
                        child: Text(
                          "Список постов",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 110,
                        child: Text("Адрес",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        width: 110,
                        child: Text("Статус",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  Table(
                      border: TableBorder.all(),
                      defaultColumnWidth: FixedColumnWidth(110),
                      children: List.generate(8, (index) {
                        return new TableRow(children: [

                          Text(" Пост $index"),
                          Text(
                            "192.168.0.16$index",
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            index % 2 == 0 ? "Активный" : "Неактивный",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color:
                                    index % 2 == 0 ? Colors.green : Colors.red),
                          )
                        ]);
                      })),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                          width: screenW / 3,
                          child: RaisedButton(
                            color: Colors.lightGreen,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            padding: EdgeInsets.all(8.0),
                            splashColor: Colors.lightGreenAccent,
                            onPressed: () {},
                            child: Text("Сохранить",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(
                          width: screenW / 6,
                        ),
                        SizedBox(
                          height: 50,
                          width: screenW / 3,
                          child: RaisedButton(
                            color: Colors.lightGreen,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            padding: EdgeInsets.all(8.0),
                            splashColor: Colors.lightGreenAccent,
                            onPressed: () {},
                            child: Text("Отменить",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          ),
                        )
                      ])
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
