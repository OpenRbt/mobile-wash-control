import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_wash_control/entity/entity.dart' as entity;
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/repository/repository.dart';

class StationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StationPageState();
}

class _StationPageState extends State<StationPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formKeyPost = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyCardReader = GlobalKey<FormState>();

  ValueNotifier<entity.StationConfig> _config = ValueNotifier(entity.StationConfig(
    id: 1,
    relayBoard: entity.RelayBoard.localGPIO,
  ));

  ValueNotifier<entity.StationCardReaderConfig> _cardReaderConfig = ValueNotifier(entity.StationCardReaderConfig(
    cardReader: entity.CardReader.not_used,
  ));

  ValueNotifier<List<entity.StationButton>> _buttonsConfig = ValueNotifier(
    List.generate(
      maxButtons,
      (index) => entity.StationButton(
        buttonID: index + 1,
      ),
    ),
  );

  List<entity.Program> _programs = [];

  Map<String, TextEditingController> _controllers = Map();

  static final int maxButtons = 20;

  void initState() {
    super.initState();
    _controllers["postName"] = TextEditingController();
    _controllers["postPreflightSec"] = TextEditingController();

    _controllers["cardReaderHost"] = TextEditingController();
    _controllers["cardReaderPort"] = TextEditingController();
  }

  void dispose() {
    _controllers.values.forEach(
      (element) {
        element.dispose();
      },
    );

    _config.dispose();
    _cardReaderConfig.dispose();

    super.dispose();
  }

  Future<void> _getPostConfig(Repository repository, int id) async {
    _config.value = await repository.getStationConfig(id) ??
        entity.StationConfig(
          id: id,
          relayBoard: entity.RelayBoard.localGPIO,
        );
    _controllers["postName"]!.text = _config.value.name ?? "station ${id}";
  }

  Future<void> _getCardReaderConfig(Repository repository, int id) async {
    _cardReaderConfig.value = await repository.getCardReaderConfig(id) ?? entity.StationCardReaderConfig(cardReader: entity.CardReader.not_used);

    _controllers["cardReaderHost"]!.text = _cardReaderConfig.value.host ?? "";
    _controllers["cardReaderPort"]!.text = _cardReaderConfig.value.port ?? "";
  }

  Future<void> _getStationButtonsConfig(Repository repository, int id) async {
    var buttons = List.generate(maxButtons, (index) => entity.StationButton(buttonID: index + 1));

    final res = await repository.getStationButtons(id) ?? <entity.StationButton>[];
    res.forEach((element) {
      buttons[element.buttonID - 1] = element;
    });

    final programs = await repository.getPrograms() ?? [];
    _programs = [entity.Program(-1)]..addAll(programs);

    _buttonsConfig.value = buttons;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final int id = args[PageArgCode.stationID];
    final String ip = args[PageArgCode.stationIP] ?? "";
    final repository = args[PageArgCode.repository] as Repository;

    List<String> availableHashes = [];
    availableHashes.add("");
    availableHashes.addAll(repository.getHashesNotifier().value!);

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Пост $id - $ip",
        ),
      ),
      key: _scaffoldKey,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          FutureBuilder(
            future: _getPostConfig(repository, id),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              return ValueListenableBuilder(
                valueListenable: _config,
                builder: (BuildContext context, entity.StationConfig? config, Widget? child) {
                  var hashes = repository.getHashesNotifier().value ?? [];

                  return Form(
                    key: _formKeyPost,
                    child: Card(
                      child: ExpansionTile(
                        title: Text(
                          "Параметры поста",
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
                                  "Имя",
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: TextFormField(
                                  controller: _controllers["postName"],
                                  onChanged: (val) {
                                    _config.value = _config.value.copyWith(name: val);
                                  },
                                  validator: (val) {
                                    if ((val ?? "").trim().isEmpty) {
                                      return "Поле не может быть пустым";
                                    }
                                    return null;
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
                                  "Хэш",
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: DropdownButtonFormField(
                                  isExpanded: true,
                                  value: config?.hash ?? "-",
                                  items: List.generate(
                                    hashes.length,
                                    (index) => DropdownMenuItem(
                                      child: Text(hashes[index]),
                                      value: hashes[index],
                                    ),
                                  ),
                                  onChanged: (String? value) {
                                    _config.value = _config.value.copyWith(hash: value);
                                  },
                                  validator: (value) {
                                    return value == "-" ? "Необходимо указать хэш" : null;
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
                                child: TextFormField(
                                  controller: _controllers["postPreflightSec"],
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    FilteringTextInputFormatter.singleLineFormatter,
                                  ],
                                  onChanged: (val) {
                                    var amount = int.tryParse(val ?? "");
                                    _config.value = _config.value.copyWith(preflightSec: amount);
                                  },
                                  validator: (val) {
                                    var amount = int.tryParse(val ?? "");
                                    if ((amount ?? 0) < 0) {
                                      return "Время прокачки должно быть не меньше 0";
                                    }
                                    return null;
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
                                  "Выполнение",
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: DropdownButton(
                                  isExpanded: true,
                                  value: _config.value.relayBoard ?? entity.RelayBoard.localGPIO,
                                  items: List.generate(
                                    entity.RelayBoard.values.length,
                                    (index) => DropdownMenuItem(
                                      child: Text(
                                        entity.RelayBoard.values[index].label(),
                                      ),
                                      value: entity.RelayBoard.values[index],
                                    ),
                                  ),
                                  onChanged: (value) {
                                    _config.value = _config.value.copyWith(relayBoard: value);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  if (_formKeyPost.currentState!.validate()) {
                                    await repository.saveStationConfig(_config.value).then((value) => _getPostConfig(repository, id));
                                  }
                                },
                                child: Text("Сохранить"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await _getPostConfig(repository, id);
                                },
                                child: Text("Сбросить"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          FutureBuilder(
            future: _getCardReaderConfig(repository, id),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              return ValueListenableBuilder(
                valueListenable: _cardReaderConfig,
                builder: (BuildContext context, entity.StationCardReaderConfig value, Widget? child) {
                  return Form(
                    key: _formKeyCardReader,
                    child: Card(
                      child: ExpansionTile(
                        title: Text(
                          "Параметры кардридера",
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
                                  "Тип",
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: DropdownButton(
                                  isExpanded: true,
                                  value: _cardReaderConfig.value.cardReader,
                                  items: List.generate(
                                    entity.CardReader.values.length,
                                    (index) => DropdownMenuItem(
                                      child: Text(
                                        entity.CardReader.values[index].label(),
                                      ),
                                      value: entity.CardReader.values[index],
                                    ),
                                  ),
                                  onChanged: (value) {
                                    _cardReaderConfig.value = _cardReaderConfig.value.copyWith(cardReader: value);
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
                                  "Хост",
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: TextFormField(
                                  controller: _controllers["cardReaderHost"],
                                  onChanged: (val) {
                                    _cardReaderConfig.value = _cardReaderConfig.value.copyWith(host: val);
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
                                  "Порт",
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: TextFormField(
                                  controller: _controllers["cardReaderPort"],
                                  onChanged: (val) {
                                    _cardReaderConfig.value = _cardReaderConfig.value.copyWith(port: val);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  if (_formKeyCardReader.currentState!.validate()) {
                                    await repository.saveCardReaderConfig(id, _cardReaderConfig.value).then((value) => _getCardReaderConfig(repository, id));
                                  }
                                },
                                child: Text("Сохранить"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await _getCardReaderConfig(repository, id);
                                },
                                child: Text("Сбросить"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          FutureBuilder(
            future: _getStationButtonsConfig(repository, id),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              return ValueListenableBuilder(
                valueListenable: _buttonsConfig,
                builder: (BuildContext context, List<entity.StationButton> buttons, Widget? child) {
                  return Card(
                    child: ExpansionTile(
                      title: Text(
                        "Привязка кнопок",
                        style: theme.textTheme.titleLarge,
                      ),
                      childrenPadding: EdgeInsets.all(8),
                      children: [
                        Column(
                          children: List.generate(
                            buttons.length,
                            (index) {
                              return Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Text("Кнопка ${buttons[index].buttonID}"),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: DropdownButton(
                                      isExpanded: true,
                                      value: buttons[index].programID ?? -1,
                                      items: List.generate(_programs.length, (index) {
                                        return DropdownMenuItem(
                                          child: Text("${(_programs[index].id != -1 ? _programs[index].id : "").toString().padLeft(4)} : ${_programs[index].name}"),
                                          value: _programs[index].id ?? -1,
                                        );
                                      }),
                                      onChanged: (int? value) {
                                        final buttonConfig = _buttonsConfig.value;
                                        var config = <entity.StationButton>[];
                                        config.addAll(buttonConfig);
                                        config[index].programID = value;

                                        _buttonsConfig.value = config;
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () async {
                                await repository.saveStationButtons(id, _buttonsConfig.value).then((value) => _getStationButtonsConfig(repository, id));
                              },
                              child: Text("Сохранить"),
                            ),
                            TextButton(
                              onPressed: () async {
                                await _getStationButtonsConfig(repository, id);
                              },
                              child: Text("Сбросить"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
