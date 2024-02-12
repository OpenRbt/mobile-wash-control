import 'package:flutter/material.dart';

import '../../entity/entity.dart';
import '../../entity/vo/page_args_codes.dart';
import '../../repository/repository.dart';
import '../widgets/common/washNavigationDrawer.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {

  List<Task> tasks = [];

  Future<void> _getTasks(Repository repository, int id, BuildContext context) async {
    tasks = await repository.getTasks(id, "queue", context: context) ?? [];
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    var args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final Repository repository = args[PageArgCode.repository];

    return Scaffold(
      appBar: AppBar(
        title: Text("Задачи на обновление"),
      ),
      drawer: WashNavigationDrawer(
        selected: SelectedPage.Tasks,
        repository: repository,
      ),
      body: FutureBuilder(
        future: _getTasks(repository, 1, context),
        builder: (context, snapshot) {
          return Container();
        },
      ),
    );
  }
}
