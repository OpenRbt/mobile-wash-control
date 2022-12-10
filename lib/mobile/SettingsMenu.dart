import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';
import 'package:mobile_wash_control/mobile/SettingsMenuPost.dart';

class SettingsMenuArgs {}

class SettingsData {
  final int id;
  final String ip;
  final String name;
  final String hash;
  final String status;

  SettingsData(this.id, this.ip, this.name, this.hash, this.status);
}

class SettingsMenu extends StatefulWidget {
  @override
  _SettingsMenuState createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  _SettingsMenuState() : super() {
    _timeZoneValuesDropList = _getTimeZoneValuesDropList();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);

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
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
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

  void getSettings(SessionData sessionData) async {
    try {
      _timeZone = (await sessionData.client
              .getConfigVarInt(ArgGetConfigVar(name: "TIMEZONE")))
          .value;
      if (!_timeZoneValues.contains(_timeZone)) {
        _timeZone = -1;
      } else {
        _timeZoneValuesDropList.removeWhere((element) => element.value == -1);
      }
      var res = await sessionData.client.status();
      var tmp = res.stations.where((element) => element.hash != null).toList();
      _availableHashes = [];
      tmp.forEach((element) {
        _availableHashes.add(element.hash);
      });
      res.stations =
          res.stations.where((element) => element.id != null).toList();
      if (!mounted) {
        return;
      }
      _settingsData = List.generate((res.stations.length), (index) {
        return new SettingsData(
            res.stations[index].id,
            res.stations[index].ip,
            res.stations[index].name,
            res.stations[index].hash,
            res.stations[index].status.value);
      });

      _settingsData.sort(
        (a, b) => a.id.compareTo(b.id),
      );
      _firstLoad = false;

      if (res.stations.length > 0) {
        for (int i = 0; i < res.stations.length; i++) {
          if (res.stations[i].hash != null && res.stations[i].hash.length > 0) {
            var args = ArgLoad(
              hash: res.stations[i].hash,
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
      showInfoSnackBar(_scaffoldKey, _isSnackBarActive,
          "Произошла ошибка при запросе к api", Colors.red);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final DateTime currentTime = DateTime.now();
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;

    if (_firstLoad) {
      getSettings(sessionData);
    }

    final AppBar appBar = AppBar(
      title: Text("Настройки"),
    );

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar,
      drawer: prepareDrawer(context, Pages.Settings, sessionData),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return RefreshIndicator(
            onRefresh: () async {
              var tmp = await getSettings(sessionData);
              await Future.delayed(
                Duration(milliseconds: 500),
              );
              setState(() {});
            },
            child: ListView(
              children: [
                SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                            width: screenW / 9 * 2,
                            child: Center(
                              child: Text(
                                "Дата ",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: screenW / 9 * 2,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                  "${currentTime.day}.${currentTime.month}.${currentTime.year}"),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: screenW / 9 * 2,
                            child: Center(
                              child: Text(
                                "Tемп ",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: screenW / 9 * 2,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text("${_currentTemp}"),
                            ),
                          ),
                        ]),
                    _TimeZoneRow(sessionData),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                          width: screenW / 7 * 2,
                          child: Center(
                            child: Text(
                              "Список постов",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: screenW / 7 * 2,
                          child: Center(
                            child: Text(
                              "Хэш",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: screenW / 7 * 2,
                          child: Center(
                            child: Text(
                              "Статус",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: List.generate(_settingsData.length, (index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                              width: screenW / 7 * 2,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? Colors.white
                                      : Colors.black12,
                                  border: Border.all(color: Colors.black38),
                                ),
                                child: Center(
                                  child: Text(
                                    "${_settingsData[index].name}",
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: screenW / 7 * 2,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? Colors.white
                                      : Colors.black12,
                                  border: Border.all(color: Colors.black38),
                                ),
                                child: Center(
                                  child: Text(
                                    "${_settingsData[index].hash}",
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: screenW / 7 * 2,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? Colors.white
                                      : Colors.black12,
                                  border: Border.all(color: Colors.black38),
                                ),
                                child: Center(
                                  child: Text(
                                    "${_settingsData[index].status}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: _settingsData[index].status ==
                                                "online"
                                            ? Colors.lightGreen
                                            : Colors.red),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: screenW / 7,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? Colors.white
                                      : Colors.black12,
                                  border: Border.all(color: Colors.black38),
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.more_horiz),
                                  onPressed: () {
                                    var args = SettingsMenuPostArgs(
                                        _settingsData[index].id,
                                        _settingsData[index].ip,
                                        _availableHashes,
                                        sessionData);
                                    Navigator.pushNamed(
                                            context, "/mobile/settings/post",
                                            arguments: args)
                                        .then((value) {
                                      getSettings(sessionData);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
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
                          child: Text("Настройки кассы"),
                          onPressed: () {
                            Navigator.pushNamed(context, "/mobile/settings/kasse",
                                arguments: sessionData);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
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
                          child: Text("Стандартные настройки"),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, "/mobile/settings/default",
                                arguments: sessionData);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
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

  Widget _TimeZoneRow(SessionData sessionData) {
    return Container(
      width: MediaQuery.of(context).size.width * 8 / 9,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Text(
                "TimeZone",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 50,
              child: DropdownButton(
                enableFeedback: true,
                isExpanded: true,
                items: _timeZoneValuesDropList,
                value: _timeZone,
                onChanged: (val) async {
                  try {
                    await sessionData.client.setConfigVarInt(ConfigVarInt(
                        name: "TIMEZONE",
                        value: val,
                        description: "UTC in minutes"));
                    if (_timeZone == -1)
                      _timeZoneValuesDropList
                          .removeWhere((element) => element.value == -1);
                    _timeZone = val;
                  } catch (e) {
                    print(e);
                    showInfoSnackBar(_scaffoldKey, _isSnackBarActive,
                        "Не удалось изменить таймзону", Colors.red);
                  }
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
