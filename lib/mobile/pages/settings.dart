import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/common/washNavigationDrawer.dart';
import 'package:mobile_wash_control/mobile/widgets/settings/settingsStationListTile.dart';
import 'package:mobile_wash_control/repository/lea_central_wash_repo/repository.dart';
import 'package:mobile_wash_control/repository/repository.dart';

//TODO: remove this!
class SettingsData {
  final int id;
  final String ip;
  final String name;
  final String hash;
  final String status;

  SettingsData(this.id, this.ip, this.name, this.hash, this.status);
}

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

  String _currentTemp = "__";
  List<SettingsData> _settingsData = List.generate(10, (index) {
    return new SettingsData(-1, "...", "Loading", "$index", "loading");
  });

  List<String> _availableHashes = [];

  int _timeZone = -1;
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

  Future<void> getSettings(Repository repository) async {
    var timezone = await repository.getConfigVarInt("TIMEZONE");
    _config.value = LeaCentralConfig(timeZone: timezone);
  }

  late DateFormat _dateFormat;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final DateTime currentTime = DateTime.now();

    final args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final repository = args[PageArgCode.repository] as LeaCentralRepository;

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
        future: getSettings(repository),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          return RefreshIndicator(
            onRefresh: () async {
              await getSettings(repository);
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
                              child: DropdownButton(
                                isExpanded: true,
                                items: _timeZoneValuesDropList,
                                value: _config.value?.timeZone ?? -1,
                                onChanged: (val) async {
                                  await repository.setConfigVarInt("TIMEZONE", val).then((value) => getSettings(repository));
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
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
                                  getSettings(repository);
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
