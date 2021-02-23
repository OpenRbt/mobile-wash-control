import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';

class AccountsMenuEditArgs {
  AccountInfo targetUser;
  SessionData sessionData;
}

class AccountsMenu extends StatefulWidget {
  @override
  _AccountsMenuState createState() => _AccountsMenuState();
}

class AccountInfo {
  String login;
  String firstName;
  String middleName;
  String lastName;
  bool isAdmin;
  bool isOperator;
  bool isEngineer;
  AccountInfo(this.login, this.firstName, this.middleName, this.lastName,
      this.isAdmin, this.isEngineer, this.isOperator);
}

class _AccountsMenuState extends State<AccountsMenu> {
  List<AccountInfo> _accounts = List();
  bool _firstLoad = true;

  void _getUsers(SessionData sessionData) async {
    _accounts = List();
    try {
      var res = await sessionData.client.getUsers();

      if (!mounted) {
        return;
      }
      for (int i = 0; i < res.users.length; i++) {
        _accounts.add(AccountInfo(
            res.users[i].login,
            res.users[i].firstName,
            res.users[i].middleName,
            res.users[i].lastName,
            res.users[i].isAdmin,
            res.users[i].isEngineer,
            res.users[i].isOperator));
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
      _getUsers(sessionData);
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
          return new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                    width: screenW > screenH ? screenW / 11 * 2 : 0,
                    child: Text(
                      screenW > screenH ? "Логин" : "",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width:
                        screenW > screenH ? screenW / 11 * 2 : screenW / 9 * 2,
                    child: Text(
                      "Фамилия",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width:
                        screenW > screenH ? screenW / 11 * 2 : screenW / 9 * 2,
                    child: Text("Имя",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 50,
                    width:
                        screenW > screenH ? screenW / 11 * 2 : screenW / 9 * 2,
                    child: Text("Отчество",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 50,
                    width:
                        screenW > screenH ? screenW / 11 * 2 : screenW / 9 * 2,
                    child: Text("Статус",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(
                height: screenH - appBar.preferredSize.height - 91,
                child: ListView(
                  children: List.generate(_accounts.length + 1, (index) {
                    if (index < _accounts.length) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 50,
                              width: screenW > screenH ? screenW / 11 * 2 : 0,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black38)),
                                child: Text(
                                  screenW > screenH
                                      ? "${_accounts[index].login}"
                                      : "",
                                  textAlign: TextAlign.center,
                                ),
                              )),
                          SizedBox(
                              height: 50,
                              width: screenW > screenH
                                  ? screenW / 11 * 2
                                  : screenW / 9 * 2,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black38)),
                                child: Text(
                                  "${_accounts[index].firstName}",
                                  textAlign: TextAlign.center,
                                ),
                              )),
                          SizedBox(
                              height: 50,
                              width: screenW > screenH
                                  ? screenW / 11 * 2
                                  : screenW / 9 * 2,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black38)),
                                child: Text(
                                  "${_accounts[index].lastName}",
                                  textAlign: TextAlign.center,
                                ),
                              )),
                          SizedBox(
                              height: 50,
                              width: screenW > screenH
                                  ? screenW / 11 * 2
                                  : screenW / 9 * 2,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black38)),
                                child: Text(
                                  "${_accounts[index].middleName}",
                                  textAlign: TextAlign.center,
                                ),
                              )),
                          SizedBox(
                              height: 50,
                              width: screenW > screenH
                                  ? screenW / 11 * 2
                                  : screenW / 9 * 2,
                              child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.black38)),
                                  child: Text(
                                    "${_accounts[index].isAdmin ? "Админ" : (_accounts[index].isOperator ? "Оператор" : (_accounts[index].isEngineer) ? "Инженер" : "USER")}",
                                    textAlign: TextAlign.center,
                                  ))),
                          SizedBox(
                              height: 50,
                              width: screenW > screenH
                                  ? screenW / 11
                                  : screenW / 9,
                              child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.black38)),
                                  child: IconButton(
                                    icon: Icon(Icons.more_horiz),
                                    onPressed: () {
                                      var args = AccountsMenuEditArgs();
                                      args.sessionData = sessionData;
                                      args.targetUser = _accounts[index];
                                      Navigator.pushNamed(
                                              context, "/home/accounts/edit",
                                              arguments: args)
                                          .then((value) =>
                                              _getUsers(sessionData));
                                    },
                                  ))),
                        ],
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 50,
                              width: screenW > screenH ? screenW / 11 * 2 : 0,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black38)),
                                child: Text(
                                  "",
                                  textAlign: TextAlign.center,
                                ),
                              )),
                          SizedBox(
                              height: 50,
                              width: screenW > screenH
                                  ? screenW / 11 * 2
                                  : screenW / 9 * 2,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black38)),
                                child: Text(
                                  "",
                                  textAlign: TextAlign.center,
                                ),
                              )),
                          SizedBox(
                              height: 50,
                              width: screenW > screenH
                                  ? screenW / 11 * 2
                                  : screenW / 9 * 2,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black38)),
                                child: Text(
                                  "",
                                  textAlign: TextAlign.center,
                                ),
                              )),
                          SizedBox(
                              height: 50,
                              width: screenW > screenH
                                  ? screenW / 11 * 2
                                  : screenW / 9 * 2,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black38)),
                                child: Text(
                                  "",
                                  textAlign: TextAlign.center,
                                ),
                              )),
                          SizedBox(
                              height: 50,
                              width: screenW > screenH
                                  ? screenW / 11 * 2
                                  : screenW / 9 * 2,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black38)),
                                child: Text(
                                  "",
                                  textAlign: TextAlign.center,
                                ),
                              )),
                          SizedBox(
                              height: 50,
                              width: screenW > screenH
                                  ? screenW / 11
                                  : screenW / 9,
                              child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.black38)),
                                  child: IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                              context, "/home/accounts/add",
                                              arguments: sessionData)
                                          .then((value) =>
                                              _getUsers(sessionData));
                                    },
                                  ))),
                        ],
                      );
                    }
                  }),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
