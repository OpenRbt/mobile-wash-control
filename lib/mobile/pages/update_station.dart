import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../entity/entity.dart';
import '../../entity/vo/page_args_codes.dart';
import '../../repository/repository.dart';

class UpdateStationPage extends StatefulWidget {
  const UpdateStationPage({Key? key}) : super(key: key);

  @override
  State<UpdateStationPage> createState() => _UpdateStationPageState();
}

class _UpdateStationPageState extends State<UpdateStationPage> {

  List<FirmwareVersion> avaliableVersions = [];

  Future<void> _getPostVersions(Repository repository, int id) async {
    avaliableVersions = await repository.getPostVersions(id) ?? [];
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
          TextButton(
              onPressed: () async {},
              child: Text(
                  'Обновить до последней версии',
                style: TextStyle(
                  color: Colors.white
                ),
              )
          )
        ],
      ),
      body: FutureBuilder(
        future: _getPostVersions(repository, id),
        builder: (context, snapshot) {

          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (snapshot.hasError) {
            return Container();
          }

          return ListView.builder(
              shrinkWrap: true,
              itemCount: avaliableVersions.length,
              physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Column(
                      children: [
                        Row(
                          children: [
                            Text("Сборка от: ${DateFormat('d MMMM y', 'ru_RU').format(avaliableVersions[index].builtAt ?? DateTime(2023))}"),
                          ],
                        ),
                      ],
                    ),
                    leading: OutlinedButton.icon(
                      onPressed: (avaliableVersions[index].isCurrent ?? false) ? null :
                          () async {

                          },
                      icon: const Icon(Icons.download_outlined),
                      label: Text((avaliableVersions[index].isCurrent ?? false) ? "Текущая" : "Загрузить")
                    ),
                  ),
                );
              }
          );
        },
      ),
    );
  }
}
