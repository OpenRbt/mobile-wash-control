import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_wash_control/entity/entity.dart' as entity;
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/common/ProgressTextButton.dart';
import 'package:mobile_wash_control/repository/repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mobile_wash_control/utils/utils.dart';

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

  List<entity.SkinInfo> _availableSkins = [];

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

  ValueNotifier<Map<String, String>> _constantsConfig = ValueNotifier({});
  ValueNotifier<Map<String, bool>> _boolConstantsConfig = ValueNotifier({});
  ValueNotifier<Map<String, String>> _stringConstantsConfig = ValueNotifier({});

  // Original values to track changes
  Map<String, String> _origIntValues = {};
  Map<String, bool> _origBoolValues = {};
  Map<String, String> _origStringValues = {};

  void initState() {
    super.initState();
    _controllers["postName"] = TextEditingController();
    _controllers["postPreflightSec"] = TextEditingController();

    _controllers["cardReaderHost"] = TextEditingController();
    _controllers["cardReaderPort"] = TextEditingController();

    //_controllers["banknoteMultiplicator"] = TextEditingController();
    //_controllers["coinMultiplicator"] = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
      final int id = args[PageArgCode.stationID];
      final repository = args[PageArgCode.repository] as Repository;

      _getPostConfig(repository, id, context);
      _getCardReaderConfig(repository, id);
      _getStationButtonsConfig(repository, id);
      _loadSkins(repository);
      _loadConstants(repository, id);
    });
  }

  void dispose() {
    _controllers.values.forEach(
      (element) {
        element.dispose();
      },
    );

    _config.dispose();
    _cardReaderConfig.dispose();
    _constantsConfig.dispose();
    _boolConstantsConfig.dispose();
    _stringConstantsConfig.dispose();

    super.dispose();
  }

  Future<void> _getPostConfig(Repository repository, int id, BuildContext context) async {
    _config.value = await repository.getStationConfig(id, context: context) ??
        entity.StationConfig(
          id: id,
          relayBoard: entity.RelayBoard.localGPIO,
        );
    _controllers["postName"]!.text = _config.value.name ?? "station ${id}";
    _controllers["postPreflightSec"]!.text = _config.value.preflightSec?.toString() ?? "0";
  }

  Future<void> _getCardReaderConfig(Repository repository, int id) async {
    _cardReaderConfig.value = await repository.getCardReaderConfig(id, context: context) ?? entity.StationCardReaderConfig(cardReader: entity.CardReader.not_used);

    _controllers["cardReaderHost"]!.text = _cardReaderConfig.value.host ?? "";
    _controllers["cardReaderPort"]!.text = _cardReaderConfig.value.port ?? "";
  }

  /*

    Future<void> _getCardMultiplicatorsConfig(Repository repository, int id) async {
    String banknoteMultiplicator = await repository.getConfigVarString("banknote_multiplicator") ?? '';
    _controllers["banknoteMultiplicator"]!.text = banknoteMultiplicator;

    String coinMultiplicator = await repository.getConfigVarString("coin_multiplicator") ?? '';
    _controllers["coinMultiplicator"]!.text = coinMultiplicator;
  }
   */

  Future<void> _loadSkins(Repository repository) async {
    try {
      final skins = await repository.listSkins(context: context);
      setState(() {
        _availableSkins = skins;
      });
    } catch (_) {}
  }

  Future<void> _loadConstants(Repository repository, int id) async {
    // int
    final vars = await repository.listStationConfigVarInt(id, context: context);
    if (vars != null) {
      final oldKeys = _constantsConfig.value.keys.toSet();
      for (var key in oldKeys) {
        if (!vars.containsKey(key)) {
          _controllers["const_$key"]?.dispose();
          _controllers.remove("const_$key");
        }
      }
      for (var entry in vars.entries) {
        final ctrlKey = "const_${entry.key}";
        if (!_controllers.containsKey(ctrlKey)) {
          _controllers[ctrlKey] = TextEditingController();
        }
        _controllers[ctrlKey]!.text = entry.value;
      }
      _constantsConfig.value = vars;
      _origIntValues = Map.from(vars);
    }

    // bool
    final boolVars = await repository.listStationConfigVarBool(id, context: context);
    if (boolVars != null) {
      _boolConstantsConfig.value = boolVars;
      _origBoolValues = Map.from(boolVars);
    }

    // string
    final stringVars = await repository.listStationConfigVarString(id, context: context);
    if (stringVars != null) {
      for (var key in _stringConstantsConfig.value.keys) {
        if (!stringVars.containsKey(key)) {
          _controllers["strconst_$key"]?.dispose();
          _controllers.remove("strconst_$key");
        }
      }
      for (var entry in stringVars.entries) {
        final ctrlKey = "strconst_${entry.key}";
        if (!_controllers.containsKey(ctrlKey)) {
          _controllers[ctrlKey] = TextEditingController();
        }
        _controllers[ctrlKey]!.text = entry.value;
      }
      _stringConstantsConfig.value = stringVars;
      _origStringValues = Map.from(stringVars);
    }
  }

  Future<void> _saveConstants(Repository repository, int id) async {
    // int — only changed
    for (var key in _constantsConfig.value.keys) {
      final text = _controllers["const_$key"]?.text ?? "";
      if (text == _origIntValues[key]) continue;
      final val = int.tryParse(text);
      if (val != null) {
        await repository.setStationConfigVarInt(id, key, val, context: context);
      }
    }
    // bool — only changed
    for (var entry in _boolConstantsConfig.value.entries) {
      if (entry.value == _origBoolValues[entry.key]) continue;
      await repository.setStationConfigVarBool(id, entry.key, entry.value, context: context);
    }
    // string — only changed
    for (var key in _stringConstantsConfig.value.keys) {
      final text = _controllers["strconst_$key"]?.text ?? "";
      if (text == _origStringValues[key]) continue;
      await repository.setStationConfigVarString(id, key, text, context: context);
    }
  }

  Future<void> _getStationButtonsConfig(Repository repository, int id) async {
    var buttons = List.generate(maxButtons, (index) => entity.StationButton(buttonID: index + 1));

    final res = await repository.getStationButtons(id, context: context) ?? <entity.StationButton>[];
    res.forEach((element) {
      buttons[element.buttonID - 1] = element;
    });

    final programs = await repository.getPrograms() ?? [];
    _programs = [entity.Program(-1)]..addAll(programs);

    _buttonsConfig.value = buttons;
  }

  @override
  Widget build(BuildContext context) {
    final initialArgs = ModalRoute.of(context)?.settings.arguments;

    if (!isArgsValid(initialArgs, context)) {
      return const SizedBox.shrink();
    }

    final args = initialArgs as Map<PageArgCode, dynamic>;
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
          "${context.tr('post')} $id - $ip",
        ),
      ),
      key: _scaffoldKey,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Card(
            child: ExpansionTile(
              title: Text(
                context.tr('post_settings'),
                style: theme.textTheme.titleLarge,
              ),
              childrenPadding: EdgeInsets.all(8),
              children: [
                ValueListenableBuilder(
                  valueListenable: _config,
                  builder: (BuildContext context, entity.StationConfig? config, Widget? child) {
                    var hashes = repository.getHashesNotifier().value ?? [];

                    return Form(
                      key: _formKeyPost,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Text(
                                  context.tr('name'),
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
                                      return "${context.tr('field_must_not_be_empty')}";
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
                                  context.tr('hash'),
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: DropdownButtonFormField(
                                  isExpanded: true,
                                  value: config?.hash ?? "",
                                  items: List.generate(
                                    hashes.length,
                                        (index) => DropdownMenuItem(
                                      child: Text(hashes[index]),
                                      value: hashes[index],
                                    ),
                                  ),
                                  onChanged: (String? value) {
                                    _config.value = _config.value.copyWith(hash: value);
                                    log(value.toString());
                                  },
                                  validator: (value) {
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
                                  "${context.tr('preflight')} (${context.tr('seconds')})",
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
                                      return "${context.tr('the_preflight_time_must_not_be_less_than')} 0";
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
                                  context.tr('processing'),
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
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Text(
                                  context.tr('skins'),
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  value: (config?.firmwareSkin ?? "").isEmpty ? "" : config?.firmwareSkin,
                                  items: [
                                    DropdownMenuItem(
                                      value: "",
                                      child: Text("—"),
                                    ),
                                    ..._availableSkins.map(
                                      (s) => DropdownMenuItem(
                                        value: s.name,
                                        child: Text(s.name),
                                      ),
                                    ),
                                  ],
                                  onChanged: (String? value) {
                                    _config.value = _config.value.copyWith(firmwareSkin: value ?? "");
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ProgressTextButton(
                      onPressed: () async {
                        if (_formKeyPost.currentState!.validate()) {
                          await repository.saveStationConfig(_config.value, context: context).then((value) => _getPostConfig(repository, id, context));
                        }
                      },
                      child: Text("${context.tr('save')}"),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: ProgressTextButton(
                        onPressed: () async {
                          await _getPostConfig(repository, id, context);
                        },
                        child: Text(
                          "${context.tr('get_current_configuration')}",
                          softWrap: true,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Card(
            child: ExpansionTile(
              title: Text(
                context.tr('card_reader_settings'),
                style: theme.textTheme.titleLarge,
              ),
              childrenPadding: EdgeInsets.all(8),
              children: [
                ValueListenableBuilder(
                  valueListenable: _cardReaderConfig,
                  builder: (BuildContext context, entity.StationCardReaderConfig value, Widget? child) {
                    return Form(
                      key: _formKeyCardReader,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Text(context.tr('type')),
                              ),
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: DropdownButton(
                                  isExpanded: true,
                                  value: value.cardReader,
                                  items: entity.CardReader.values.map((e) {
                                    return DropdownMenuItem(
                                      value: e,
                                      child: Text(e.label()),
                                    );
                                  }).toList(),
                                  onChanged: (newVal) {
                                    _cardReaderConfig.value = value.copyWith(cardReader: newVal);
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
                                  context.tr('host'),
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
                                  context.tr('port'),
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
                        ],
                      ),
                    );
                  },
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ProgressTextButton(
                      onPressed: () async {
                        if (_formKeyCardReader.currentState!.validate()) {
                          await repository.saveCardReaderConfig(id, _cardReaderConfig.value, context: context);
                        }
                      },
                      child: Text("${context.tr('save')}"),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: ProgressTextButton(
                        onPressed: () async {
                          await _getCardReaderConfig(repository, id);
                        },
                        child: Text("${context.tr('get_current_configuration')}"),
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
                context.tr('buttons_binding'),
                style: theme.textTheme.titleLarge,
              ),
              childrenPadding: EdgeInsets.all(8),
              children: [
                ValueListenableBuilder(
                  valueListenable: _buttonsConfig,
                  builder: (BuildContext context, List<entity.StationButton> buttons, Widget? child) {
                    return Column(
                      children: List.generate(
                        buttons.length,
                            (index) {
                          return Row(
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Text("${context.tr('button')} ${buttons[index].buttonID}"),
                              ),
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: DropdownButton<int>(
                                  isExpanded: true,
                                  value: buttons[index].programID ?? -1,
                                  items: _programs.map((p) {
                                    return DropdownMenuItem(
                                      value: p.id ?? -1,
                                      child: Text("${p.id != -1 ? p.id : ""}".padLeft(4) + " : ${p.name}"),
                                    );
                                  }).toList(),
                                  onChanged: (int? value) {
                                    final config = [..._buttonsConfig.value];
                                    config[index] = config[index].copyWith(programID: value, clearProgramID: value == null);
                                    _buttonsConfig.value = config;
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ProgressTextButton(
                      onPressed: () async {
                        await repository.saveStationButtons(id, _buttonsConfig.value, context: context);
                        await _getStationButtonsConfig(repository, id);
                      },
                      child: Text("${context.tr('save')}"),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: ProgressTextButton(
                        onPressed: () async {
                          await _getStationButtonsConfig(repository, id);
                        },
                        child: Text("${context.tr('get_current_configuration')}"),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Card(
            child: ExpansionTile(
              title: Text(
                context.tr('station_constants'),
                style: theme.textTheme.titleLarge,
              ),
              childrenPadding: EdgeInsets.all(8),
              children: [
                ValueListenableBuilder(
                  valueListenable: _constantsConfig,
                  builder: (BuildContext context, Map<String, String> vars, Widget? child) {
                    if (vars.isEmpty) {
                      return Text(context.tr('no_data'));
                    }
                    return Table(
                      border: TableBorder.all(color: theme.dividerColor),
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(1),
                      },
                      children: [
                        TableRow(
                          decoration: BoxDecoration(color: theme.colorScheme.surfaceVariant),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(context.tr('name'), style: theme.textTheme.titleSmall),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(context.tr('value'), style: theme.textTheme.titleSmall),
                            ),
                          ],
                        ),
                        ...vars.keys.map((key) {
                          return TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(key, style: theme.textTheme.bodyMedium),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: TextFormField(
                                  controller: _controllers["const_$key"],
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    FilteringTextInputFormatter.singleLineFormatter,
                                  ],
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    );
                  },
                ),
                SizedBox(height: 8),
                // Bool constants
                ValueListenableBuilder(
                  valueListenable: _boolConstantsConfig,
                  builder: (BuildContext context, Map<String, bool> boolVars, Widget? child) {
                    if (boolVars.isEmpty) return SizedBox.shrink();
                    return Table(
                      border: TableBorder.all(color: theme.dividerColor),
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(1),
                      },
                      children: [
                        ...boolVars.entries.map((entry) {
                          return TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(entry.key, style: theme.textTheme.bodyMedium),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Switch(
                                  value: entry.value,
                                  onChanged: (val) {
                                    final updated = Map<String, bool>.from(_boolConstantsConfig.value);
                                    updated[entry.key] = val;
                                    _boolConstantsConfig.value = updated;
                                  },
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    );
                  },
                ),
                SizedBox(height: 8),
                // String constants
                ValueListenableBuilder(
                  valueListenable: _stringConstantsConfig,
                  builder: (BuildContext context, Map<String, String> strVars, Widget? child) {
                    if (strVars.isEmpty) return SizedBox.shrink();
                    return Table(
                      border: TableBorder.all(color: theme.dividerColor),
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(1),
                      },
                      children: [
                        ...strVars.keys.map((key) {
                          return TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(key, style: theme.textTheme.bodyMedium),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: TextFormField(
                                  controller: _controllers["strconst_$key"],
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    );
                  },
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ProgressTextButton(
                      onPressed: () async {
                        await _saveConstants(repository, id);
                      },
                      child: Text("${context.tr('save')}"),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: ProgressTextButton(
                        onPressed: () async {
                          await _loadConstants(repository, id);
                        },
                        child: Text("${context.tr('get_current_configuration')}"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
