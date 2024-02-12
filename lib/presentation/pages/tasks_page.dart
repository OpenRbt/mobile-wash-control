import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../styles/text_styles.dart';
import '../../domain/blocs/tasks_cubit.dart';
import '../../entity/vo/page_args_codes.dart';
import '../../mobile/widgets/common/washNavigationDrawer.dart';
import '../../repository/repository.dart';
import '../../utils/utils.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<TasksPageCubit> (
      create: (_) => TasksPageCubit(),
      child: const _TasksPageView(),
      dispose: (context, value) => value.close(),
    );
  }
}

class _TasksPageView extends StatelessWidget {
  const _TasksPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final Repository repository = args[PageArgCode.repository];

    return Scaffold(
      appBar: AppBar(title: Text("Задачи на обновление")),
      drawer: WashNavigationDrawer(selected: SelectedPage.Tasks, repository: repository),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const _TasksView(),
              const _PaginateTaskView(),
            ],
          ),
        ),
      ),
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
                  return _TaskCardView(
                    id: tasks[index].id,
                    stationID: tasks[index].stationID,
                    versionID: tasks[index].versionID,
                    taskType: tasks[index].taskType.name,
                    taskStatus: tasks[index].taskStatus.name,
                    error: tasks[index].error ?? '',
                    createdAt: formatDate(tasks[index].createdAt),
                    startedAt: (tasks[index].startedAt != null && (tasks[index].startedAt ?? '').isNotEmpty) ? formatDate(tasks[index].startedAt!) : '',
                    stoppedAt: (tasks[index].stoppedAt != null && (tasks[index].stoppedAt ?? '').isNotEmpty)? formatDate(tasks[index].stoppedAt!) : '',
                  );
                },
              )
          );
        }
    );
  }
}

class _PaginateTaskView extends StatelessWidget {
  const _PaginateTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<TasksPageCubit>();

    return StreamBuilder(
        initialData: cubit.state,
        stream: cubit.stream,
        builder: (context, snapshot) {

          return Container(

          );
        }
    );
  }
}


class _TaskCardView extends StatelessWidget {
  final int id;
  final int stationID;
  final int? versionID;
  final String taskType;
  final String taskStatus;
  final String error;
  final String createdAt;
  final String startedAt;
  final String stoppedAt;

  const _TaskCardView({
    required this.id,
    required this.stationID,
    required this.versionID,
    required this.taskType,
    required this.taskStatus,
    required this.error,
    required this.createdAt,
    required this.startedAt,
    required this.stoppedAt,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'queue':
        return Colors.blue.shade400;
      case 'started':
        return Colors.orange.shade400;
      case 'completed':
        return Colors.green.shade400;
      case 'error':
        return Colors.red.shade600;
      case 'canceled':
        return Colors.grey.shade600;
      default:
        return Colors.black;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'completed':
        return Icons.check_circle;
      case 'error':
        return Icons.error;
      case 'canceled':
        return Icons.cancel;
      default:
        return Icons.hourglass_empty;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color statusColor = _getStatusColor(taskStatus);
    IconData statusIcon = _getStatusIcon(taskStatus);
    return Card(
      elevation: 5,
      color: statusColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _cardHeader(statusIcon, statusColor),
            Divider(color: Colors.white70),
            _cardInfoSection(),
            Divider(color: Colors.white70),
            _cardDatesSection(),
            if (error.isNotEmpty) ...[
              Divider(color: Colors.white70),
              _cardErrorSection(),
            ]
          ],
        ),
      ),
    );
  }

  Widget _cardHeader(IconData statusIcon, Color statusColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Задача #$id', style: TextStyles.cardHeader(),),
        Icon(statusIcon, color: Colors.white),
      ],
    );
  }

  Widget _cardInfoSection() {
    return Row(
      children: <Widget>[
        Expanded(child: _cardKeyValueRow('Тип:', taskType)),
        Expanded(child: _cardKeyValueRow('Статус:', taskStatus)),
      ],
    );
  }

  Widget _cardDatesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Время', style: TextStyles.cardSubHeader()),
        _cardKeyValueRow('Создана:', createdAt),
        _cardKeyValueRow('Начата:', startedAt),
        _cardKeyValueRow('Прекращена:', stoppedAt),
      ],
    );
  }

  Widget _cardErrorSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Ошибка', style: TextStyles.cardSubHeader()),
        Text(error, style: TextStyles.cardText()),
      ],
    );
  }

  Widget _cardKeyValueRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      child: Row(
        children: <Widget>[
          Text(key, style: TextStyles.cardTextBold()),
          SizedBox(width: 8),
          Expanded(child: Text(value, style: TextStyles.cardText())),
        ],
      ),
    );
  }
}
