import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';

class AccountsMenuArgs {}

class AccountsMenu extends StatefulWidget {
  @override
  _AccountsMenuState createState() => _AccountsMenuState();
}

class AccountInfo {
  String User;
  String Pin;
  String Status;
  AccountInfo(this.User, this.Pin, this.Status);
}

class _AccountsMenuState extends State<AccountsMenu> {
  List<AccountInfo> _accounts = List();
  bool _firstLoad = true;

  void GetUsers(SessionData sessionData) async {
    try {
      var res = await sessionData.client.getUsers();

      if (!mounted) {
        return;
      }
      for (var user in res.users) {
        _accounts.add(AccountInfo(
            "${user.login} | ${user.lastName} ${user.lastName} ${user.firstName} ${user.middleName}",
            "TODO",
            "TODO"));
      }

      setState(() {});
    } catch (e) {
      print("Exception when calling DefaultApi->/users: $e\n");
    }
  }

  _AccountsMenuState() : super();

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;

    if (_firstLoad) {
      GetUsers(sessionData);
      _firstLoad = false;
    }

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
                      children: List.generate(_accounts.length, (index) {
                        return new TableRow(children: [
                          Text(
                            "${_accounts[index].User}",
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "${_accounts[index].Pin}",
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "${_accounts[index].Status}",
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
