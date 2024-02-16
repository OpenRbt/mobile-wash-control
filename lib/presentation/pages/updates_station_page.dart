import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/blocs/updates_station_cubit.dart';
import '../../entity/vo/page_args_codes.dart';
import '../../mobile/widgets/common/ProgressButton.dart';
import '../widgets/cards/post_version_card.dart';


class UpdatesStationPage extends StatelessWidget {
  const UpdatesStationPage({super.key});

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final int id = args[PageArgCode.stationID];

    return Provider<UpdatesStationPageCubit> (
      create: (_) => UpdatesStationPageCubit(id),
      child: const _UpdatesStationPageView(),
      dispose: (context, value) => value.close(),
    );
  }
}

class _UpdatesStationPageView extends StatelessWidget {
  const _UpdatesStationPageView({super.key});

  @override
  Widget build(BuildContext context) {

    final cubit = context.watch<UpdatesStationPageCubit>();

    return StreamBuilder(
        initialData: cubit.state,
        stream: cubit.stream,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Пост ${snapshot.requireData.updatesStationPageEntity.stationId}"),
              actions: [
                IconButton(
                  icon: Icon(Icons.more_horiz_rounded),
                  onPressed: () {
                    showMoreActionsModalDialog(context);
                  },
                ),
              ],
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _AvailableVersionsView(),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}

class _AvailableVersionsView extends StatelessWidget {
  const _AvailableVersionsView({super.key});

  @override
  Widget build(BuildContext context) {

    final cubit = context.watch<UpdatesStationPageCubit>();

    return StreamBuilder(
        initialData: cubit.state,
        stream: cubit.stream,
        builder: (context, snapshot) {

          final availableVersions = snapshot.requireData.updatesStationPageEntity.availableVersions;

          return Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: availableVersions.length,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return PostVersionCard(
                      id: availableVersions[index].id,
                      builtAt: availableVersions[index].builtAt ?? '',
                      commitedAt: availableVersions[index].commitedAt ?? '',
                      isCurrent: availableVersions[index].isCurrent,
                      hashLua: availableVersions[index].hashLua ?? '',
                      hashEnv: availableVersions[index].hashEnv ?? '',
                      hashBinar: availableVersions[index].hashBinar ?? '',
                      onDownloadPressed: cubit.setVersion,
                      onUploadPressed: cubit.uploadVersion,
                      stationId: snapshot.requireData.updatesStationPageEntity.stationId,
                    );
                  }
              ),
          );
        }
    );
  }
}

showMoreActionsModalDialog(BuildContext widgetContext) {
  showDialog(
    context: widgetContext,
    builder: (BuildContext context) {

      final cubit = widgetContext.watch<UpdatesStationPageCubit>();

      return AlertDialog(
        title: Text("Действия"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      cubit.reboot(cubit.state.updatesStationPageEntity.stationId);
                    },
                    icon: const Icon(Icons.restart_alt_outlined),
                    label: const Text("Перезагрузить пост"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      cubit.hashVersions(cubit.state.updatesStationPageEntity.stationId);
                    },
                    icon: const Icon(Icons.list_alt_outlined),
                    label: const Text("Захэшировать версии с поста"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      cubit.update(cubit.state.updatesStationPageEntity.stationId);
                    },
                    icon: const Icon(Icons.download_for_offline_outlined),
                    label: const Text("Скачать последнюю версию"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      cubit.downLoadVersion(cubit.state.updatesStationPageEntity.stationId);
                    },
                    icon: const Icon(Icons.create_new_folder_outlined),
                    label: const Text("Создать новую версию"),
                  ),
                ),
              ],
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
            },
            child: Text("Ок"),
          ),
        ],
      );
    },
  );
}