import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/SharedData.dart';
import 'package:mobile_wash_control/client/api.dart';
import 'package:mobile_wash_control/entity/entity.dart' as entity;
import 'package:mobile_wash_control/mobile/widgets/programms/relayListTile.dart';

class EditProgramArgs {
  final int? id;
  final String name;

  EditProgramArgs(this.id, this.name);
}

class EditProgramPage extends StatefulWidget {
  late SessionData sessionData;

  final EditProgramArgs editArgs;

  EditProgramPage({required this.editArgs}) {
    sessionData = SharedData.sessionData!;
  }

  @override
  State<StatefulWidget> createState() => _EditProgramPageState();
}

class _EditProgramPageState extends State<EditProgramPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  late entity.Program program;

  var _isSnackBarActive = ValueWrapper(false);
  final int _maxPercent = 100;
  final int _maxMotor = 100;
  final int _relayCount = 17;
  final int _relayTime = 1000;

  bool _preflight = false;
  bool _isFinishingProgram = false;
  bool _inUpdate = false;

  Map<String, TextEditingController> _controllers = Map();
  Map<String, List<TextEditingController>> _relaysControllers = Map();

  late List<TextEditingController> _program;
  late List<TextEditingController> _relays;
  late List<TextEditingController> _relaysPreflight;
  late List<TextEditingController> _motors;

  void initInputs() {
    _controllers["name"] = TextEditingController();
    _controllers["price"] = TextEditingController();
    _controllers["motor"] = TextEditingController();
    _controllers["motorPreflight"] = TextEditingController();
    _relaysControllers["relays"] = List.generate(entity.Program.relayCount, (index) => TextEditingController());
    _relaysControllers["relaysPreflight"] = List.generate(entity.Program.relayCount, (index) => TextEditingController());
  }

  void disposeInputs() {
    _controllers.values.forEach((element) {
      element.dispose();
    });
    _relaysControllers.values.forEach((element) {
      element.forEach((element) {
        element.dispose();
      });
    });
  }

  void initState() {
    initInputs();
    program = entity.Program(widget.editArgs.id);
    getProgram();
    super.initState();
  }

  @override
  void dispose() {
    disposeInputs();
    super.dispose();
  }

  void getProgram() async {
    if (widget.editArgs.id == null) {
      return;
    }

    try {
      var args = ArgPrograms(
        programID: widget.editArgs.id,
      );
      var res = await SharedData.sessionData!.client.programs(args);
      if (res == null) {
        return;
      }
      var resProgram = res.first;

      program = entity.Program(resProgram.id);
      program.name = resProgram.name ?? "";
      program.price = resProgram.price ?? 0;
      program.motorSpeedPercent = resProgram.motorSpeedPercent ?? 100;
      program.preflightMotorSpeedPercent = resProgram.preflightMotorSpeedPercent ?? 100;
      program.preflightEnabled = resProgram.preflightEnabled ?? false;
      program.ifFinishingProgram = resProgram.isFinishingProgram ?? false;

      resProgram.relays.forEach((element) {
        program.relays[element.id! - 1] = entity.RelayConfig.FromApi(element.id!, element.timeon ?? 0, element.timeoff ?? 0);
      });
      resProgram.preflightRelays.forEach((element) {
        program.relaysPreflight[element.id! - 1] = entity.RelayConfig.FromApi(element.id!, element.timeon ?? 0, element.timeoff ?? 0);
      });

      updateUIState();
    } catch (e) {
      print(e);
    }
  }

  void updateUIState() {
    setState(() {
      _controllers["name"]!.text = program.name;
      _controllers["price"]!.text = program.price.toString();
      _controllers["motor"]!.text = program.motorSpeedPercent.toString();
      _controllers["motorPreflight"]!.text = program.preflightMotorSpeedPercent.toString();

      var relays = _relaysControllers["relays"];
      program.relays.forEach((element) {
        relays![element.id - 1].text = element.percent().toString();
      });

      var relaysPreflight = _relaysControllers["relaysPreflight"];
      program.relaysPreflight.forEach((element) {
        relaysPreflight![element.id - 1].text = element.percent().toString();
      });
    });
  }

  void saveProgram(BuildContext context) async {
    _inUpdate = true;
    try {
      var args = Program(id: -1);
      args.id = widget.editArgs!.id!;
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

      var res = await SharedData.sessionData!.client.setProgram(args);
      showInfoSnackBar(context, _scaffoldKey, _isSnackBarActive, "Измененеия программы сохранены", Colors.green);
    } catch (e) {
      print(e);
      showInfoSnackBar(context, _scaffoldKey, _isSnackBarActive, "Не удалось изменить программу", Colors.red);
    }
    _inUpdate = false;
  }

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      title: Text("Программа ${widget.editArgs?.name ?? ""}"),
    );

    final theme = Theme.of(context);

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar,
      key: _scaffoldKey,
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: Center(
                          child: Text(
                            "Название",
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          controller: _controllers["name"],
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: Center(
                          child: Text(
                            "Цена",
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          controller: _controllers["price"],
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: Center(
                          child: Text(
                            "Чистовая программа",
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Center(
                          child: Switch(
                            value: program.ifFinishingProgram,
                            onChanged: (val) {
                              setState(() {
                                program.ifFinishingProgram = val!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: Center(
                          child: Text(
                            "% мотора",
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          controller: _controllers["motor"],
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          keyboardType: TextInputType.number,
                          onChanged: (val) {
                            if (val.isEmpty) {
                              _controllers["motor"]!.text = "0";
                            } else {
                              if (int.parse(val) > 100) {
                                _controllers["motor"]!.text = "100";
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: Center(
                          child: Text(
                            "Прокачка",
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Center(
                          child: Switch(
                            value: program.preflightEnabled,
                            onChanged: (val) {
                              setState(() {
                                program.preflightEnabled = val!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: Center(
                          child: Text(
                            "% мотора прокачки",
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          controller: _controllers["motorPreflight"],
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          keyboardType: TextInputType.number,
                          onChanged: (val) {
                            if (val.isEmpty) {
                              _controllers["motorPreflight"]!.text = "0";
                            } else {
                              if (int.parse(val) > 100) {
                                _controllers["motorPreflight"]!.text = "100";
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Настройки реле",
                    style: theme.textTheme.headlineSmall,
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Center(
                            child: Text(
                          "ID",
                          style: theme.textTheme.titleLarge,
                        )),
                        VerticalDivider(),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Center(
                              child: Text(
                            "%",
                            style: theme.textTheme.titleLarge,
                          )),
                        ),
                        VerticalDivider(),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Center(
                              child: Text(
                            "% прокачки",
                            style: theme.textTheme.titleLarge,
                          )),
                        ),
                      ],
                    ),
                  )
                ]..addAll(List.generate(program.relays.length, (index) => RelayListTile(id: index + 1, relay: _relaysControllers["relays"]![index], relayPreflight: _relaysControllers["relaysPreflight"]![index]))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _inUpdate
                      ? null
                      : () {
                          saveProgram(context);
                        },
                  child: Text(_inUpdate ? "Сохранение..." : "Сохранить"),
                ),
                ElevatedButton(
                  onPressed: _inUpdate
                      ? null
                      : () {
                          getProgram();
                        },
                  child: Text("Отменить"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
