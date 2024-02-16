import 'package:flutter/material.dart';

import 'package:mobile_wash_control/utils/utils.dart';

import '../../../styles/text_styles.dart';

class PostVersionCard extends StatelessWidget {

  final int id;
  final int stationId;
  final String builtAt;
  final String commitedAt;
  final String hashLua;
  final String hashEnv;
  final String hashBinar;
  final bool isCurrent;
  final Future<void> Function(int id, int postId) onDownloadPressed;
  final Future<void> Function(int id, int postId) onUploadPressed;

  const PostVersionCard({
    super.key,
    required this.builtAt,
    required this.isCurrent,
    required this.id,
    required this.stationId,
    required this.commitedAt,
    required this.onDownloadPressed,
    required this.onUploadPressed,
    required this.hashLua,
    required this.hashEnv,
    required this.hashBinar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
      child: Column(
        children: [
          ListTile(
            title: Text(isCurrent ? 'ID: $id (текущая)' : 'ID: $id'),
            subtitle: Text(id == 0 ? 'Начальная версия' :
            '\nБилд от: ${formatDateWithoutTime(builtAt)} \n\n'
                'Обновление от: ${formatDateWithoutTime(commitedAt)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.download_outlined),
                  onPressed: isCurrent ? null :
                      () async {
                    await onDownloadPressed(id, stationId);
                  },
                  tooltip: 'Загрузить версию на пост',
                  color: Colors.red,
                ),
                IconButton(
                  icon: Icon(Icons.upload_outlined),
                  onPressed: () async {
                    await onUploadPressed(id, stationId);
                  },
                  tooltip: 'Выгрузить версию на сервер',
                  color: Colors.red,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(hashLua.isNotEmpty ? 'Hash lua: ${hashLua.substring(0, 4)}...${hashLua.substring(hashLua.length-4, hashLua.length-1)}' : '', style: TextStyles.cardTextBlack(),),
                    Text(hashEnv.isNotEmpty ? 'Hash env: ${hashEnv.substring(0, 4)}...${hashEnv.substring(hashEnv.length-4, hashEnv.length-1)}' : '', style: TextStyles.cardTextBlack(),),
                    Text(hashBinar.isNotEmpty ? 'Hash binar: ${hashBinar.substring(0, 4)}...${hashBinar.substring(hashBinar.length-4, hashBinar.length-1)}' : '', style: TextStyles.cardTextBlack(),),
                  ],
                ),
              )
            ],
          )
        ],
      )
    );
  }
}

//