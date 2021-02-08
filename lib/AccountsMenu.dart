import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';

class AccountsMenuArgs {}

class AccountsMenu extends StatefulWidget {
  @override
  _AccountsMenuState createState() => _AccountsMenuState();
}

class _AccountsMenuState extends State<AccountsMenu> {
  _AccountsMenuState() : super();

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;

    final AppBar appBar = AppBar(
      title: Text("Учетки"),
    );

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar,
      drawer: prepareDrawer(context, Pages.Accounts, sessionData),
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
                        width: screenW / 3,
                        child: Text(
                          "Список пользователей",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: screenW / 3 - 20,
                        child: Text("Пароль",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        width: screenW / 3,
                        child: Text("Статус",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  Table(
                      border: TableBorder.all(),
                      defaultColumnWidth: FixedColumnWidth(screenW / 3 - 10),
                      children: List.generate(8, (index) {
                        return new TableRow(children: [
                          Text(
                            "Пользователь",
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "0000",
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            index % 2 == 0 ? "Активный" : "Неактивный",
                            textAlign: TextAlign.center,
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
