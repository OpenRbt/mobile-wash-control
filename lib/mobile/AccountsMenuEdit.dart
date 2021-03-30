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
  List<TextEditingController> _inputControllers;
  List<bool> _inputTriggers = List.filled(3, false);

  void initState() {
    super.initState();
    _inputControllers = List.generate(4, (index) {
      var controller = new TextEditingController();
      switch (index) {
        case 0: //login controller
          controller.addListener(() {
            final text = controller.text.toLowerCase();
            controller.value = controller.value.copyWith(
                text: text,
                selection: TextSelection(
                    baseOffset: text.length, extentOffset: text.length),
                composing: TextRange.empty);
            _loginNotValid = (controller.value.text.isEmpty ||
                    controller.value.text.length < 4)
                ? true
                : false;
          });
          break;
        case 1: //firstName controller
          controller.addListener(() {});
          break;
        case 2: //lastName controller
          controller.addListener(() {});
          break;
        case 3: //middleName controller
          controller.addListener(() {});
          break;
        default:
          break;
      }
      return controller;
    });
  }

  void dispose() {
    for (var controller in _inputControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _setData(AccountInfo accountInfo) {
    _inputControllers[0].text = accountInfo.login;
    _inputControllers[1].text = accountInfo.firstName;
    _inputControllers[2].text = accountInfo.lastName;
    _inputControllers[3].text = accountInfo.middleName;
    _inputTriggers[0] = accountInfo.isAdmin;
    _inputTriggers[1] = accountInfo.isOperator;
    _inputTriggers[2] = accountInfo.isEngineer;
    _notLoaded = false;

    setState(() {});
  }

  void _updateUser(SessionData sessionData, BuildContext context) async {
    _inUpdate = true;
    try {
      var args = UpdateUserArgs();
      args.login = _inputControllers[0].value.text;
      args.firstName = _inputControllers[1].value.text;
      if (args.firstName.length < 1) args.firstName = " ";
      args.lastName = _inputControllers[2].value.text;
      if (args.lastName.length < 1) args.lastName = " ";
      args.middleName = _inputControllers[3].value.text;
      if (args.middleName.length < 1) args.middleName = " ";
      args.isAdmin = _inputTriggers[0];
      args.isOperator = _inputTriggers[1];
      args.isEngineer = _inputTriggers[2];
      var res = await sessionData.client.updateUser(args);
      showInfoSnackBar(_scaffoldKey, _isSnackBarActive, "Пользователь изменен",
          Colors.green);
    } on ApiException catch (e) {
      if (e.code == 403) {
        showInfoSnackBar(_scaffoldKey, _isSnackBarActive, "Недостаточно прав",
            Colors.orange);
      } else if (e.code == 404) {
        showInfoSnackBar(_scaffoldKey, _isSnackBarActive,
            "Невозможно изменить пользователя", Colors.orange);
      } else {
        showInfoSnackBar(_scaffoldKey, _isSnackBarActive,
            "Ошибка при запросе к апи", Colors.red);
      }
    } catch (e) {
      if (!(e is ApiException)) {
        showInfoSnackBar(_scaffoldKey, _isSnackBarActive,
            "Не удалось изменить пользователя", Colors.red);
      }
      print("Exception when calling DefaultApi->User(put): $e\n");
    }
    _inUpdate = false;
    setState(() {});
  }

  _AccountsMenuEditState() : super();

  @override
  Widget build(BuildContext context) {
    final AccountsMenuEditArgs accountsMenuEditArgs =
        ModalRoute.of(context).settings.arguments;

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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(7, (index) {
                  switch (index) {
                    case 0: //login
                      return Row(
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
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp("[a-zA-Z0-9_]"),
                                  )
                                ],
                                controller: _inputControllers[index],
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: _loginNotValid
                                              ? Colors.red
                                              : Colors.grey),
                                    ),
                                    helperText: "Логин не менее 4х символов",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: _loginNotValid
                                              ? Colors.red
                                              : Colors.grey),
                                    )),
                                enabled: false,
                              ),
                            ),
                          )
                        ],
                      );
                      break;
                    case 1: //firstName
                      return Row(
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
                                controller: _inputControllers[index],
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                      break;
                    case 2: //middleName
                      return Row(
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
                                controller: _inputControllers[index],
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                      break;
                    case 3: //lastName
                      return Row(
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
                                controller: _inputControllers[index],
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                      break;
                    case 4: //isAdmin
                      return Row(
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
                      );
                      break;
                    case 5: //isOperator
                      return Row(
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
                      );
                      break;
                    case 6: //isEngineer
                      return Row(
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
                      );
                      break;
                    default:
                      return Row();
                      break;
                  }
                }),
              ),
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                spacing: 25,
                children: [
                  SizedBox(
                    height: 50,
                    width: screenW / 3,
                    child: RaisedButton(
                      color: Colors.lightGreen,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      splashColor: Colors.lightGreenAccent,
                      onPressed: _inUpdate
                          ? null
                          : () {
                              _updateUser(
                                  accountsMenuEditArgs.sessionData, context);
                            },
                      child: Text(_inUpdate ? "Сохранение..." : "Сохранить"),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: screenW / 3,
                    child: RaisedButton(
                      color: Colors.lightGreen,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      splashColor: Colors.lightGreenAccent,
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
                  child: RaisedButton(
                    padding: EdgeInsets.all(5),
                    color: Colors.red,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    splashColor: Colors.redAccent,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Удалить пользователя?"),
                          content: Text("Вы уверены?"),
                          actionsPadding: EdgeInsets.all(10),
                          actions: [
                            RaisedButton(
                              color: Colors.lightGreen,
                              textColor: Colors.white,
                              disabledColor: Colors.grey,
                              disabledTextColor: Colors.black,
                              onPressed: () async {
                                bool success = false;
                                try {
                                  var cur_user = await accountsMenuEditArgs
                                      .sessionData.client
                                      .getUser();

                                  var args = DeleteUserArgs();
                                  args.login = _inputControllers[0].value.text;

                                  if (cur_user.login != accountsMenuEditArgs.targetUser.login) {
                                    var res = await accountsMenuEditArgs
                                        .sessionData.client
                                        .deleteUser(args);
                                    success = true;
                                  } else {
                                    showInfoSnackBar(
                                        _scaffoldKey,
                                        _isSnackBarActive,
                                        "Вы не можете удалить сами себя",
                                        Colors.orange);
                                  }
                                } on ApiException catch (e) {
                                  print(e);
                                  showInfoSnackBar(
                                      _scaffoldKey,
                                      _isSnackBarActive,
                                      "Произошла ошибка при запросе к api",
                                      Colors.redAccent);
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
                            RaisedButton(
                              color: Colors.white,
                              textColor: Colors.black,
                              disabledColor: Colors.grey,
                              disabledTextColor: Colors.black,
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
            ],
          );
        },
      ),
    );
  }
}
