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

      for (int i = 1; i <= 12; i++) {
        try {
          var args = SetStationButtonsArgs();
          args.stationID = i;
          args.buttons = config.stationPrograms;
          var res = await sessionData.client.setStationButton(args);
        } catch (e) {}
      }

      showInfoSnackBar(
          _scaffoldKey, _isSnackBarActive, "Настройки сохранены", Colors.green);
    }

    _canSet = true;
  }

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;

    final AppBar appBar = AppBar(
      title: Text("Настройки по умолчанию"),
    );
    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar,
      key: _scaffoldKey,
      body: Column(
        children: [
          SizedBox(
            height: 75,
            child: Center(
              child: Text(
                "Выберите пресет",
                style: TextStyle(fontSize: 32),
              ),
            ),
          ),
          SizedBox(
            height: 75,
            width: screenW / 5 * 4,
            child: Center(
              child: DropdownButton(
                isExpanded: true,
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
                              "Настройки для программ 1-8 могут быть перезаписаны параметрами по умолчанию"),
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
