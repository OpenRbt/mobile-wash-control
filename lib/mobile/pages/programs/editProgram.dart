import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_wash_control/entity/entity.dart' as entity;
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/common/ProgressButton.dart';
import 'package:mobile_wash_control/mobile/widgets/programms/relayListTile.dart';
import 'package:mobile_wash_control/repository/repository.dart';

import '../../widgets/common/snackBars.dart';

class EditProgramPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditProgramPageState();
}

class _EditProgramPageState extends State<EditProgramPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ValueNotifier<entity.Program> _program = ValueNotifier(entity.Program(null));

  Map<String, TextEditingController> _controllers = Map();
  Map<String, List<TextEditingController>> _relaysControllers = Map();

  void initInputs() {
    _controllers["name"] = TextEditingController();
    _controllers["price"] = TextEditingController();
    _controllers["motor"] = TextEditingController();
    _controllers["motorPreflight"] = TextEditingController();
    _relaysControllers["relays"] = List.generate(entity.Program.relayCount, (index) {
      var controller = TextEditingController();
      controller.addListener(() {
        var program = _program.value;
        int value = int.tryParse(
              controller.text,
            ) ??
            0;
        program.relays[index].SetPercent(value);
        _program.value = program;
      });

      return controller;
    });
    _relaysControllers["relaysPreflight"] = List.generate(entity.Program.relayCount, (index) {
      var controller = TextEditingController();
      controller.addListener(() {
        var program = _program.value;
        int value = int.tryParse(
              controller.text,
            ) ??
            0;
        program.relaysPreflight[index].SetPercent(value);
        _program.value = program;
      });

      return controller;
    });
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
    super.initState();
  }

  @override
  void dispose() {
    disposeInputs();
    _program.dispose();
    super.dispose();
  }

  Future<void> getProgram(int? id, Repository repository, BuildContext context) async {
    if (id == null) {
      _program.value = entity.Program(null);
      updateUIState();
      return;
    }

    var prog = await repository.getProgram(id, context: context);
    _program.value = prog!;
    updateUIState();
  }

  void updateUIState() async {
    final program = _program.value;

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
  }

  Future<void> saveProgram(BuildContext context, int? id, Repository repository) async {
    await repository.saveProgram(_program.value, context: context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final int? id = args[PageArgCode.programID];
    final Repository repository = args[PageArgCode.repository];

    final theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          title: ValueListenableBuilder(
            valueListenable: _program,
            builder: (BuildContext context, entity.Program? value, Widget? child) {
              return Text(value != null ? "Программа ${value.name}" : "Новая программа");
            },
          ),
        ),
        key: _scaffoldKey,
        body: FutureBuilder(
          future: getProgram(id, repository, context),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return StatefulBuilder(builder: (context, setState) {
              return ValueListenableBuilder(
                valueListenable: _program,
                builder: (BuildContext context, entity.Program program, Widget? child) {
                  return ListView(
                    padding: EdgeInsets.all(8.0),
                    children: [
                      Card(
                        child: ExpansionTile(
                          title: Text(
                            "Параметры программы",
                            style: theme.textTheme.titleLarge,
                          ),
                          childrenPadding: EdgeInsets.all(8),
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Text(
                                    "${context.tr('name')}",
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: TextField(
                                    controller: _controllers["name"],
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) {
                                      _program.value = program.copyWith(name: value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Text(
                                    "Цена",
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: TextField(
                                    controller: _controllers["price"],
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      int price = int.tryParse(value) ?? 0;
                                      _program.value = program.copyWith(price: price);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Text(
                                    "Чистовая программа",
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Нет",
                                        style: theme.textTheme.labelSmall,
                                      ),
                                      Switch(
                                        value: program.isFinishingProgram,
                                        onChanged: (val) {
                                          _program.value = _program.value.copyWith(isFinishingProgram: val);
                                        },
                                      ),
                                      Text(
                                        "Да",
                                        style: theme.textTheme.labelSmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Card(
                        child: ExpansionTile(
                          title: Text(
                            "Параметры выполнения",
                            style: theme.textTheme.titleLarge,
                          ),
                          childrenPadding: EdgeInsets.all(8),
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Text(
                                    "% мотора",
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: TextField(
                                    controller: _controllers["motor"],
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      if (value.isEmpty) {
                                        //_controllers["motor"]!.text = "0";
                                      } else {
                                        if (int.parse(value) > 100) {
                                          _controllers["motor"]!.text = "100";
                                        }
                                      }

                                      int percent = int.tryParse(value) ?? 0;

                                      _program.value = program.copyWith(motorSpeedPercent: percent);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Text(
                                    "Прокачка",
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Нет",
                                        style: theme.textTheme.labelSmall,
                                      ),
                                      Switch(
                                        value: program.preflightEnabled,
                                        onChanged: (val) {
                                          _program.value = _program.value.copyWith(preflightEnabled: val);
                                        },
                                      ),
                                      Text(
                                        "Да",
                                        style: theme.textTheme.labelSmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Text(
                                    "% мотора прокачки",
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: TextField(
                                    controller: _controllers["motorPreflight"],
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      if (value.isEmpty) {
                                        //_controllers["motorPreflight"]!.text = "0";
                                      } else {
                                        if (int.parse(value) > 100) {
                                          _controllers["motorPreflight"]!.text = "100";
                                        }
                                      }

                                      int percent = int.tryParse(value) ?? 0;

                                      _program.value = program.copyWith(preflightMotorSpeedPercent: percent);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Card(
                        child: ExpansionTile(
                          title: Text(
                            "Параметры реле",
                            style: theme.textTheme.titleLarge,
                          ),
                          childrenPadding: EdgeInsets.all(8),
                          children: List.generate(
                              program.relays.length,
                              (index) => RelayListTile(
                                    id: index + 1,
                                    relay: _relaysControllers["relays"]![index],
                                    relayPreflight: _relaysControllers["relaysPreflight"]![index],
                                    relayConfig: _program.value.relays[index],
                                  )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ProgressButton(
                              onPressed: () async {
                                if(_controllers["name"]!.text.isEmpty){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBars.getErrorSnackBar(
                                      message: "Поле с именем программы не может быть пустым",
                                    ),
                                  );
                                }
                                else{
                                  await saveProgram(context, id, repository);
                                }
                              },
                              child: Text("${context.tr('save')}"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                getProgram(id, repository, context);
                              },
                              child: Text("Отменить"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            });
          },
        ));
  }
}
