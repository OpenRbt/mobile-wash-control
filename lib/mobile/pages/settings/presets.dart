import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/utils/ConfigPresets.dart';
import 'package:mobile_wash_control/mobile/widgets/common/ProgressButton.dart';
import 'package:mobile_wash_control/repository/repository.dart';

class PresetsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PresetsPageState();
}

//TODO: Use repository !!!
class _PresetsPageState extends State<PresetsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final List<StationPreset> presets = ConfigPresets.getStationPresets();
  ValueNotifier<String> _selectedPreset = ValueNotifier("");

  late List<DropdownMenuItem> _presetsDropdownItems;

  @override
  initState() {
    _presetsDropdownItems = [
      DropdownMenuItem(
        child: Text("-"),
        value: "",
      )
    ];

    _presetsDropdownItems.addAll(
      List.generate(
        presets.length,
        (index) => DropdownMenuItem(
          child: Text(presets[index].name),
          value: presets[index].name,
        ),
      ),
    );

    super.initState();
  }

  Future<void> _applyPreset(Repository repository, BuildContext context) async {
    final selectedPreset = _selectedPreset.value;
    if (selectedPreset.isNotEmpty) {
      final preset = presets.where((element) => element.name == selectedPreset).single;

      for (int i = 0; i < preset.programs.length; i++) {
        await repository.saveProgram(preset.programs[i], context: context);
      }

      for (int i = 0; i < _stationsToSave.length; i++) {
        if (_stationsToSave[i]) {
          await repository.saveStationButtons(i + 1, preset.stationButtons, context: context);
        }
      }

      _stationsToSave = List.filled(12, false);
    }

    await repository.updatePrograms();
  }

  List<bool> _stationsToSave = List.filled(12, false);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<PageArgCode, dynamic>;
    final repository = args[PageArgCode.repository] as Repository;

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Предустановки постов"),
      ),
      key: _scaffoldKey,
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          Text(
            "Выберите тип поста",
            style: theme.textTheme.titleLarge,
          ),
          ValueListenableBuilder(
            valueListenable: _selectedPreset,
            builder: (BuildContext context, String value, Widget? child) {
              return DropdownButton(
                isExpanded: true,
                items: _presetsDropdownItems,
                value: value,
                onChanged: (val) {
                  _selectedPreset.value = val;
                },
              );
            },
          ),
          Text(
            "Выберите посты",
            style: theme.textTheme.titleLarge,
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
            child: ElevatedButton(
              child: Text(
                "Установить",
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Загрузить настройки?"),
                    content: Text("Настройки для программи кнопок будут установлены по умолчанию"),
                    actionsPadding: EdgeInsets.all(10),
                    actions: [
                      ProgressButton(
                        onPressed: () async {
                          await _applyPreset(repository, context);
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
