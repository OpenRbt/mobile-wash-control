import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/SharedData.dart';
import 'package:mobile_wash_control/client/api.dart';
import 'package:mobile_wash_control/mobile/widgets/common/washNavigationDrawer.dart';
import 'package:mobile_wash_control/mobile/widgets/programms/programListTile.dart';

class ProgramsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProgramsPageState();
}

class _ProgramsPageState extends State<ProgramsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late SessionData sessionData;
  @override
  void initState() {
    sessionData = SharedData.sessionData!;
    SharedData.RefreshPrograms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Программы"),
      ),
      drawer: WashNavigationDrawer(selected: SelectedPage.Programs),
      body: RefreshIndicator(
        onRefresh: () async {
          await SharedData.RefreshPrograms();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Center(
                      child: Text(
                        "ID",
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Center(
                      child: Text(
                        "Название",
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Center(
                      child: Text(
                        "Прокачка",
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Center(
                      child: Text(
                        "Чистовая",
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
            ),
            Divider(),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: SharedData.Programs,
                builder: (BuildContext context, List<Program> value, Widget? child) {
                  return ListView.builder(
                    itemCount: SharedData.Programs.value.length,
                    itemBuilder: (context, index) {
                      return ProgramListTile(program: SharedData.Programs.value[index]);
                    },
                  );
                },
              ),
            ),
            Divider(),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/mobile/programs/add", arguments: sessionData).then(
                  (value) => SharedData.RefreshPrograms(),
                );
              },
              child: Text("Добавить программу"),
            ),
          ],
        ),
      ),
    );
  }
}
