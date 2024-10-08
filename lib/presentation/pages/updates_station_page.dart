import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

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
              title: Text("${context.tr('post')} ${snapshot.requireData.updatesStationPageEntity.stationId}"),
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
                    const _CopyVersionView(),
                    const _AvailableVersionsView(),
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
          final currentVersionOnServer = snapshot.requireData.updatesStationPageEntity.currentVersionOnServer;

          print(availableStations.length);

          return Padding(
            padding: EdgeInsets.all(4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text('${context.tr('version_on_server_for_station')} #'),
                    SizedBox(width: 10,),
                    Expanded(
                        child: DropDownByID(
                          canEdit: true,
                          onChanged: (value) async {
                            await cubit.changeCopyFromStationId(value);
                          },
                          values: availableStations,
                          currentValue: availableStations.length > 0 ? availableStations[0] : null,
                        )
                    ),
                  ],
                ),
                currentVersionOnServer != null ?
                Container(
                  color: Colors.white,
                  child: Container(
                    child: BufferedVersionView(
                      builtAt: currentVersionOnServer.builtAt ?? '',
                      commitedAt: currentVersionOnServer.commitedAt ?? '',
                      hashLua: currentVersionOnServer.hashLua ?? '',
                      hashBinar: currentVersionOnServer.hashBinar ?? '',
                      hashEnv: currentVersionOnServer.hashEnv ?? '',
                    ),
                  ),
                ) : Container(),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: availableStations.length > 0 ? () async {
                            try {
                              await cubit.copyVersionFromPostToPost();
                              await cubit.downLoadVersion();
                              ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: context.tr('copying_from_buffer_in_progress')));
                            } on FormatException catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error_has_occurred')} $e"));
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')} $e"));
                            }
                          } : null,
                          child: Text(context.tr('set_version_from_server_and_reboot'))
                      ),
                    )
                  ],
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
        title: Text(context.tr('actions')),
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
                        ScaffoldMessenger.of(widgetContext).showSnackBar(SnackBars.getSuccessSnackBar(message: context.tr('the_reboot_task_has_been_created')));
                      } on FormatException catch (e) {
                        ScaffoldMessenger.of(widgetContext).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error_has_occurred')} $e"));
                      } catch (e) {
                        ScaffoldMessenger.of(widgetContext).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')} $e"));
                      }
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.restart_alt_outlined),
                    label: Text(context.tr('reboot_post')),
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
                        ScaffoldMessenger.of(widgetContext).showSnackBar(SnackBars.getSuccessSnackBar(message: context.tr('the_task_to_hash_the_versions_from_the_post_has_been_created')));
                      } on FormatException catch (e) {
                        ScaffoldMessenger.of(widgetContext).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error_has_occurred')} $e"));
                      } catch (e) {
                        ScaffoldMessenger.of(widgetContext).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')} $e"));
                      }
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.list_alt_outlined),
                    label: Text("${context.tr('to_get')} ${context.tr('information_about_all_post_versions_and_display')}"),
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
                        ScaffoldMessenger.of(widgetContext).showSnackBar(SnackBars.getSuccessSnackBar(message: context.tr('the_task_to_download_the_latest_version_has_been_created')));
                      } on FormatException catch (e) {
                        ScaffoldMessenger.of(widgetContext).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error_has_occurred')} $e"));
                      } catch (e) {
                        ScaffoldMessenger.of(widgetContext).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')} $e"));
                      }
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.download_for_offline_outlined),
                    label: Text(context.tr('download_version_from_github_build_local_and_reboot')),
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
                        ScaffoldMessenger.of(widgetContext).showSnackBar(SnackBars.getSuccessSnackBar(message: context.tr('the_task_to_create_a_new_version_has_been_created')));
                      } on FormatException catch (e) {
                        ScaffoldMessenger.of(widgetContext).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error_has_occurred')} $e"));
                      } catch (e) {
                        ScaffoldMessenger.of(widgetContext).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')} $e"));
                      }
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.create_new_folder_outlined),
                    label: Text(context.tr('copy_to_post_current_version_and_reboot')),
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
            child: Text(context.tr('cancel')),
          ),
        ],
      );
    },
  );
}