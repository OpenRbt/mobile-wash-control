import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/SharedData.dart';
import 'package:mobile_wash_control/mobile/ProgramMenuEdit.dart';
import 'package:mobile_wash_control/client/api.dart';

class ProgramsMenu extends StatefulWidget {
  @override
  _ProgramsMenuState createState() => _ProgramsMenuState();
}

class _ProgramsMenuState extends State<ProgramsMenu> {
  _ProgramsMenuState() : super();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;

    final AppBar appBar = AppBar(
      title: Text("Программы"),
    );

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar,
      drawer: prepareDrawer(context, Pages.Programs, sessionData),
      body: Container(
          child: RefreshIndicator(
        onRefresh: () async {
          await SharedData.RefreshPrograms();
        },
        child: Container(
          child: Column(
            children: [
              Container(
                height: 50,
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Center(
                        child: Text("ID"),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Center(
                        child: Text("Название"),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Center(
                        child: Text("Прокачка"),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Center(
                        child: Text("Чистовая"),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
              ),
              Expanded(
                child: Container(
                  child: ProgramsTableAlt(sessionData),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  Widget ProgramsTableAlt(SessionData sessionData) {
    return ValueListenableBuilder(
      valueListenable: SharedData.Programs,
      builder: (BuildContext context, values, child) {
        if (SharedData.Programs.value == null) {
          SharedData.RefreshPrograms();
          return child;
        }
        return Container(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              if (index == SharedData.Programs.value.length) {
                return Container(
                  height: 50,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black)]),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Center(
                          child: Text("..."),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(
                          width: double.maxFinite,
                          child: Text(
                            "Новая программа",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Center(
                          child: Text("---"),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Center(
                          child: Text("---"),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: LayoutBuilder(
                              builder: (context, constraint) {
                                return Icon(
                                  Icons.add_circle,
                                  size: constraint.biggest.height,
                                  color: Colors.white,
                                );
                              },
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "/mobile/programs/add", arguments: sessionData).then(
                                (value) => SharedData.RefreshPrograms(),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Container(
                height: 50,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black)]),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Center(
                        child: Text("${SharedData.Programs.value[index].id}"),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        width: double.maxFinite,
                        child: Text(
                          "${SharedData.Programs.value[index].name ?? ""}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Center(
                        child: Text("${"${(SharedData.Programs.value[index].preflightEnabled ?? false) ? "Да" : "Нет"}"}"),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Center(
                        child: Text("${"${(SharedData.Programs.value[index].isFinishingProgram ?? false) ? "Да" : "Нет"}"}"),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: LayoutBuilder(
                            builder: (context, constraint) {
                              return Icon(
                                Icons.build_circle,
                                size: constraint.biggest.height,
                                color: Colors.white,
                              );
                            },
                          ),
                          onPressed: () {
                            var args = ProgramMenuEditArgs(SharedData.Programs.value[index].id, SharedData.Programs.value[index].name, sessionData);
                            Navigator.pushNamed(context, "/mobile/programs/edit", arguments: args).then(
                              (value) => SharedData.RefreshPrograms(),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: SharedData.Programs.value.length + 1,
          ),
        );
      },
      child: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
