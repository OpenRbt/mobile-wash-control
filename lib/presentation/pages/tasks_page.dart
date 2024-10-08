import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../domain/blocs/tasks_cubit.dart';
import '../../entity/vo/page_args_codes.dart';
import '../../mobile/widgets/common/snackBars.dart';
import '../../mobile/widgets/common/washNavigationDrawer.dart';
import '../../repository/repository.dart';
import '../../utils/utils.dart';
import '../../utils/widgets_utils.dart';
import '../widgets/cards/task_card.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<TasksPageCubit> (
      create: (_) => TasksPageCubit(context: context),
      child: const _TasksPageView(),
      dispose: (context, value) => value.close(),
    );
  }
}

class _TasksPageView extends StatelessWidget {
  const _TasksPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final cubit = context.watch<TasksPageCubit>();

    final args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final Repository repository = args[PageArgCode.repository];

    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return StreamBuilder(
        initialData: cubit.state,
        stream: cubit.stream,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(title: Text(context.tr('updates_tasks')), actions: [
              IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: () {
                  showFilterModalDialog(context);
                },
              ),
              IconButton(
                icon: Icon( snapshot.requireData.tasksPageEntity.sorted ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up),
                onPressed: () async {
                  try {
                    await cubit.changeSort();
                  } on FormatException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error_has_occurred')} $e"));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')} $e"));
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.refresh_outlined),
                onPressed: () async {
                  try {
                    await cubit.getTasks();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: context.tr('data_has_been_updated')));
                  } on FormatException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error_has_occurred')} $e"));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')} $e"));
                  }
                },
              ),
            ],
            ),
            drawer: WashNavigationDrawer(selected: SelectedPage.Tasks, repository: repository),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const _TasksView(),
                    isPortrait ? const _PortraitOrientationPaginateTaskView() : const _LandscapeOrientationPaginateTaskView()
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}

class _TasksView extends StatelessWidget {
  const _TasksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final cubit = context.watch<TasksPageCubit>();

    return StreamBuilder(
        initialData: cubit.state,
        stream: cubit.stream,
        builder: (context, snapshot) {

          int length = snapshot.requireData.tasksPageEntity.tasksPagination.tasks.length;
          var tasks = snapshot.requireData.tasksPageEntity.tasksPagination.tasks;

          return Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: length,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return TaskCardView(
                    id: tasks[index].id,
                    stationID: tasks[index].stationID,
                    versionID: tasks[index].versionID,
                    taskType: tasks[index].taskType.name,
                    taskStatus: tasks[index].taskStatus.name,
                    error: tasks[index].error ?? '',
                    createdAt: formatDateWithTime(tasks[index].createdAt),
                    startedAt: (tasks[index].startedAt != null && (tasks[index].startedAt ?? '').isNotEmpty) ? formatDateWithTime(tasks[index].startedAt!) : '',
                    stoppedAt: (tasks[index].stoppedAt != null && (tasks[index].stoppedAt ?? '').isNotEmpty) ? formatDateWithTime(tasks[index].stoppedAt!) : '',
                    triesCount: tasks[index].triesCount ?? 0,
                  );
                },
              )
          );
        }
    );
  }
}

class _LandscapeOrientationPaginateTaskView extends StatelessWidget {

  const _LandscapeOrientationPaginateTaskView({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final cubit = context.watch<TasksPageCubit>();

    return StreamBuilder(
      initialData: cubit.state,
      stream: cubit.stream,
      builder: (context, snapshot) {

        final currentPage = snapshot.data!.tasksPageEntity.tasksPagination.page;
        final totalPages = snapshot.data!.tasksPageEntity.tasksPagination.totalPages;

        List<int> pageNumbers = _calculatePageNumbers(currentPage, totalPages);

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.first_page),
              onPressed: currentPage > 1 ? () => cubit.goToPage(1) : null,
            ),
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: currentPage > 1 ? () => cubit.goToPage(currentPage - 1) : null,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: pageNumbers.map((i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: OutlinedButton(
                  onPressed: () => cubit.goToPage(i),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: currentPage == i ? Colors.white : null,
                    backgroundColor: currentPage == i ? Colors.red : null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: Text('$i'),
                ),
              )).toList(),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: currentPage < totalPages ? () => cubit.goToPage(currentPage + 1) : null,
            ),
            IconButton(
              icon: const Icon(Icons.last_page),
              onPressed: currentPage < totalPages ? () => cubit.goToPage(totalPages) : null,
            ),
          ],
        );
      },
    );
  }
}


