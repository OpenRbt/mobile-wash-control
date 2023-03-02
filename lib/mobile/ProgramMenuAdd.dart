import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';

class ProgramMenuAdd extends StatefulWidget {
  @override
  _ProgramMenuAddState createState() => _ProgramMenuAddState();
}

class _ProgramMenuAddState extends State<ProgramMenuAdd> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);

  final int _maxPercent = 100;
  final int _maxMotor = 100;
  final int _relayCount = 17;
  final int _relayTime = 1000;
  bool _preflight = false;
  bool _isFinishingProgram = false;
  bool _inUpdate = false;

  late List<TextEditingController> _program;
  late List<TextEditingController> _relays;
  late List<TextEditingController> _relaysPreflight;
  late List<TextEditingController> _motors;

  void initInputs() {
    _program = List.generate(2, (index) {
      var controller = new TextEditingController();
      switch (index) {
        case 1:
          controller.addListener(() {
            final text = controller.text.toLowerCase();
            if (text.length > 0) {
              int? value = int.tryParse(text);
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
              int? value = int.tryParse(text);
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
              int? value = int.tryParse(text);
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
              int? value = int.tryParse(text);
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

  void saveProgram(SessionData sessionData, BuildContext context) async {
    _inUpdate = true;
    try {
      var tmp = await sessionData.client.programs(ArgPrograms());
      int maxID = 1000;
      if (tmp != null && tmp.isNotEmpty) {
        tmp.sort(
          (a, b) => a.id.compareTo(b.id),
        );
        if (tmp.last.id >= 1000) {
          maxID = tmp.last.id + 1;
        }
        print(maxID);
      }

      var args = Program(id: -1);
      args.id = maxID;
      args.motorSpeedPercent = int.tryParse(_motors[0].value.text) ?? 0;
      args.name = _program[0].value.text;
      args.price = int.tryParse(_program[1].value.text) ?? 0;
      args.preflightEnabled = _preflight;
      args.isFinishingProgram = _isFinishingProgram;
      args.preflightMotorSpeedPercent = int.tryParse(_motors[1].value.text) ?? 0;

      List<RelayConfig> relays = [];
      List<RelayConfig> relaysPreflight = [];
      for (int i = 0; i < _relayCount; i++) {
        if (_relays[i].value.text.isNotEmpty && int.tryParse(_relays[i].value.text) != 0) {
          var tmp = RelayConfig();
          tmp.id = i + 1;

          tmp.timeon = (_relayTime * (int.tryParse(_relays[i].value.text)! / 100)).round();
          tmp.timeoff = _relayTime - (tmp.timeon ?? 0);
          relays.add(tmp);
        }
        if (_preflight && _relaysPreflight[i].value.text.isNotEmpty && int.tryParse(_relaysPreflight[i].value.text) != 0) {
          var tmp = RelayConfig();
          tmp.id = i + 1;
          tmp.timeon = (_relayTime * (double.tryParse(_relaysPreflight[i].value.text)! / 100)).round();
          tmp.timeoff = _relayTime - (tmp.timeon ?? 0);
          relaysPreflight.add(tmp);
        }
      }
      args.relays = relays;
      args.preflightRelays = relaysPreflight;

      print(args);
      var res = await sessionData.client.setProgram(args);
      showInfoSnackBar(context, _scaffoldKey, _isSnackBarActive, "Программа добавлена", Colors.green);

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
    } catch (e) {
      showInfoSnackBar(context, _scaffoldKey, _isSnackBarActive, "Не удалось добавить программу", Colors.red);
    }
    setState(() {});
    _inUpdate = false;
  }

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context)?.settings.arguments as SessionData;
    final AppBar appBar = AppBar(
      title: Text("Новая программа"),
    );

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
                          _preflight = !_preflight;
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
                                saveProgram(sessionData, context);
                              },
                        child: Text("Сохранить"),
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
                                Navigator.pop(context);
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
