import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/PagesUtils/PagesArgs.dart';
import 'package:mobile_wash_control/PagesUtils/ServerRequests/ProgramsRequests.dart';

class EditProgramPage extends StatefulWidget {
  @override
  _EditProgramState createState() => _EditProgramState();
}

class _EditProgramState extends State<EditProgramPage> {
//
// UI VARIABLES
//
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);

  bool _inUpdate = false;
//
// PAGE VARIABLES
//
  bool _firstLoad = true;

  final int _maxPercent = 100;
  final int _maxMotor = 100;
  final int _relayCount = 17;
  final int _relayTime = 1000;
  bool _preflight = false;
  List<TextEditingController> _program;
  List<TextEditingController> _relays;
  List<TextEditingController> _relaysPreflight;
  List<TextEditingController> _motors;

  void initInputs() {
    _program = List.generate(2, (index) {
      var controller = new TextEditingController();
      switch (index) {
        case 1:
          controller.addListener(() {
            final text = controller.text.toLowerCase();
            if (text.length > 0) {
              int value = int.tryParse(text);
              value = value ?? 0;
              controller.value = controller.value.copyWith(
                  text: value.toString(),
                  selection: TextSelection(
                      baseOffset: value.toString().length,
                      extentOffset: value.toString().length),
                  composing: TextRange.empty);
            }
          });
          break;
        default:
          break;
      }
      return controller;
    });
    _motors = List.generate(2, (index) {
      var controller = new TextEditingController();
      switch (index) {
        default:
          controller.addListener(() {
            final text = controller.text.toLowerCase();
            if (text.length > 0) {
              int value = int.tryParse(text);
              value = value ?? 0;
              value = value > _maxMotor ? _maxMotor : value;
              controller.value = controller.value.copyWith(
                  text: value.toString(),
                  selection: TextSelection(
                      baseOffset: value.toString().length,
                      extentOffset: value.toString().length),
                  composing: TextRange.empty);
            }
          });
          break;
      }
      return controller;
    });
    _relays = List.generate(_relayCount, (index) {
      var controller = new TextEditingController();
      switch (index) {
        default:
          controller.addListener(() {
            final text = controller.text.toLowerCase();
            if (text.length > 0) {
              int value = int.tryParse(text);
              value = value ?? 0;
              value = value > _maxPercent ? _maxPercent : value;
              controller.value = controller.value.copyWith(
                  text: value.toString(),
                  selection: TextSelection(
                      baseOffset: value.toString().length,
                      extentOffset: value.toString().length),
                  composing: TextRange.empty);
            }
          });
          break;
      }
      return controller;
    });
    _relaysPreflight = List.generate(_relayCount, (index) {
      var controller = new TextEditingController();
      switch (index) {
        default:
          controller.addListener(() {
            final text = controller.text.toLowerCase();
            if (text.length > 0) {
              int value = int.tryParse(text);
              value = value ?? 0;
              value = value > _maxPercent ? _maxPercent : value;
              controller.value = controller.value.copyWith(
                  text: value.toString(),
                  selection: TextSelection(
                      baseOffset: value.toString().length,
                      extentOffset: value.toString().length),
                  composing: TextRange.empty);
            }
          });
          break;
      }
      return controller;
    });
  }

  void disposeInputs() {
    for (var controller in _relays) {
      controller.dispose();
    }
    for (var controller in _relaysPreflight) {
      controller.dispose();
    }
    for (var controller in _program) {
      controller.dispose();
    }
    for (var controller in _motors) {
      controller.dispose();
    }
  }

  void initState() {
    super.initState();
    initInputs();
  }

  void dispose() {
    super.dispose();
    disposeInputs();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text("Редактирование программы ${_program[0].text}"),
    );
    final ProgramMenuEditArgs editArgs =
        ModalRoute.of(context).settings.arguments;

    if (_firstLoad) {
      load(editArgs);
      _firstLoad = false;
    }
    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;

    double height = screenH - appBar.preferredSize.height;
    double width = screenW / 2;
    return Scaffold(
      appBar: appBar,
      key: _scaffoldKey,
      body: SizedBox(
        height: height,
        width: screenW,
        child: Row(
          children: [
            SizedBox(
              height: height,
              width: width,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 75,
                          width: width / 3,
                          child: Center(
                            child: Text(
                              "Название",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 75,
                          width: width / 3,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              controller: _program[0],
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 75,
                          width: width / 3,
                          child: Center(
                            child: Text(
                              "Цена",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 75,
                          width: width / 3,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp("[0-9]"),
                                )
                              ],
                              keyboardType: TextInputType.phone,
                              controller: _program[1],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 75,
                      width: width / 3 * 2,
                      child: Center(child: CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'Прокачка',
                          style: TextStyle(fontSize: 20),
                        ),
                        value: _preflight,
                        onChanged: (newValue) {
                          _preflight = !_preflight;
                          setState(() {});
                        },
                      ),)
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 50,
                          width: width /3,
                          child: Center(
                            child: Text("Мотор %",
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: width / 3,
                          child: Center(
                            child: Text("Мотор прокачки %",
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 50,
                          width: width / 3,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black38),
                            ),
                            child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp("[0-9]"),
                                )
                              ],
                              keyboardType: TextInputType.phone,
                              style: TextStyle(fontSize: 20),
                              controller: _motors[0],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: width / 3,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black38),
                            ),
                            child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp("[0-9]"),
                                )
                              ],
                              keyboardType: TextInputType.phone,
                              style: TextStyle(fontSize: 20),
                              controller: _motors[1],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 50,
                          width: width / 3,
                          child: RaisedButton(
                            color: Colors.lightGreen,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            splashColor: Colors.lightGreenAccent,
                            onPressed: _inUpdate
                                ? null
                                : () {
                                    save(editArgs.sessionData, context);
                                  },
                            child: Text("Сохранить"),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: width / 3,
                          child: RaisedButton(
                            color: Colors.lightGreen,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            splashColor: Colors.lightGreenAccent,
                            onPressed: _inUpdate
                                ? null
                                : () {
                                    Navigator.pop(context);
                                  },
                            child: Text("Отменить"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height,
              width: width,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(blurRadius: 5),
                  ],
                ),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 50,
                          width: width / 2,
                          child: Center(
                            child: Text("Реле",
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: width / 2,
                          child: Center(
                            child: Text("Реле прокачки",
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 25,
                          width: width / 9 * 2,
                          child: Center(
                            child: Text("ID",
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                          width: width / 9 * 2,
                          child: Center(
                            child: Text("%",
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                          width: width / 9,
                        ),
                        SizedBox(
                          height: 25,
                          width: width / 9 * 2,
                          child: Center(
                            child: Text("ID",
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                          width: width / 9 * 2,
                          child: Center(
                            child: Text("%",
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: List.generate(_relayCount, (index) {
                        return Row(
                          children: [
                            SizedBox(
                              height: 50,
                              width: width / 9 * 2,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? Colors.white
                                      : Colors.black12,
                                  border: Border.all(color: Colors.black38),
                                ),
                                child: Center(
                                  child: Text("${index + 1}",
                                      style: TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: width / 9 * 2,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? Colors.white
                                      : Colors.black12,
                                  border: Border.all(color: Colors.black38),
                                ),
                                child: TextField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"),
                                    )
                                  ],
                                  keyboardType: TextInputType.phone,
                                  style: TextStyle(fontSize: 20),
                                  controller: _relays[index],
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: width / 9,
                            ),
                            SizedBox(
                              height: 50,
                              width: width / 9 * 2,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? Colors.white
                                      : Colors.black12,
                                  border: Border.all(color: Colors.black38),
                                ),
                                child: Center(
                                  child: Text("${index + 1}",
                                      style: TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: width / 9 * 2,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? Colors.white
                                      : Colors.black12,
                                  border: Border.all(color: Colors.black38),
                                ),
                                child: TextField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"),
                                    )
                                  ],
                                  keyboardType: TextInputType.phone,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  controller: _relaysPreflight[index],
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void load(ProgramMenuEditArgs args) async {
    ProgramData data = await getProgram(
        sessionData: args.sessionData, programID: args.programID);
    if (data == null) {
      {
        return;
      }
    }
    _program[0].text = data.name;
    _program[1].text = data.price.toString();
    _motors[0].text = data.motorSpeed.toString();
    _motors[1].text = data.motorSpeedPreflight.toString();
    _preflight = data.preflightEnabled;
    for (int i = 0; i < data.relays.length; i++) {
      if (data.relays[i] != 0) {
        _relays[i].text = data.relays[i].toString();
      }
      if (data.relayPreflight[i] != 0) {
        _relaysPreflight[i].text = data.relayPreflight[i].toString();
      }
    }

    setState(() {});
  }

  void save(SessionData sessionData, BuildContext context) async {
    _inUpdate = true;
    setState(() {});

    String name = _program[0].value.text;
    int price = int.tryParse(_program[1].value.text) ?? 0;
    bool preflightEnabled = _preflight;
    int motorSpeed = int.tryParse(_motors[0].value.text) ?? 0;
    int motorSpeedPreflight = int.tryParse(_motors[1].value.text) ?? 0;
    List<int> relays = List.generate(_relayCount, (index) {
      return int.tryParse(_relays[index].value.text) ?? 0;
    });
    List<int> relayPreflight = List.generate(_relayCount, (index) {
      return int.tryParse(_relaysPreflight[index].value.text) ?? 0;
    });

    bool success = await saveProgram(sessionData,
        programName: name,
        price: price,
        preflightEnabled: preflightEnabled,
        motorSpeed: motorSpeed,
        motorSpeedPreflight: motorSpeedPreflight,
        relaysPercent: relays,
        relaysPreflightPercent: relayPreflight);
    if (success) {
      showInfoSnackBar(
          _scaffoldKey, _isSnackBarActive, "Программа добавлена", Colors.green);

      for (var field in _relays) {
        field.text = "";
      }
      for (var field in _relaysPreflight) {
        field.text = "";
      }
      for (var field in _program) {
        field.text = "";
      }
      for (var field in _motors) {
        field.text = "";
      }
    } else {
      showInfoSnackBar(_scaffoldKey, _isSnackBarActive,
          "Не удалось добавить программу", Colors.red);
    }
    setState(() {});
    _inUpdate = false;
  }
}
