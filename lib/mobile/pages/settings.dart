import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/common/ProgressButton.dart';
import 'package:mobile_wash_control/mobile/widgets/common/washNavigationDrawer.dart';
import 'package:mobile_wash_control/mobile/widgets/settings/settingsStationListTile.dart';
import 'package:mobile_wash_control/repository/repository.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _dateFormat = new DateFormat("dd.MM.yyyy");

    _timeZoneValuesDropList = _getTimeZoneValuesDropList();
    super.initState();
  }

  @override
  void dispose() {
    _operatorServiceAmountController.dispose();
    super.dispose();
  }

  final List<int> _timeZoneValues = [
    -12 * 60,
    -11 * 60,
    -10 * 60,
    -9 * 60 - 30,
    -9 * 60,
    -8 * 60,
    -7 * 60,
    -6 * 60,
    -5 * 60,
    -4 * 60,
    -3 * 60 - 30,
    -3 * 60,
    -2 * 60,
    -1 * 60,
    0,
    1 * 60,
    2 * 60,
    3 * 60,
    3 * 60 + 30,
    4 * 60,
    4 * 60 + 30,
    5 * 60,
    5 * 60 + 30,
    5 * 60 + 45,
    6 * 60,
    6 * 60 + 30,
    7 * 60,
    8 * 60,
    8 * 60 + 45,
    9 * 60,
    9 * 60 + 30,
    10 * 60,
    10 * 60 + 30,
    11 * 60,
    12 * 60,
    12 * 60 + 45,
    13 * 60,
    14 * 60,
  ];

  List<DropdownMenuItem> _getTimeZoneValuesDropList() {
    return List.generate(
      _timeZoneValues.length,
      (index) => DropdownMenuItem(
        child: Center(
          child: Text(
            "UTC"
            "${_timeZoneValues[index].sign < 0 ? '-' : '+'}"
            "${(_timeZoneValues[index] ~/ 60).abs() < 10 ? '0' : ''}"
            "${(_timeZoneValues[index] ~/ 60).abs()}:"
            "${_timeZoneValues[index] % 60 != 0 ? (_timeZoneValues[index] % 60).toString() : "00"}",
          ),
        ),
        value: _timeZoneValues[index],
      ),
    )..add(
        DropdownMenuItem(
          enabled: false,
          child: Center(
            child: Text(
              "...",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          value: -1,
        ),
      );
  }

  List<DropdownMenuItem> _timeZoneValuesDropList = [];

  ValueNotifier<LeaCentralConfig?> _config = ValueNotifier(null);

  Future<void> getSettings(Repository repository, BuildContext context) async {
    var timezone = await repository.getConfigVarInt("TIMEZONE");
    _config.value = LeaCentralConfig(timeZone: timezone);
  }

  late DateFormat _dateFormat;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _operatorServiceAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final DateTime currentTime = DateTime.now();

    final args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final repository = args[PageArgCode.repository] as Repository;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Настройки"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Дата: ${_dateFormat.format(currentTime)}",
                ),
              ],
            ),
          )
        ],
      ),
      drawer: WashNavigationDrawer(
        selected: SelectedPage.Settings,
        repository: repository,
      ),
      body: FutureBuilder(
        future: getSettings(repository, context),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          return RefreshIndicator(
            onRefresh: () async {
              await getSettings(repository, context);
            },
            child: ListView(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text(
                                "Часовой пояс: ",
                                style: theme.textTheme.bodyLarge,
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              fit: FlexFit.tight,
                              child: StatefulBuilder(
                                builder: (BuildContext context, void Function(void Function()) setState) {
                                  return DropdownButton(
                                    isExpanded: true,
                                    items: _timeZoneValuesDropList,
                                    value: _config.value?.timeZone ?? -1,
                                    onChanged: (val) async {
                                      await repository.setConfigVarInt("TIMEZONE", val, context: context).then((value) => getSettings(repository, context));
                                      setState(() {});
                                    },
                                  );
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                (repository.currentUser()?.isAdmin ?? false)
                    ? Card(
                        child: Form(
                          key: _formKey,
                          child: StatefulBuilder(
                            builder: (BuildContext context, void Function(void Function()) setState) {
                              return FutureBuilder(
                                future: repository.getConfigVarInt("DEFAULT_OPERATOR_SERVICE_MONEY").then((value) {
                                  _operatorServiceAmountController.text = value?.toString() ?? "10";
                                }),
                                builder: (BuildContext context, AsyncSnapshot<int?> snapshot) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: (snapshot.connectionState != ConnectionState.done)
                                              ? LinearProgressIndicator()
                                              : TextFormField(
                                                  controller: _operatorServiceAmountController,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.digitsOnly,
                                                  ],
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return "поле не может быть пустым";
                                                    }
                                                    return null;
                                                  },
                                                ),
                                        ),
                                        Text("Сервисные деньги, которые зачисляет оператор"),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ProgressButton(
                                            onPressed: () async {
                                              if (_formKey.currentState!.validate()) {
                                                int amount = int.tryParse(_operatorServiceAmountController.value.text) ?? 0;

                                                await repository.setConfigVarInt("DEFAULT_OPERATOR_SERVICE_MONEY", amount);
                                                var value = await repository.getConfigVarInt("DEFAULT_OPERATOR_SERVICE_MONEY");
                                                _operatorServiceAmountController.text = value?.toString() ?? "10";
                                              }
                                            },
                                            child: Text("Сохранить"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      )
                    : SizedBox(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        child: Text("Настройки кассы"),
                        onPressed: () {
                          var args = Map<PageArgCode, dynamic>();
                          args[PageArgCode.repository] = repository;

                          Navigator.pushNamed(
                            context,
                            "/mobile/settings/kasse",
                            arguments: args,
                          );
                        },
                      ),
                      ElevatedButton(
                        child: Text("Предустановки постов"),
                        onPressed: () {
                          args[PageArgCode.repository] = repository;
                          Navigator.pushNamed(
                            context,
                            "/mobile/settings/default",
                            arguments: args,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Card(
                  child: ValueListenableBuilder(
                    valueListenable: repository.getStationsNotifier(),
                    builder: (BuildContext context, List<Station>? value, Widget? child) {
                      return Column(
                        children: List.generate(
                          value?.length ?? 0,
                          (index) => SettingsStationListTile(
                            index: index + 1,
                            station: value![index],
                            repository: repository,
                            onPressed: () {
                              var args = Map<PageArgCode, dynamic>();
                              args[PageArgCode.stationID] = value[index].id;
                              args[PageArgCode.stationIP] = value[index].ip;
                              args[PageArgCode.repository] = repository;

                              Navigator.pushNamed(context, "/mobile/settings/post", arguments: args).then(
                                (value) {
                                  getSettings(repository, context);
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
