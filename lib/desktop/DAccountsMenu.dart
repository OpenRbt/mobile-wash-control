import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';

class DAccountsMenuEditArgs {
  AccountInfo targetUser;
  SessionData sessionData;
}

class DAccountsMenu extends StatefulWidget {
  @override
  _DAccountsMenuState createState() => _DAccountsMenuState();
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

class _DAccountsMenuState extends State<DAccountsMenu> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);

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
        _accounts.add(
          AccountInfo(
              res.users[i].login,
              res.users[i].firstName,
              res.users[i].middleName,
              res.users[i].lastName,
              res.users[i].isAdmin,
              res.users[i].isEngineer,
              res.users[i].isOperator),
        );
      }
      _accounts.sort((a, b) => a.login.compareTo(b.login));
      setState(() {});
    } catch (e) {
      print("Exception when calling DefaultApi->/users: $e\n");
      showInfoSnackBar(_scaffoldKey, _isSnackBarActive,
          "Произошла ошибка при запросе к api", Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;

    if (_firstLoad) {
      _getUsers(sessionData);
      _firstLoad = false;
    }

    var screenW = MediaQuery.of(context).size.width;
    var screenH = MediaQuery.of(context).size.height;

    double DrawerSize = 256;

    var width = screenW - DrawerSize;
    var height = screenH;

    return Scaffold(
      key: _scaffoldKey,
      body: OrientationBuilder(
        builder: (context, orientation) {
          return RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(
                  Duration(milliseconds: 500),
                );
                _getUsers(sessionData);
              },
              child: Row(
                children: [
                  DGetDrawer(
                      height,DrawerSize, context, Pages.Accounts, sessionData),
                  SizedBox(
                    height: height,
                    width: width,
                    child: ListView(children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 50,
                                width: width / 11 * 2,
                                child: Center(
                                  child: Text(
                                    "Логин",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                width: width / 11 * 2,
                                child: Center(
                                  child: Text(
                                    "Фамилия",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                width: width / 11 * 2,
                                child: Center(
                                  child: Text(
                                    "Имя",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                width: width / 11 * 2,
                                child: Center(
                                  child: Text(
                                    "Отчество",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                width: width / 11 * 2,
                                child: Center(
                                  child: Text(
                                    "Статус",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children:
                                List.generate(_accounts.length + 1, (index) {
                              if (index < _accounts.length) {
                                return _getAccountsRow(
                                  width,
                                  height,
                                  index,
                                  sessionData,
                                  _accounts[index].login,
                                  _accounts[index].firstName,
                                  _accounts[index].lastName,
                                  _accounts[index].middleName,
                                  _accounts[index].isAdmin
                                      ? "Админ"
                                      : (_accounts[index].isOperator
                                          ? "Оператор"
                                          : (_accounts[index].isEngineer)
                                              ? "Инженер"
                                              : "USER"),
                                  false,
                                );
                              } else {
                                return _getAccountsRow(
                                  width,
                                  height,
                                  index,
                                  sessionData,
                                  "",
                                  "",
                                  "",
                                  "",
                                  "",
                                  true,
                                );
                              }
                            }),
                          ),
                        ],
                      )
                    ]),
                  ),
                ],
              ));
        },
      ),
    );
  }

  Widget _getAccountsRow(
      double width,
      double height,
      int index,
      SessionData sessionData,
      String login,
      String firstName,
      String lastName,
      String middleName,
      String status,
      bool addAction) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
          width: width / 11 * 2,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: index % 2 == 0 ? Colors.white : Colors.black12,
              border: Border.all(color: Colors.black38),
            ),
            child: Text(
              login,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          height: 50,
          width: width / 11 * 2,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: index % 2 == 0 ? Colors.white : Colors.black12,
              border: Border.all(color: Colors.black38),
            ),
            child: Text(
              lastName,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          height: 50,
          width: width / 11 * 2,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: index % 2 == 0 ? Colors.white : Colors.black12,
              border: Border.all(color: Colors.black38),
            ),
            child: Text(
              firstName,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          height: 50,
          width: width / 11 * 2,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: index % 2 == 0 ? Colors.white : Colors.black12,
              border: Border.all(color: Colors.black38),
            ),
            child: Text(
              middleName,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          height: 50,
          width: width / 11 * 2,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: index % 2 == 0 ? Colors.white : Colors.black12,
              border: Border.all(color: Colors.black38),
            ),
            child: Text(
              status,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          height: 50,
          width: width / 11,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: index % 2 == 0 ? Colors.white : Colors.black12,
              border: Border.all(color: Colors.black38),
            ),
            child: IconButton(
              icon: Icon(addAction ? Icons.add : Icons.more_horiz),
              onPressed: addAction
                  ? () {
                      Navigator.pushNamed(context, "/desktop/accounts/add",
                              arguments: sessionData)
                          .then(
                        (value) => _getUsers(sessionData),
                      );
                    }
                  : () {
                      var args = DAccountsMenuEditArgs();
                      args.sessionData = sessionData;
                      args.targetUser = _accounts[index];
                      Navigator.pushNamed(context, "/desktop/accounts/edit",
                              arguments: args)
                          .then(
                        (value) => _getUsers(sessionData),
                      );
                    },
            ),
          ),
        ),
      ],
    );
  }
}
