import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/blocs/updates_station_cubit.dart';
import '../../entity/vo/page_args_codes.dart';
import '../../mobile/widgets/common/snackBars.dart';
import '../widgets/cards/post_version_card.dart';
import '../widgets/drop_downs/drop_down_by_id.dart';


class UpdatesStationPage extends StatelessWidget {
  const UpdatesStationPage({super.key});

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final int id = args[PageArgCode.stationID];



    return Provider<UpdatesStationPageCubit> (
      create: (_) {
        return UpdatesStationPageCubit(id, context: context);
      },
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
                    const _AvailableVersionsView(),
                    const _CopyVersionView(),
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
                    );
                  }
              ),
          );
        }
    );
  }
}

class _CopyVersionView extends StatelessWidget {
  const _CopyVersionView({super.key});

  @override
  Widget build(BuildContext context) {

    final cubit = context.watch<UpdatesStationPageCubit>();

    return StreamBuilder(
        initialData: cubit.state,
        stream: cubit.stream,
        builder: (context, snapshot) {

          final availableStations = snapshot.requireData.updatesStationPageEntity.availableStations;

          print(availableStations.length);

          return Padding(
            padding: EdgeInsets.all(4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: ElevatedButton(
                      onPressed: availableStations.length > 0 ? () async {
                        try {
                          await cubit.copyVersionFromPostToPost();
                          await cubit.downLoadVersion();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: "Идёт копирование из кэша"));
                        } on FormatException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла ошибка $e"));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка $e"));
                        }
                      } : null,
                      child: Text('Загрузить версию из кэша станции #')
                  ),
                  flex: 4,
                ),
                SizedBox(width: 10,),
                Flexible(
                    flex: 1,
                    child: DropDownByID(
                      canEdit: true,
                      onChanged: (value) async {
                        await cubit.changeCopyFromStationId(value);
                      },
                      values: availableStations,
                      currentValue: availableStations.length > 0 ? availableStations[0] : null,
                    )
                )
              ],
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
                      try {
                        await cubit.reboot();
                        ScaffoldMessenger.of(widgetContext).showSnackBar(SnackBars.getSuccessSnackBar(message: "Задача на перезагрузку создана"));
                      } on FormatException catch (e) {
                        ScaffoldMessenger.of(widgetContext).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла ошибка $e"));
                      } catch (e) {
                        ScaffoldMessenger.of(widgetContext).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка $e"));
                      }
                      Navigator.of(context).pop();
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
                      try {
                        await cubit.hashVersions();
                        ScaffoldMessenger.of(widgetContext).showSnackBar(SnackBars.getSuccessSnackBar(message: "Задача на хэширование версий с поста создана"));
                      } on FormatException catch (e) {
                        ScaffoldMessenger.of(widgetContext).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла ошибка $e"));
                      } catch (e) {
                        ScaffoldMessenger.of(widgetContext).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка $e"));
                      }
                      Navigator.of(context).pop();
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
                      try {
                        await cubit.update();
                        ScaffoldMessenger.of(widgetContext).showSnackBar(SnackBars.getSuccessSnackBar(message: "Задача на загрузку последней версии создана"));
                      } on FormatException catch (e) {
                        ScaffoldMessenger.of(widgetContext).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла ошибка $e"));
                      } catch (e) {
                        ScaffoldMessenger.of(widgetContext).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка $e"));
                      }
                      Navigator.of(context).pop();
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
                      try {
                        await cubit.downLoadVersion();
                        ScaffoldMessenger.of(widgetContext).showSnackBar(SnackBars.getSuccessSnackBar(message: "Задача на создание новой версии создана"));
                      } on FormatException catch (e) {
                        ScaffoldMessenger.of(widgetContext).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла ошибка $e"));
                      } catch (e) {
                        ScaffoldMessenger.of(widgetContext).showSnackBar(SnackBars.getErrorSnackBar(message: "Произошла неизвестная ошибка $e"));
                      }
                      Navigator.of(context).pop();
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
            child: Text("Отмена"),
          ),
        ],
      );
    },
  );
}