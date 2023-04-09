import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/SharedData.dart';
import 'package:mobile_wash_control/client/api.dart';
import 'package:mobile_wash_control/mobile/SettingsMenu.dart';
import 'package:mobile_wash_control/mobile/SettingsMenuPost.dart';
import 'package:mobile_wash_control/mobile/widgets/common/washNavigationDrawer.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late SessionData sessionData;
  @override
  void initState() {
    _dateFormat = new DateFormat("dd.MM.yyyy");
    sessionData = SharedData.sessionData!;

    _timeZoneValuesDropList = _getTimeZoneValuesDropList();
    super.initState();
  }

  bool _firstLoad = true;
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
    )..add(DropdownMenuItem(
        enabled: false,
        child: Center(
            child: Text(
          "Invalid value",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        )),
        value: -1,
      ));
  }

  List<DropdownMenuItem> _timeZoneValuesDropList = [];

  Future<void> getSettings(SessionData sessionData) async {
    try {
      _timeZone = ((await sessionData.client.getConfigVarInt(ArgGetConfigVar(name: "TIMEZONE")))?.value) ?? 0;
      if (!_timeZoneValues.contains(_timeZone)) {
        _timeZone = -1;
      } else {
        _timeZoneValuesDropList.removeWhere((element) => element.value == -1);
      }
      var res = await sessionData.client.status();
      var tmp = res!.stations.where((element) => element.hash != null).toList();
      _availableHashes = [];
      tmp.forEach((element) {
        _availableHashes.add(element.hash ?? "");
      });
      res.stations = res.stations.where((element) => element.id != null).toList();
      if (!mounted) {
        return;
      }
      _settingsData = List.generate((res.stations.length), (index) {
        return new SettingsData(res.stations[index].id ?? 0, res.stations[index].ip ?? "", res.stations[index].name ?? "", res.stations[index].hash ?? "", res.stations[index].status?.value ?? "");
      });

      _settingsData.sort(
        (a, b) => a.id.compareTo(b.id),
      );
      _firstLoad = false;
      log("res.stations.length: " + res.stations.length.toString());
      if (res.stations.length > 0) {
        for (int i = 0; i < res.stations.length; i++) {
          if (res.stations[i].hash != null && (res.stations[i].hash?.length ?? 0) > 0) {
            var args = ArgLoad(
              hash: res.stations[i].hash!,
              key: "curr_temp",
            );
            var resTemp = await sessionData.client.load(args);
            _currentTemp = resTemp ?? _currentTemp;

            _currentTemp = double.tryParse(
              _currentTemp.replaceAll(String.fromCharCode(34), ''),
            ).toString();
            break;
          }
        }
      }
      setState(() {});
    } catch (e) {
      print("Exception when calling DefaultApi->Status: $e\n");
    }
    setState(() {});
  }

  late DateFormat _dateFormat;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final DateTime currentTime = DateTime.now();
    final SessionData sessionData = SharedData.sessionData!;

    if (_firstLoad) {
      getSettings(sessionData);
    }

    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Настройки"),
      ),
      drawer: WashNavigationDrawer(
        selected: SelectedPage.Settings,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          var tmp = await getSettings(sessionData);
          setState(() {});
        },
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(8),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Дата: ${_dateFormat.format(currentTime)}",
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Температура: $_currentTemp",
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Часовой пояс: ",
                          style: theme.textTheme.bodyLarge,
                        ),
                        Expanded(
                          child: DropdownButton(
                            isExpanded: true,
                            items: _timeZoneValuesDropList,
                            value: _timeZone,
                            onChanged: (val) async {
                              try {
                                await sessionData.client.setConfigVarInt(ConfigVarInt(name: "TIMEZONE", value: val, description: "UTC in minutes"));
                                if (_timeZone == -1) _timeZoneValuesDropList.removeWhere((element) => element.value == -1);
                                _timeZone = val;
                              } catch (e) {
                                print(e);
                              }
                              setState(() {});
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
                      Navigator.pushNamed(context, "/mobile/settings/kasse", arguments: sessionData);
                    },
                  ),
                  ElevatedButton(
                    child: Text("Предустановки постов"),
                    onPressed: () {
                      Navigator.pushNamed(context, "/mobile/settings/default", arguments: sessionData);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Пост",
                    style: theme.textTheme.titleLarge,
                  ),
                  Text(
                    "Хэш",
                    style: theme.textTheme.titleLarge,
                  ),
                  Text(
                    "Статус",
                    style: theme.textTheme.titleLarge,
                  ),
                  SizedBox(),
                ],
              ),
            ),
            Column(
              children: List.generate(_settingsData.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: Text(
                          "${_settingsData[index].name}",
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Text(
                          "${_settingsData[index].hash}",
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Text(
                          "${_settingsData[index].status}",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: _settingsData[index].status == "online" ? Colors.lightGreen : Colors.red),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            var args = SettingsMenuPostArgs(_settingsData[index].id, _settingsData[index].ip, _availableHashes, sessionData);
                            Navigator.pushNamed(context, "/mobile/settings/post", arguments: args).then((value) {
                              getSettings(sessionData);
                            });
                          },
                          icon: Icon(Icons.settings_outlined)),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
