import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'client/api.dart';

class AccountsMenuAdd extends StatefulWidget {
  @override
  _AccountsMenuAddState createState() => _AccountsMenuAddState();
}

class _AccountsMenuAddState extends State<AccountsMenuAdd> {
  bool _inUpdate = false;
  List<TextEditingController> _inputControllers;
  List<bool> _inputTriggers = List.filled(3, false);

  void pageInit() {
    _inputControllers = List.generate(5, (index) {
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
        case 4: //password controller
          controller.addListener(() {
            final text = controller.text.toLowerCase();
            controller.value = controller.value.copyWith(
                text: text,
                selection: TextSelection(
                    baseOffset: text.length, extentOffset: text.length),
                composing: TextRange.empty);
          });
          break;
        default:
          break;
      }
      return controller;
    });
  }

  void initState() {
    super.initState();
    pageInit();
  }

  void dispose() {
    for (var controller in _inputControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addUser(SessionData sessionData, BuildContext context) async {
    _inUpdate = true;
    setState(() {});
    try {
      var args = Args22();
      args.login = _inputControllers[0].value.text;
      if (args.login.length < 4) {
        print("login length fail");
        throw "login length error";
      }
      args.firstName = _inputControllers[1].value.text;
      if (args.firstName.length < 1) args.firstName = " ";
      args.lastName = _inputControllers[2].value.text;
      if (args.lastName.length < 1) args.lastName = " ";
      args.middleName = _inputControllers[3].value.text;
      if (args.middleName.length < 1) args.middleName = " ";
      args.password = _inputControllers[4].value.text;
      if (args.password.length < 4) {
        print("pass length fail");
        throw "pass length error";
      }
      args.isAdmin = _inputTriggers[0];
      args.isOperator = _inputTriggers[1];
      args.isEngineer = _inputTriggers[2];
      var res = await sessionData.client.createUser(args);
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Пользователь добавлен")));
      pageInit();
    } catch (e) {
      print("Exception when calling DefaultApi->User(put): $e\n");
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Произошла ошибка при добавлении")));
    }
    _inUpdate = false;
    setState(() {});
  }

  _AccountsMenuAddState() : super();
  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;

    final AppBar appBar = AppBar(
      title: Text("Добавление пользователя"),
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
                children: List.generate(8, (index) {
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
                                      border: OutlineInputBorder(),
                                      helperText: "Логин не менее 4х символов",
                                    )),
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
                    case 4: //password
                      return Row(
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
                                        RegExp("[0-9]"))
                                  ],
                                  controller: _inputControllers[index],
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      helperText: "Пин не менее 4х символов",
                                      border: OutlineInputBorder()),
                                ),
                              ))
                        ],
                      );
                      break;
                    case 5: //isAdmin
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
                    case 6: //isOperator
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
                    case 7: //isEngineer
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
                      color: Colors.lightGreen,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      splashColor: Colors.lightGreenAccent,
                      onPressed: _inUpdate
                          ? null
                          : () {
                              _addUser(sessionData, context);
                              //Navigator.pop(context, true);
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
