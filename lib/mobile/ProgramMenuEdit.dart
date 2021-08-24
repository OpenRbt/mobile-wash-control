import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';

class ProgramMenuEditArgs {
  final int programID;
  final String programName;
  final SessionData sessionData;

  ProgramMenuEditArgs(this.programID, this.programName, this.sessionData);
}

class ProgramMenuEdit extends StatefulWidget {
  @override
  _ProgramMenuEditState createState() => _ProgramMenuEditState();
}

class _ProgramMenuEditState extends State<ProgramMenuEdit> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);
  final int _maxPercent = 100;
  final int _maxMotor = 100;
  final int _relayCount = 17;
  final int _relayTime = 1000;

  bool _preflight = false;
  bool _isFinishingProgram = false;
  bool _inUpdate = false;
  bool _firstLoad = true;

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
                  extentOffset: value.toString().length,
                ),
                composing: TextRange.empty,
              );
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
                  extentOffset: value.toString().length,
                ),
                composing: TextRange.empty,
              );
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
                  extentOffset: value.toString().length,
                ),
                composing: TextRange.empty,
              );
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
                  extentOffset: value.toString().length,
                ),
                composing: TextRange.empty,
              );
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

  void getProgram(ProgramMenuEditArgs programMenuEditArgs) async {
    try {
      var args = ProgramsArgs();
      args.programID = programMenuEditArgs.programID;
      var res = await programMenuEditArgs.sessionData.client.programs(args);

      _program[0].text = res[0].name;
      _program[1].text = res[0].price.toString();

      _motors[0].text = res[0].motorSpeedPercent.toString();
      _motors[1].text = res[0].preflightMotorSpeedPercent.toString();

      _preflight = res[0].preflightEnabled ?? false;
      _isFinishingProgram = res[0].isFinishingProgram ?? false;

      for (int i = 0; i < res[0].relays.length; i++) {
        int id = res[0].relays[i].id - 1;
        var timeon = res[0].relays[i].timeon ?? 0;
        var timeoff = res[0].relays[i].timeoff ?? 0;
        int percent = (100 * timeon / (timeon + timeoff)).round();
        _relays[id].text = percent.toString();
      }

      for (int i = 0; i < res[0].preflightRelays.length; i++) {
        int id = res[0].preflightRelays[i].id - 1;
        var timeon = res[0].preflightRelays[i].timeon ?? 0;
        var timeoff = res[0].preflightRelays[i].timeoff ?? 0;
        int percent = (100 * timeon / (timeon + timeoff)).round();
        _relaysPreflight[id].text = percent.toString();
      }
    } catch (e) {}
    setState(() {});
  }

  void saveProgram(ProgramMenuEditArgs programMenuEditArgs, BuildContext context) async {
    _inUpdate = true;
    try {
      var args = Program();
      args.id = programMenuEditArgs.programID;
      args.motorSpeedPercent = int.tryParse(_motors[0].value.text) ?? 0;
      args.name = _program[0].value.text;
      args.price = int.tryParse(_program[1].value.text) ?? 0;
      args.preflightEnabled = _preflight;
      args.isFinishingProgram = _isFinishingProgram;
      args.preflightMotorSpeedPercent = int.tryParse(_motors[1].value.text) ?? 0;

      List<RelayConfig> relays = List();
      List<RelayConfig> relaysPreflight = List();
      for (int i = 0; i < _relayCount; i++) {
        if (_relays[i].value.text.isNotEmpty && int.tryParse(_relays[i].value.text) != 0) {
          var tmp = RelayConfig();
          tmp.id = i + 1;
          tmp.timeon = (_relayTime * (int.tryParse(_relays[i].value.text) / 100)).round();
          tmp.timeoff = _relayTime - tmp.timeon;
          relays.add(tmp);
        }
        if (_preflight && _relaysPreflight[i].value.text.isNotEmpty && int.tryParse(_relaysPreflight[i].value.text) != 0) {
          var tmp = RelayConfig();
          tmp.id = i + 1;
          tmp.timeon = (_relayTime * (double.tryParse(_relaysPreflight[i].value.text) / 100)).round();
          tmp.timeoff = _relayTime - tmp.timeon;
          relaysPreflight.add(tmp);
        }
      }
      args.relays = relays;
      args.preflightRelays = relaysPreflight;

      var res = await programMenuEditArgs.sessionData.client.setProgram(args);
      showInfoSnackBar(_scaffoldKey, _isSnackBarActive, "Измененеия программы сохранены", Colors.green);
    } catch (e) {
      print(e);
      showInfoSnackBar(_scaffoldKey, _isSnackBarActive, "Не удалось изменить программу", Colors.red);
    }
    _inUpdate = false;
  }

  @override
  Widget build(BuildContext context) {
    final ProgramMenuEditArgs programMenuEditArgs = ModalRoute.of(context).settings.arguments;
    final AppBar appBar = AppBar(
      title: Text("Программа ${programMenuEditArgs.programName}"),
    );

    if (_firstLoad) {
      getProgram(programMenuEditArgs);
      _firstLoad = false;
    }

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar,
      key: _scaffoldKey,
      body: OrientationBuilder(
        builder: (context, orientation) {
          return SizedBox(
            height: screenH - appBar.preferredSize.height,
            width: screenW,
            child: ListView(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 75,
                          width: screenW / 3,
                          child: Center(
                            child: Text("Название", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                          ),
                        ),
                        SizedBox(
                          height: 75,
                          width: screenW / 3 * 2,
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
                      children: [
                        SizedBox(
                          height: 75,
                          width: screenW / 3,
                          child: Center(
                            child: Text("Цена", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                          ),
                        ),
                        SizedBox(
                          height: 75,
                          width: screenW / 3 * 2,
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
                    Center(
                      child: CheckboxListTile(
                        contentPadding: EdgeInsets.only(left: 5, right: 5),
                        title: Text(
                          'Прокачка',
                        ),
                        value: _preflight,
                        onChanged: (newValue) {
                          _preflight = newValue;
                          setState(() {});
                        },
                      ),
                    ),
                    Center(
                      child: CheckboxListTile(
                        contentPadding: EdgeInsets.only(left: 5, right: 5),
                        title: Text(
                          'Чистовая программа',
                        ),
                        value: _isFinishingProgram,
                        onChanged: (newValue) {
                          _isFinishingProgram = !_isFinishingProgram;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.lightGreen,
                  thickness: 3,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 50,
                      width: screenW / 9 * 4,
                      child: Center(
                        child: Text("Мотор %", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: screenW / 9,
                    ),
                    SizedBox(
                      height: 50,
                      width: screenW / 9 * 4,
                      child: Center(
                        child: Text("Мотор прокачки %", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 50,
                      width: screenW / 9 * 4,
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
                      width: screenW / 9,
                    ),
                    SizedBox(
                      height: 50,
                      width: screenW / 9 * 4,
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
                  children: [
                    SizedBox(
                      height: 50,
                      width: screenW / 9 * 4,
                      child: Center(
                        child: Text("Реле", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: screenW / 9,
                    ),
                    SizedBox(
                      height: 50,
                      width: screenW / 9 * 4,
                      child: Center(
                        child: Text("Реле прокачки", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 50,
                      width: screenW / 9 * 2,
                      child: Center(
                        child: Text("ID", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: screenW / 9 * 2,
                      child: Center(
                        child: Text("%", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: screenW / 9,
                    ),
                    SizedBox(
                      height: 50,
                      width: screenW / 9 * 2,
                      child: Center(
                        child: Text("ID", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: screenW / 9 * 2,
                      child: Center(
                        child: Text("%", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                      ),
                    )
                  ],
                ),
                Column(
                  children: List.generate(_relayCount, (index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50,
                          width: screenW / 9 * 2,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: index % 2 == 0 ? Colors.white : Colors.black12,
                              border: Border.all(color: Colors.black38),
                            ),
                            child: Center(
                              child: Text("${index + 1}", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: screenW / 9 * 2,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: index % 2 == 0 ? Colors.white : Colors.black12,
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
                          width: screenW / 9,
                        ),
                        SizedBox(
                          height: 50,
                          width: screenW / 9 * 2,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: index % 2 == 0 ? Colors.white : Colors.black12,
                              border: Border.all(color: Colors.black38),
                            ),
                            child: Center(
                              child: Text("${index + 1}", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: screenW / 9 * 2,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: index % 2 == 0 ? Colors.white : Colors.black12,
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
                SizedBox(
                  height: 10,
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
                                saveProgram(programMenuEditArgs, context);
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
                                getProgram(programMenuEditArgs);
                              },
                        child: Text("Отменить"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
