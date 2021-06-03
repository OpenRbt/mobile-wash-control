import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';
import 'package:mobile_wash_control/desktop/DSettingsMenuPost.dart';

class DSettingsMenuArgs {}

class DSettingsData {
  final int id;
  final String ip;
  final String name;
  final String hash;
  final String status;

  DSettingsData(this.id, this.ip, this.name, this.hash, this.status);
}

class DSettingsMenu extends StatefulWidget {
  @override
  _DSettingsMenuState createState() => _DSettingsMenuState();
}

class _DSettingsMenuState extends State<DSettingsMenu> {
  _DSettingsMenuState() : super();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);

  bool _firstLoad = true;
  String _currentTemp = "__";
  List<DSettingsData> _settingsData = List.generate(10, (index) {
    return new DSettingsData(-1, "...", "Loading", "$index", "loading");
  });

  List<String> _availableHashes = List();

  void getSettings(SessionData sessionData) async {
    try {
      var res = await sessionData.client.status();
      var tmp = res.stations.where((element) => element.hash != null).toList();
      _availableHashes = List();
      tmp.forEach((element) {
        _availableHashes.add(element.hash);
      });
      res.stations =
          res.stations.where((element) => element.id != null).toList();
      if (!mounted) {
        return;
      }
      var args = LoadArgs();
      _settingsData = List.generate((res.stations.length), (index) {
        return new DSettingsData(
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
            args.hash = res.stations[i].hash;
            args.key = "curr_temp";
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


    var screenW = MediaQuery.of(context).size.width;
    var screenH = MediaQuery.of(context).size.height;

    var width = screenW - screenW / 4;
    var height = screenH;
    return Scaffold(
      key: _scaffoldKey,
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
            child: Row(children: [
              DGetDrawer(screenH, screenW/4, context, Pages.Settings, sessionData),
              SizedBox(
                height: height,
                width: width,
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
                            width: width / 9 * 2,
                            child: Center(
                              child: Text(
                                "Дата ",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: width / 9 * 2,
                            child: RaisedButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              child: Text(
                                  "${currentTime.day}.${currentTime.month}.${currentTime.year}"),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: width / 9 * 2,
                            child: Center(
                              child: Text(
                                "Tемп ",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: width / 9 * 2,
                            child: RaisedButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              child: Text("${_currentTemp}"),
                            ),
                          ),
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                          width: width * 3 / 13,
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
                          width: width * 3 / 13,
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
                          width: width * 3 / 13,
                          child: Center(
                            child: Text(
                              "IP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: width * 3 / 13,
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
                              width: width * 3 / 13,
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
                              width: width * 3 / 13,
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
                              width: width * 3 / 13,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? Colors.white
                                      : Colors.black12,
                                  border: Border.all(color: Colors.black38),
                                ),
                                child: Center(
                                  child: Text(
                                    "${_settingsData[index].ip}",
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: width * 3 / 13,
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
                              width: width / 13,
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
                                    var args = DSettingsMenuPostArgs(
                                        _settingsData[index].id,
                                        _settingsData[index].ip,
                                        _availableHashes,
                                        sessionData);
                                    Navigator.pushNamed(
                                            context, "/desktop/settings/post",
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
                      child: RaisedButton(
                        color: Colors.lightGreen,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        splashColor: Colors.lightGreenAccent,
                        padding: EdgeInsets.all(8.0),
                        child: Text("Настройки кассы"),
                        onPressed: () {
                          Navigator.pushNamed(context, "/mobile/settings/kasse",
                              arguments: sessionData);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: 50,
                      child: RaisedButton(
                        color: Colors.lightGreen,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        splashColor: Colors.lightGreenAccent,
                        padding: EdgeInsets.all(8.0),
                        child: Text("Стандартные настройки"),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, "/mobile/settings/default",
                              arguments: sessionData);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ],
            ),
        )
            ],)  );
        },
      ),
    );
  }
}
