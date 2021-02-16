import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'AccountsMenu.dart';
import 'package:mobile_wash_control/CommonElements.dart';

class AccountsMenuEdit extends StatefulWidget {
  @override
  _AccountsMenuEditState createState() => _AccountsMenuEditState();
}

class _AccountsMenuEditState extends State<AccountsMenuEdit> {
  bool _notLoaded = true;

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

  void _updateUser(SessionData sessionData) async {}

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
    return Scaffold(
      appBar: appBar,
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
                                          RegExp("[a-zA-Z0-9_]"))
                                    ],
                                    controller: _inputControllers[index],
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(10),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: _loginNotValid
                                                    ? Colors.red
                                                    : Colors.grey)),
                                        helperText:
                                            "Логин не менее 4х символов",
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: _loginNotValid
                                                    ? Colors.red
                                                    : Colors.grey)))),
                              ))
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
                                      border: OutlineInputBorder()),
                                ),
                              ))
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
                                      border: OutlineInputBorder()),
                                ),
                              ))
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
                                      border: OutlineInputBorder()),
                                ),
                              ))
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
                              ))
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
                              ))
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
                              ))
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
                      onPressed: () {
                        _updateUser(accountsMenuEditArgs.sessionData);
                      },
                      child: Text("Сохранить"),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: screenW / 3,
                    child: RaisedButton(
                      onPressed: () {
                        _setData(accountsMenuEditArgs.targetUser);
                      },
                      child: Text("Отменить"),
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
