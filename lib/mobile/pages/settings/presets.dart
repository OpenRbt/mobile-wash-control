import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/SharedData.dart';
import 'package:mobile_wash_control/client/api.dart';

class PresetsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PresetsPageState();
}

class _PresetsPageState extends State<PresetsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<bool> _stationsToSave = List.filled(12, false);

  final List<String> _dropDownNames = ["----"]..addAll(DefaultConfig.configs.keys);
  String _dropDownValue = "----";

  bool _canSet = true;

  void _setSettings(SessionData sessionData) async {
    _canSet = false;
    if (_dropDownValue != "----") {
      StationsDefaultConfig? config = DefaultConfig.configs[_dropDownValue];

      int programLength = config?.programs.length ?? 0;
      for (int i = 0; i < programLength; i++) {
        try {
          var res = await sessionData.client.setProgram(config!.programs[i]);
        } catch (e) {
          print(e);
        }
      }

      for (int i = 0; i < _stationsToSave.length; i++) {
        if (_stationsToSave[i]) {
          try {
            var args = ArgSetStationButton(
              stationID: i + 1,
              buttons: config!.stationPrograms,
            );
            var res = await sessionData.client.setStationButton(args);
          } catch (e) {}
        }
      }
    }
    _stationsToSave = List.filled(12, false);
    _canSet = true;
  }

  @override
  Widget build(BuildContext context) {
    final sessionData = SharedData.sessionData!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Стандартные настройки"),
      ),
      key: _scaffoldKey,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Text(
              "Выберите посты",
              style: theme.textTheme.titleLarge,
            ),
          ),
          Column(
            children: List.generate(_stationsToSave.length, (index) {
              return Card(
                child: CheckboxListTile(
                  title: Text("Пост ${index + 1}"),
                  value: _stationsToSave[index],
                  onChanged: (newValue) {
                    _stationsToSave[index] = !_stationsToSave[index];
                    setState(() {});
                  },
                ),
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Выберите тип поста",
              style: theme.textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                    ),
                  );
                },
              ),
              onChanged: (newValue) {
                _dropDownValue = newValue!;
                setState(() {});
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Text(
                "Установить",
              ),
              onPressed: _canSet
                  ? () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Загрузить настройки?"),
                          content: Text("Настройки для программи кнопок будут установлены по умолчанию"),
                          actionsPadding: EdgeInsets.all(10),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                _setSettings(sessionData);
                                Navigator.pop(context);
                              },
                              child: Text("Да"),
                            ),
                            ElevatedButton(
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
