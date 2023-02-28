import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';

class AccountsMenuEditArgs {
  late AccountInfo targetUser;
  late SessionData sessionData;
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

  AccountInfo(this.login, this.firstName, this.middleName, this.lastName, this.isAdmin, this.isEngineer, this.isOperator);
}

class _AccountsMenuState extends State<AccountsMenu> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);

  List<AccountInfo> _accounts = [];
  bool _firstLoad = true;

  void _getUsers(SessionData sessionData) async {
    _accounts = [];
    try {
      var res = await sessionData.client.getUsers();

      if (!mounted) {
        return;
      }
      for (int i = 0; i < res.users.length; i++) {
        _accounts.add(
          AccountInfo(res.users[i].login, res.users[i].firstName, res.users[i].middleName, res.users[i].lastName, res.users[i].isAdmin, res.users[i].isEngineer, res.users[i].isOperator),
        );
      }
      _accounts.sort((a, b) => a.login.compareTo(b.login));
      setState(() {});
    } catch (e) {
      print("Exception when calling DefaultApi->/users: $e\n");
      showInfoSnackBar(context, _scaffoldKey, _isSnackBarActive, "Произошла ошибка при запросе к api", Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context)?.settings.arguments as SessionData;

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
      key: _scaffoldKey,
      appBar: appBar,
      drawer: prepareDrawer(context, Pages.Accounts, sessionData),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(
                Duration(milliseconds: 500),
              );
              _getUsers(sessionData);
            },
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
                        width: screenW > screenH ? screenW / 11 * 2 : 0,
                        child: Center(
                          child: Text(
                            screenW > screenH ? "Логин" : "",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: screenW > screenH ? screenW / 11 * 2 : screenW / 9 * 2,
                        child: Center(
                          child: Text(
                            "Фамилия",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: screenW > screenH ? screenW / 11 * 2 : screenW / 9 * 2,
                        child: Center(
                          child: Text(
                            "Имя",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: screenW > screenH ? screenW / 11 * 2 : screenW / 9 * 2,
                        child: Center(
                          child: Text(
                            "Отчество",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: screenW > screenH ? screenW / 11 * 2 : screenW / 9 * 2,
                        child: Center(
                          child: Text(
                            "Статус",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: List.generate(_accounts.length + 1, (index) {
                      if (index < _accounts.length) {
                        return _getAccountsRow(
                          screenW,
                          screenH,
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
                          screenW,
                          screenH,
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
          );
        },
      ),
    );
  }

  Widget _getAccountsRow(double screenW, double screenH, int index, SessionData sessionData, String login, String firstName, String lastName, String middleName, String status, bool addAction) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
          width: screenW > screenH ? screenW / 11 * 2 : 0,
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
          width: screenW > screenH ? screenW / 11 * 2 : screenW / 9 * 2,
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
          width: screenW > screenH ? screenW / 11 * 2 : screenW / 9 * 2,
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
          width: screenW > screenH ? screenW / 11 * 2 : screenW / 9 * 2,
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
          width: screenW > screenH ? screenW / 11 * 2 : screenW / 9 * 2,
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
          width: screenW > screenH ? screenW / 11 : screenW / 9,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: index % 2 == 0 ? Colors.white : Colors.black12,
              border: Border.all(color: Colors.black38),
            ),
            child: IconButton(
              icon: Icon(addAction ? Icons.add : Icons.more_horiz),
              onPressed: addAction
                  ? () {
                      Navigator.pushNamed(context, "/mobile/accounts/add", arguments: sessionData).then(
                        (value) => _getUsers(sessionData),
                      );
                    }
                  : () {
                      var args = AccountsMenuEditArgs();
                      args.sessionData = sessionData;
                      args.targetUser = _accounts[index];
                      Navigator.pushNamed(context, "/mobile/accounts/edit", arguments: args).then(
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
