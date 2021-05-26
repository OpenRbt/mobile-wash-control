import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';

class SettingsDefaultConfigs extends StatefulWidget {
  @override
  _SettingsDefaultConfigsState createState() => _SettingsDefaultConfigsState();
}

class _SettingsDefaultConfigsState extends State<SettingsDefaultConfigs> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);

  List<bool> _stationsToSave = List.filled(12, false);

  final List<String> _dropDownNames = ["----"]
    ..addAll(DefaultConfig.configs.keys);
  String _dropDownValue = "----";

  bool _canSet = true;

  void _setSettings(SessionData sessionData) async {
    _canSet = false;
    if (_dropDownValue != "----") {
      StationsDefaultConfig config = DefaultConfig.configs[_dropDownValue];

      config.programs.forEach((element) async {
        try {
          var res = await sessionData.client.setProgram(element);
        } catch (e) {
          print(e);
        }
      });

      for (int i = 0; i < _stationsToSave.length; i++) {
        if (_stationsToSave[i]) {
          try {
            var args = SetStationButtonsArgs();
            args.stationID = i + 1;
            args.buttons = config.stationPrograms;
            var res = await sessionData.client.setStationButton(args);
          } catch (e) {}
        }
      }

      showInfoSnackBar(
          _scaffoldKey, _isSnackBarActive, "Настройки сохранены", Colors.green);
    }
    _stationsToSave = List.filled(12, false);
    _canSet = true;
  }

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;

    final AppBar appBar = AppBar(
      title: Text("Стандартные настройки"),
    );
    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar,
      key: _scaffoldKey,
      body: ListView(
        children: [
          SizedBox(
            height: 75,
            child: Center(
              child: Text(
                "Выберите посты",
                style: TextStyle(fontSize: 32),
              ),
            ),
          ),
          Divider(
            color: Colors.lightGreen,
            thickness: 3,
          ),
          Column(
            children: List.generate(_stationsToSave.length, (index) {
              return SizedBox(
                height: 50,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: index % 2 == 0 ? Colors.black12 : Colors.white,
                  ),
                  child: CheckboxListTile(
                    title: Text("Пост ${index + 1}"),
                    value: _stationsToSave[index],
                    onChanged: (newValue) {
                      _stationsToSave[index] = !_stationsToSave[index];
                      setState(() {});
                    },
                  ),
                ),
              );
            }),
          ),
          Divider(
            color: Colors.lightGreen,
            thickness: 3,
          ),
          SizedBox(
            height: 75,
            child: Center(
              child: Text(
                "Выберите тип поста",
                style: TextStyle(fontSize: 32),
              ),
            ),
          ),
          SizedBox(
            height: 75,
            child: Center(
              child: DropdownButton(
                isExpanded: false,
                value: _dropDownValue,
                items: List.generate(
                  _dropDownNames.length,
                  (index) {
                    return DropdownMenuItem(
                      value: _dropDownNames[index],
                      child: Text(
                        _dropDownNames[index],
                        style: TextStyle(fontSize: 32),
                      ),
                    );
                  },
                ),
                onChanged: (newValue) {
                  _dropDownValue = newValue;
                  setState(() {});
                },
              ),
            ),
          ),
          SizedBox(
            height: 75,
            width: screenW / 5 * 4,
            child: RaisedButton(
              color: Colors.lightGreen,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              child: Center(
                child: Text(
                  "Установить",
                  style: TextStyle(fontSize: 32),
                ),
              ),
              onPressed: _canSet
                  ? () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Загрузить настройки?"),
                          content: Text(
                              "Настройки для программи кнопок будут установлены по умолчанию"),
                          actionsPadding: EdgeInsets.all(10),
                          actions: [
                            RaisedButton(
                              color: Colors.lightGreen,
                              textColor: Colors.white,
                              disabledColor: Colors.grey,
                              disabledTextColor: Colors.black,
                              onPressed: () {
                                _setSettings(sessionData);
                                Navigator.pop(context);
                              },
                              child: Text("Да"),
                            ),
                            RaisedButton(
                              color: Colors.white,
                              textColor: Colors.black,
                              disabledColor: Colors.grey,
                              disabledTextColor: Colors.black,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Нет"),
                            )
                          ],
                        ),
                      );
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