class _PortraitOrientationPaginateTaskView extends StatelessWidget {
  const _PortraitOrientationPaginateTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<TasksPageCubit>();

    return StreamBuilder<TasksPageState>(
      initialData: cubit.state,
      stream: cubit.stream,
      builder: (context, snapshot) {

        final currentPage = snapshot.data!.tasksPageEntity.tasksPagination.page;
        final totalPages = snapshot.data!.tasksPageEntity.tasksPagination.totalPages;

        List<int> pageNumbers = _calculatePageNumbers(currentPage, totalPages);

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.first_page),
              onPressed: currentPage > 1 ? () => cubit.goToPage(1) : null,
            ),
            IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: currentPage > 1 ? () => cubit.goToPage(currentPage - 1) : null,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: pageNumbers.map((i) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: OutlinedButton(
                      child: Text('$i'),
                      onPressed: () => cubit.goToPage(i),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: currentPage == i ? Colors.white : null,
                        backgroundColor: currentPage == i ? Colors.red : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  )).toList(),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.chevron_right),
              onPressed: currentPage < totalPages ? () => cubit.goToPage(currentPage + 1) : null,
            ),
            IconButton(
              icon: Icon(Icons.last_page),
              onPressed: currentPage < totalPages ? () => cubit.goToPage(totalPages) : null,
            ),
          ],
        );
      },
    );
  }
}

showFilterModalDialog(BuildContext widgetContext) {
  showDialog(
    context: widgetContext,
    builder: (BuildContext context) {
      
      final cubit = widgetContext.watch<TasksPageCubit>();
      
      return AlertDialog(
        title: Text(context.tr('filters')),
        content: StreamBuilder<TasksPageState>(
          stream: cubit.stream,
          initialData: cubit.state,
          builder: (context, snapshot) {

            final state = snapshot.requireData;
            final selectedTypes = state.tasksPageEntity.typeFilter;
            final selectedStatuses = state.tasksPageEntity.statusFilter;

            return ConstrainedBox(
              constraints: const BoxConstraints.expand(width: 320),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(context.tr('tasks_types'), style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    ...selectedTypes.keys.map((key) {
                      return CheckboxListTile(
                        title: Text(getTypeName(key.name)),
                        value: selectedTypes[key],
                        onChanged: (bool? value) {
                          cubit.changeTypeFilter(key, value!);
                        },
                      );
                    }).toList(),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(context.tr('statuses'), style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    ...selectedStatuses.keys.map((key) {
                      return CheckboxListTile(
                        title: Text(getStatusName(key.name)),
                        value: selectedStatuses[key],
                        onChanged: (bool? value) {
                          cubit.changeStatusFilter(key, value!);
                        },
                      );
                    }).toList(),
                  ],
                ),
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () async {
              try {
                await cubit.getTasks();
              } on FormatException catch (e) {
                ScaffoldMessenger.of(widgetContext).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error_has_occurred')} $e"));
              } catch (e) {
                ScaffoldMessenger.of(widgetContext).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')} $e"));
              }
              Navigator.of(context).pop();
            },
            child: Text(context.tr('ok')),
          ),
        ],
      );
    },
  );
}

List<int> _calculatePageNumbers(int currentPage, int totalPages) {
  int startPage = currentPage > 2 ? currentPage - 2 : 1;
  int endPage = currentPage + 2 <= totalPages ? currentPage + 2 : totalPages;
  int length = endPage - startPage + 1;
  return List.generate(length, (index) => startPage + index);
}