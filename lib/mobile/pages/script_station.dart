import 'package:flutter/material.dart';

import '../../entity/entity.dart';
import '../../entity/vo/page_args_codes.dart';
import '../../repository/repository.dart';
import '../widgets/dropDowns/drop_down_with_button.dart';
import '../widgets/editFields/edit_field_with_name.dart';

class ScriptStationPage extends StatefulWidget {
  const ScriptStationPage({Key? key}) : super(key: key);

  @override
  State<ScriptStationPage> createState() => _ScriptStationPageState();
}

class _ScriptStationPageState extends State<ScriptStationPage> {

  late TextEditingController scriptNameController;
  late TextEditingController scriptController;
  String copyFromStation = '';

  Future<void> _getCurrentScript(Repository repository, int id) async {
    BuildScript? buildScript = await repository.getCurrentBuildScript(id);
    scriptController.text = '';
    scriptNameController.text = buildScript?.name ?? '';
    buildScript?.commands.forEach((String element) {
      scriptController.text = scriptController.text + element + '\n';
    });
  }

  @override
  void initState() {
    scriptController = TextEditingController();
    scriptNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    scriptController.dispose();
    scriptNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final int id = args[PageArgCode.stationID];
    final repository = args[PageArgCode.repository] as Repository;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Пост $id",
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save_outlined, color: Colors.white),
            iconSize:  30.0,
            splashRadius: 30,
            onPressed: () async {
              repository.setCurrentBuildScript(id, context: context, name: scriptNameController.text, commands: scriptController.text.split('\n'));
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _getCurrentScript(repository, id),
        builder: (context, snapshot) {

          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (snapshot.hasError) {
            return Container();
          }

          return ValueListenableBuilder(
              valueListenable: repository.getStationsNotifier(),
              builder: (context, stations, _) {

                if (stations == null) {
                  return Center(child: CircularProgressIndicator());
                }
                List<String> filteredStations = [];

                stations.where((station) => (station.hash?.isNotEmpty ?? false)).forEach((element) {
                  if(element.id != id) {
                    filteredStations.add(element.id.toString() ?? '');
                  }
                });

                copyFromStation = filteredStations[0];

                return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          EditField(
                            name: "Название скрипта: ",
                            controller: scriptNameController,
                            onChanged: (val) {},
                            validator: (val) {
                              return null;
                            },
                            canEdit: true,
                            style: null,
                          ),
                          SizedBox(height: 20,),
                          DropDownWithButton(
                            onChanged: (String val) {
                              copyFromStation = val;
                            },
                            onPressed: () async {
                              await repository.setCurrentBuildScript(id, context: context, name: scriptNameController.text, commands: [], copyFrom: int.parse(copyFromStation));
                              await _getCurrentScript(repository, id);
                              },
                            currentValue: filteredStations[0],
                            values: filteredStations,
                            buttonText: 'Скопировать скрипт со станции',
                          ),
                          SizedBox(height: 20,),
                          Align(
                            alignment: Alignment.topLeft,
                            child: TextFormField(
                              controller: scriptController,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                );
              }
          );
        },
      ),
    );
  }
}
