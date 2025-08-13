import 'package:flutter/material.dart';
import 'package:mobile_wash_control/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../domain/blocs/updates_cubit.dart';
import '../../entity/vo/page_args_codes.dart';
import '../../repository/repository.dart';
import '../../mobile/widgets/common/washNavigationDrawer.dart';

class UpdatesPage extends StatelessWidget {
  const UpdatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final initialArgs = ModalRoute.of(context)?.settings.arguments;

    if (!isArgsValid(initialArgs, context)) {
      return const SizedBox.shrink();
    }

    final args = initialArgs as Map<PageArgCode, dynamic>;

    final repository = args[PageArgCode.repository] as Repository;

    return Provider<UpdatesPageCubit>(
      create: (_) => UpdatesPageCubit(repository),
      dispose: (context, value) => value.close(),
      child: _UpdatesPageView(repository: repository),
    );
  }
}

class _UpdatesPageView extends StatelessWidget {
  final Repository repository;

  const _UpdatesPageView({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.tr('updates'))),
      drawer: WashNavigationDrawer(
        selected: SelectedPage.Updates,
        repository: repository,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [_PostsUpdatesView(repository: repository)],
      ),
    );
  }
}

class _PostsUpdatesView extends StatelessWidget {
  final Repository repository;

  const _PostsUpdatesView({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.watch<UpdatesPageCubit>();

    return StreamBuilder(
      initialData: cubit.state,
      stream: cubit.stream,
      builder: (context, snapshot) {
        final filteredStations =
            snapshot.requireData.updatesPageEntity.stations;
        return Card(
          child: ExpansionTile(
            title: Text(
              context.tr('posts_updates'),
              style: theme.textTheme.titleLarge,
            ),
            childrenPadding: EdgeInsets.all(8),
            onExpansionChanged: (bool? isExpanded) {
              if (isExpanded ?? false) {
                cubit.getStations();
              }
            },
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: filteredStations.length,
                physics: ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Row(
                      children: [
                        Text(
                          "${context.tr('post')}: ${filteredStations[index].id.toString()}, ",
                        ),
                        SizedBox(width: 5),
                        Text(
                          "${context.tr('version')}: ${filteredStations[index].firmwareVersion}",
                        ),
                      ],
                    ),
                    trailing: OutlinedButton.icon(
                      onPressed: () {
                        var args = Map<PageArgCode, dynamic>();
                        args[PageArgCode.stationID] =
                            filteredStations[index].id;
                        args[PageArgCode.repository] = repository;

                        Navigator.pushNamed(
                          context,
                          "/mobile/updates/post",
                          arguments: args,
                        );
                      },
                      icon: const Icon(Icons.settings_outlined),
                      label: Text(context.tr('management')),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
