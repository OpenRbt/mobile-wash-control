import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';

class DAccountsMenuAdd extends StatefulWidget {
  @override
  _DAccountsMenuAddState createState() => _DAccountsMenuAddState();
}

class _DAccountsMenuAddState extends State<DAccountsMenuAdd> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);

  bool _inUpdate = false;
  List<bool> _inputTriggers = List.filled(3, false);

  Map<String, TextEditingController> _inputControllers;

  void pageInit() {
    _inputControllers = {
      "login": new TextEditingController(),
      "firstName": new TextEditingController(),
      "lastName": new TextEditingController(),
      "middleName": new TextEditingController(),
      "password": new TextEditingController(),
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

  void _addUser(SessionData sessionData, BuildContext context) async {
    _inUpdate = true;
    setState(() {});

    try {
      var args = CreateUserArgs();
      args.login = _inputControllers["login"].value.text;
      if (args.login.length < 4) {
        print("login length fail");
        throw "login length error";
      }
      args.firstName = _inputControllers["firstName"].value.text;
      if (args.firstName.length < 1) args.firstName = " ";
      args.lastName = _inputControllers["lastName"].value.text;
      if (args.lastName.length < 1) args.lastName = " ";
      args.middleName = _inputControllers["middleName"].value.text;
      if (args.middleName.length < 1) args.middleName = " ";
      args.password = _inputControllers["password"].value.text;
      if (args.password.length < 4) {
        print("pass length fail");
        throw "pass length error";
      }
      args.isAdmin = _inputTriggers[0];
      args.isOperator = _inputTriggers[1];
      args.isEngineer = _inputTriggers[2];

      var res = await sessionData.client.createUser(args);
      showInfoSnackBar(_scaffoldKey, _isSnackBarActive, "Пользователь добавлен",
          Colors.green);

      for (var field in _inputControllers.values) {
        field.text = "";
      }

      for (var field in _inputTriggers) {
        field = false;
      }
    } on ApiException catch (e) {
      if (e.code == 403) {
        showInfoSnackBar(_scaffoldKey, _isSnackBarActive, "Недостаточно прав",
            Colors.orange);
      } else if (e.code == 409) {
        showInfoSnackBar(_scaffoldKey, _isSnackBarActive,
            "Невозможно добавить пользователя", Colors.orange);
      } else {
        showInfoSnackBar(_scaffoldKey, _isSnackBarActive,
            "Ошибка при запросе к апи", Colors.red);
      }
    } catch (e) {
      if (!(e is ApiException)) {
        showInfoSnackBar(_scaffoldKey, _isSnackBarActive,
            "Не удалось добавить пользователя", Colors.red);
      }
      print("Exception when calling DefaultApi->User(post): $e\n");
    }
    _inUpdate = false;
    setState(() {});
  }

  _DAccountsMenuAddState() : super();

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;

    final AppBar appBar = AppBar(
      title: Text("Добавление пользователя"),
      backgroundColor: Colors.grey,
    );

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar,
      key: _scaffoldKey,
      body: OrientationBuilder(
        builder: (context, orientation) {
          return ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z0-9_]"),
                              )
                            ],
                            controller: _inputControllers["login"],
                            onChanged: (newValue) {
                              var controller = _inputControllers["login"];
                              final text = controller.text.toLowerCase();
                              controller.value = controller.value.copyWith(
                                  text: text,
                                  selection: TextSelection(
                                      baseOffset: text.length,
                                      extentOffset: text.length),
                                  composing: TextRange.empty);
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(),
                              helperText: "Логин не менее 4х символов",
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
                            "Пин код",
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
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp("[0-9]"),
                              )
                            ],
                            controller: _inputControllers["password"],
                            maxLength: 16,
                            onChanged: (newValue) {
                              var controller = _inputControllers["password"];
                              final text = controller.text.toLowerCase();
                              controller.value = controller.value.copyWith(
                                  text: text,
                                  selection: TextSelection(
                                      baseOffset: text.length,
                                      extentOffset: text.length),
                                  composing: TextRange.empty);
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              helperText: "Пин не менее 4х символов",
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
                ],
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
                              _addUser(sessionData, context);
                            },
                      child: Text("Сохранить"),
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Отмена"),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}