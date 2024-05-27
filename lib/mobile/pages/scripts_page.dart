import 'package:flutter/material.dart';

import '../../entity/entity.dart';
import '../../entity/vo/page_args_codes.dart';
import '../../repository/repository.dart';
import '../widgets/common/washNavigationDrawer.dart';

class ScriptsPage extends StatefulWidget {
  const ScriptsPage({Key? key}) : super(key: key);

  @override
  State<ScriptsPage> createState() => _ScriptsPageState();
}

class _ScriptsPageState extends State<ScriptsPage> {
  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    var args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final Repository repository = args[PageArgCode.repository];

    return Scaffold(
      appBar: AppBar(
        title: Text("Скрипты"),

      ),
      drawer: WashNavigationDrawer(
        selected: SelectedPage.Scripts,
        repository: repository,
      ),
      body: ValueListenableBuilder(
        valueListenable: repository.getStationsNotifier(),
        builder: (context, stations, _) {

          if (stations == null) {
            return Center(child: CircularProgressIndicator());
          }

          List<Station> filteredStations = stations;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: filteredStations.length,
            physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Row(
                      children: [
                        Text("Пост: ${filteredStations[index].id.toString()}"),
                      ],
                    ),
                    trailing: OutlinedButton.icon(
                      onPressed: () {
                        var args = Map<PageArgCode, dynamic>();
                        args[PageArgCode.stationID] = filteredStations[index].id;
                        args[PageArgCode.repository] = repository;

                        Navigator.pushNamed(context, "/mobile/scripts/post", arguments: args);
                      },
                      icon: const Icon(Icons.edit_outlined),
                      label: const Text("Редактировать"),
                    ),
                  ),
                );
              }
          );
        },
      )
    );
  }
}
