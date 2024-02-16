import 'package:flutter/material.dart';

import '../../entity/entity.dart';
import '../../entity/vo/page_args_codes.dart';
import '../../repository/repository.dart';
import '../widgets/common/washNavigationDrawer.dart';

class UpdatesPage extends StatefulWidget {
  const UpdatesPage({Key? key}) : super(key: key);

  @override
  State<UpdatesPage> createState() => _UpdatesPageState();
}

class _UpdatesPageState extends State<UpdatesPage> {

  Future<void> _getMobileVersions() async {

  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    var args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final Repository repository = args[PageArgCode.repository];

    return Scaffold(
      appBar: AppBar(
        title: Text("Обновления"),

      ),
      drawer: WashNavigationDrawer(
        selected: SelectedPage.Updates,
        repository: repository,
      ),
      body: ListView(

        physics: BouncingScrollPhysics(),
        children: [
          Card(
            child: ExpansionTile(
              title: Text(
                "Обновление постов",
                style: theme.textTheme.titleLarge,
              ),
              childrenPadding: EdgeInsets.all(8),
              children: [
                ValueListenableBuilder(
                    valueListenable: repository.getStationsNotifier(),
                    builder: (BuildContext context, List<Station>? stations, Widget? child) {
                      if (stations == null) {
                        return Center(child: CircularProgressIndicator());
                      }
                      List<Station> filteredStations = stations.where((station) => (station.hash?.isNotEmpty ?? false)).toList();
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: filteredStations.length,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Row(
                                children: [
                                  Text("Пост: ${filteredStations[index].id.toString()}, "),
                                  SizedBox(width: 5,),
                                  Text("Версия: ${filteredStations[index].firmwareVersion}")
                                ],
                              ),
                              trailing: OutlinedButton.icon(
                                onPressed: () {
                                  var args = Map<PageArgCode, dynamic>();
                                  args[PageArgCode.stationID] = filteredStations[index].id;
                                  args[PageArgCode.repository] = repository;

                                  Navigator.pushNamed(context, "/mobile/updates/post", arguments: args);
                                },
                                icon: const Icon(Icons.settings_outlined),
                                label: const Text("Управление"),
                              ),
                            );
                          }
                      );
                    }
                )
              ],
            ),
          ),
          FutureBuilder(
              future: _getMobileVersions(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Card(
                  child: ExpansionTile(
                    title: Text(
                      "Обновление приложения",
                      style: theme.textTheme.titleLarge,
                    ),
                    childrenPadding: EdgeInsets.all(8),
                    children: [
                      ListTile(
                        title: Column(
                          children: [
                            Text("Текущая версия: 2.1.5"),
                            SizedBox(height: 10,),
                            Text("Последняя версия: 2.2.2")
                          ],
                        ),
                        trailing: OutlinedButton.icon(
                          onPressed: () {

                          },
                          icon: const Icon(Icons.download_outlined),
                          label: const Text("Обновить"),
                        ),
                      )
                    ],
                  ),
                );
              }
          )
        ],
      )
    );
  }
}
