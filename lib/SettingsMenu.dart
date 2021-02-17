import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'client/api.dart';

class SettingsMenuArgs {}

class SettingsData {
  final int id;
  final String name;
  final String hash;
  final String status;

  SettingsData(this.id, this.name, this.hash, this.status);
}

class SettingsMenu extends StatefulWidget {
  @override
  _SettingsMenuState createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  _SettingsMenuState() : super();

  bool _firstLoad = true;
  String _currentTemp = "__";
  List<SettingsData> _settingsData = List.generate(8, (index) {
    return new SettingsData(-1, "Loading", "...", "loading");
  });

  void GetSettings(SessionData sessionData) async {
    try {
      var res = await sessionData.client.status();
      if (!mounted) {
        return;
      }
      var args = Args9();
        _settingsData = List.generate((res.stations.length), (index) {
          return new SettingsData(
              res.stations[index].id,
              res.stations[index].name,
              res.stations[index].hash,
              res.stations[index].status.value);
        });

        _settingsData.sort((a, b) => a.id.compareTo(b.id));
        _firstLoad = false;

      if (res.stations.length > 0) {
        for (int i = 0 ; i < res.stations.length; i++){
          if (res.stations[i].hash != null && res.stations[i].hash.length > 0){
            args.hash = res.stations[i].hash;
            args.key = "curr_temp";
            var resTemp = await sessionData.client.load(args);
            _currentTemp = resTemp ?? _currentTemp;
            _currentTemp =  _currentTemp.replaceAll(String.fromCharCode(34), '');
            break;
          }
        }

      }
    } catch (e) {
      print("Exception when calling DefaultApi->Status: $e\n");
    }

    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    final DateTime currentTime = DateTime.now();
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;

    if (_firstLoad) {
      GetSettings(sessionData);
    }

    final AppBar appBar = AppBar(
      title: Text("Настройки"),
    );

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar,
      drawer: prepareDrawer(context, Pages.Settings, sessionData),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return new ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Дата ", style: TextStyle(fontSize: 16)),
                        SizedBox(
                          width: 80,
                          child: RaisedButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: Text(
                                "${currentTime.day}.${currentTime.month}.${currentTime.year}"),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Tемп. ",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          width: 80,
                          child: RaisedButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: Text("$_currentTemp"),
                          ),
                        )
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 110,
                        child: Text(
                          "Список постов",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 110,
                        child: Text("Адрес",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        width: 110,
                        child: Text("Статус",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  Table(
                      border: TableBorder.all(),
                      defaultColumnWidth: FixedColumnWidth(110),
                      children: List.generate(_settingsData.length, (index) {
                        return new TableRow(children: [
                          Text("${_settingsData[index].name}"),
                          Text(
                            "${_settingsData[index].hash}",
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "${_settingsData[index].status}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: _settingsData[index].status == "online"
                                    ? Colors.lightGreen
                                    : Colors.red),
                          )
                        ]);
                      })),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                          width: screenW / 3,
                          child: RaisedButton(
                            color: Colors.lightGreen,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            padding: EdgeInsets.all(8.0),
                            splashColor: Colors.lightGreenAccent,
                            onPressed: () {},
                            child: Text("Сохранить",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(
                          width: screenW / 6,
                        ),
                        SizedBox(
                          height: 50,
                          width: screenW / 3,
                          child: RaisedButton(
                            color: Colors.lightGreen,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            padding: EdgeInsets.all(8.0),
                            splashColor: Colors.lightGreenAccent,
                            onPressed: () {},
                            child: Text("Отменить",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          ),
                        )
                      ])
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

TableRow createTableRow(List values) {
  List<TableCell> result = [];
  for (var val in values) {
    result.add(TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Center(child: Text(val.toString())),
    ));
  }
}
