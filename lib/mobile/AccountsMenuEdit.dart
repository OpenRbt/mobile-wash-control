import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'AccountsMenu.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import "package:mobile_wash_control/client/api.dart";

class AccountsMenuEdit extends StatefulWidget {
  @override
  _AccountsMenuEditState createState() => _AccountsMenuEditState();
}

class _AccountsMenuEditState extends State<AccountsMenuEdit> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);

  bool _notLoaded = true;
  bool _inUpdate = false;

  bool _loginNotValid = false;

  Map<String, TextEditingController> _inputControllers;

  List<bool> _inputTriggers = List.filled(3, false);

  void pageInit() {
    _inputControllers = {
      "login": new TextEditingController(),
      "firstName": new TextEditingController(),
      "lastName": new TextEditingController(),
      "middleName": new TextEditingController(),
    };
  }

  void initState() {
    super.initState();
    pageInit();
  }

  void dispose() {
    for (var controller in _inputControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _setData(AccountInfo accountInfo) {
    _inputControllers["login"].text = accountInfo.login;
    _inputControllers["firstName"].text = accountInfo.firstName;
    _inputControllers["lastName"].text = accountInfo.lastName;
    _inputControllers["middleName"].text = accountInfo.middleName;
    _inputTriggers[0] = accountInfo.isAdmin;
    _inputTriggers[1] = accountInfo.isOperator;
    _inputTriggers[2] = accountInfo.isEngineer;
    _notLoaded = false;

    setState(() {});
  }

  void _updateUser(SessionData sessionData, BuildContext context) async {
    _inUpdate = true;
    try {
      var args = ArgUserUpdate(
        login: _inputControllers["login"].value.text,
        firstName: _inputControllers["firstName"].value.text.isNotEmpty ? _inputControllers["firstName"].value.text : " ",
        lastName: _inputControllers["lastName"].value.text.isNotEmpty ? _inputControllers["lastName"].value.text : " ",
        middleName: _inputControllers["middleName"].value.text.isNotEmpty ? _inputControllers["middleName"].value.text : " ",
        isAdmin: _inputTriggers[0],
        isOperator: _inputTriggers[1],
        isEngineer: _inputTriggers[2],
      );

      var res = await sessionData.client.updateUser(args);
      showInfoSnackBar(context, _scaffoldKey, _isSnackBarActive, "Пользователь изменен", Colors.green);
    } on ApiException catch (e) {
      if (e.code == 403) {
        showInfoSnackBar(context, _scaffoldKey, _isSnackBarActive, "Недостаточно прав", Colors.orange);
      } else if (e.code == 404) {
        showInfoSnackBar(context, _scaffoldKey, _isSnackBarActive, "Невозможно изменить пользователя", Colors.orange);
      } else {
        showInfoSnackBar(context, _scaffoldKey, _isSnackBarActive, "Ошибка при запросе к апи", Colors.red);
      }
    } catch (e) {
      if (!(e is ApiException)) {
        showInfoSnackBar(context, _scaffoldKey, _isSnackBarActive, "Не удалось изменить пользователя", Colors.red);
      }
      print("Exception when calling DefaultApi->User(put): $e\n");
    }
    _inUpdate = false;
    setState(() {});
  }

  _AccountsMenuEditState() : super();

  @override
  Widget build(BuildContext context) {
    final AccountsMenuEditArgs accountsMenuEditArgs = ModalRoute.of(context).settings.arguments;

    if (_notLoaded) {
      _setData(accountsMenuEditArgs.targetUser);
    }
    final AppBar appBar = AppBar(
      title: Text("Редактирование пользователя"),
    );

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    if (_inUpdate) {
      _inUpdate = false;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Изменение пользователя"),
        ),
      );
    }
    return Scaffold(
      appBar: appBar,
      key: _scaffoldKey,
      body: OrientationBuilder(
        builder: (context, orientation) {
          return new ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                Row(
                  children: [
                    SizedBox(
                      height: 75,
                      width: screenW / 3,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Логин",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 75,
                      width: screenW - screenW / 3,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: _inputControllers["login"],
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(),
                          ),
                          enabled: false,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 75,
                      width: screenW / 3,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Имя",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 75,
                      width: screenW - screenW / 3,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: _inputControllers["firstName"],
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 75,
                      width: screenW / 3,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Фамилия",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 75,
                      width: screenW - screenW / 3,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: _inputControllers["lastName"],
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 75,
                      width: screenW / 3,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Отчество",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 75,
                      width: screenW - screenW / 3,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: _inputControllers["middleName"],
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 75,
                      width: screenW / 3,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Админ",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 75,
                      width: screenW - screenW / 3,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Checkbox(
                          value: _inputTriggers[0],
                          onChanged: (newValue) {
                            _inputTriggers[0] = !_inputTriggers[0];
                            setState(() {});
                          },
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 75,
                      width: screenW / 3,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Оператор",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 75,
                      width: screenW - screenW / 3,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Checkbox(
                          value: _inputTriggers[1],
                          onChanged: (newValue) {
                            _inputTriggers[1] = !_inputTriggers[1];
                            setState(() {});
                          },
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 75,
                      width: screenW / 3,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Инженер",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 75,
                      width: screenW - screenW / 3,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Checkbox(
                          value: _inputTriggers[2],
                          onChanged: (newValue) {
                            _inputTriggers[2] = !_inputTriggers[2];
                            setState(() {});
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ]),
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                spacing: 25,
                children: [
                  SizedBox(
                    height: 50,
                    width: screenW / 3,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.disabled)) { return Colors.grey; }
                            return Colors.lightGreen;
                          }),
                          foregroundColor: MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.disabled)) { return Colors.black; }
                            return Colors.white;
                          }),
                          overlayColor: MaterialStateProperty.all(Colors.lightGreenAccent)
                      ),
                      onPressed: _inUpdate
                          ? null
                          : () {
                              _updateUser(accountsMenuEditArgs.sessionData, context);
                            },
                      child: Text(_inUpdate ? "Сохранение..." : "Сохранить"),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: screenW / 3,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.disabled)) { return Colors.grey; }
                            return Colors.lightGreen;
                          }),
                          foregroundColor: MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.disabled)) { return Colors.black; }
                            return Colors.white;
                          }),
                          overlayColor: MaterialStateProperty.all(Colors.lightGreenAccent)
                      ),
                      onPressed: _inUpdate
                          ? null
                          : () {
                              _setData(accountsMenuEditArgs.targetUser);
                            },
                      child: Text("Отменить"),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: SizedBox(
                  height: 50,
                  width: screenW / 3 * 2,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.disabled)) { return Colors.grey; }
                            return Colors.red;
                          }),
                          foregroundColor: MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.disabled)) { return Colors.black; }
                            return Colors.white;
                          }),
                          overlayColor: MaterialStateProperty.all(Colors.redAccent)
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Удалить пользователя?"),
                            content: Text("Вы уверены?"),
                            actionsPadding: EdgeInsets.all(10),
                            actions: [
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                                      if (states.contains(MaterialState.disabled)) { return Colors.grey; }
                                      return Colors.lightGreen;
                                    }),
                                    foregroundColor: MaterialStateProperty.resolveWith((states) {
                                      if (states.contains(MaterialState.disabled)) { return Colors.black; }
                                      return Colors.white;
                                    }),
                                ),
                                onPressed: () async {
                                  bool success = false;
                                  try {
                                    var curUser = await accountsMenuEditArgs.sessionData.client.getUser();

                                    var args = ArgUserDelete(login: _inputControllers["login"].value.text);

                                    if (curUser.login != accountsMenuEditArgs.targetUser.login) {
                                      var res = await accountsMenuEditArgs.sessionData.client.deleteUser(args);
                                      success = true;
                                    } else {
                                      showInfoSnackBar(context, _scaffoldKey, _isSnackBarActive, "Вы не можете удалить сами себя", Colors.orange);
                                    }
                                  } on ApiException catch (e) {
                                    print(e);
                                    showInfoSnackBar(context, _scaffoldKey, _isSnackBarActive, "Произошла ошибка при запросе к api", Colors.redAccent);
                                  } catch (e) {
                                    print(e);
                                    if (!(e is ApiException)) {
                                      print("Other Exception: $e\n");
                                    }
                                  }
                                  Navigator.pop(context);
                                  if (success) Navigator.of(context).pop();
                                },
                                child: Text("Удалить"),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                                      if (states.contains(MaterialState.disabled)) { return Colors.grey; }
                                      return Colors.black;
                                    }),
                                    foregroundColor: MaterialStateProperty.resolveWith((states) {
                                      if (states.contains(MaterialState.disabled)) { return Colors.black; }
                                      return Colors.white;
                                    }),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Отмена"),
                              )
                            ],
                          ),
                        );
                      },
                      child: Text("Удалить пользователя"),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
