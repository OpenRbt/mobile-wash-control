import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/common/washNavigationDrawer.dart';
import 'package:mobile_wash_control/mobile/widgets/programms/programListTile.dart';
import 'package:mobile_wash_control/repository/lea_central_wash_repo/repository.dart';
import 'package:easy_localization/easy_localization.dart';

class ProgramsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProgramsPageState();
}

class _ProgramsPageState extends State<ProgramsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final repository = args[PageArgCode.repository] as LeaCentralRepository;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(context.tr('programs')),
      ),
      drawer: WashNavigationDrawer(
        selected: SelectedPage.Programs,
        repository: repository,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await repository.updatePrograms(context: context);
        },
        child: FutureBuilder(
          future: repository.updatePrograms(context: context),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
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
                            "${context.tr('name')}",
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Center(
                          child: Text(
                            context.tr('preflight'),
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Center(
                          child: Text(
                            context.tr('finishing'),
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
                  Divider(),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: repository.getProgramsNotifier(),
                      builder: (BuildContext context, List<Program>? programs, Widget? child) {
                        if (programs == null || programs.length == 0) {
                          return child!;
                        }

                        return ListView.builder(
                          itemCount: programs.length,
                          itemBuilder: (context, index) {
                            return ProgramListTile(
                              program: programs[index],
                              onPress: () {
                                var args = Map<PageArgCode, dynamic>();
                                args[PageArgCode.repository] = repository;
                                args[PageArgCode.programID] = programs[index].id;

                                Navigator.pushNamed(context, "/mobile/programs/edit", arguments: args).then(
                                  (value) => repository.updatePrograms(context: context),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Center(
                        child: Container(),
                      ),
                      // builder: (BuildContext context, List<Program> value, Widget? child) {
                      //   return ListView.builder(
                      //     itemCount: SharedData.Programs.value.length,
                      //     itemBuilder: (context, index) {
                      //       return ProgramListTile(program: SharedData.Programs.value[index]);
                      //     },
                      //   );
                      // },
                    ),
                  ),
                  Divider(),
                  TextButton(
                    onPressed: () {
                      var args = Map<PageArgCode, dynamic>();
                      args[PageArgCode.repository] = repository;
                      args[PageArgCode.programID] = null;
                      Navigator.pushNamed(context, "/mobile/programs/edit", arguments: args).then(
                        (value) => repository.updatePrograms(context: context),
                      );
                    },
                    child: Text("${context.tr('add')}"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
