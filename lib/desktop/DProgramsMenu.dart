import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/mobile/ProgramMenuEdit.dart';
import 'package:mobile_wash_control/client/api.dart';

class DProgramsMenu extends StatefulWidget {
  @override
  _DProgramsMenuState createState() => _DProgramsMenuState();
}

class _DProgramsMenuState extends State<DProgramsMenu> {
  _DProgramsMenuState() : super();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);

  List<Program> _programs;
  bool _firstLoad = true;

  Future<void> GetData(SessionData sessionData) async {
    try {
      var args14 = ProgramsArgs();
      _programs = await sessionData.client.programs(args14);
      if (!mounted) {
        return;
      }
      _firstLoad = false;
      setState(() {});
    } catch (e) {
      print("Exception when calling GetData in DProgramsMenu: $e\n");
      showInfoSnackBar(_scaffoldKey, _isSnackBarActive,
          "Произошла ошибка при запросе к api", Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;
    if (_firstLoad) {
      GetData(sessionData);
    }

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;

    double DrawerSize = 256;

    var width = screenW - DrawerSize;
    var height = screenH;
    
    return Scaffold(
      key: _scaffoldKey,
      drawer: prepareDrawer(context, Pages.Programs, sessionData),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Row(
            children: [
              DGetDrawer(
                  screenH, DrawerSize, context, Pages.Programs, sessionData),
              SizedBox(
                height: height,
                width: width,
                child: ListView(children: [
                  Column(children: [
                    SizedBox(
                      height: 50,
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                            width: width / 8,
                            child: Center(
                              child: Text(
                                screenW > screenH ? "ID" : "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: width / 8 * 2,
                            child: Center(
                              child: Text(
                                "Название",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: width / 8 * 2,
                            child: Center(
                              child: Text(
                                "Цена",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: width / 8 * 2,
                            child: Center(
                              child: Text(
                                "Прокачка",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: programsTable(sessionData, width, height),
                    ),
                  ])
                ]),
              )
            ],
          );
        },
      ),
    );
  }

  List<Widget> programsTable(
      SessionData sessionData, double width, double height) {
    return List.generate((_programs != null ? _programs.length : 0) + 1,
        (index) {
      if (index < (_programs?.length ?? 0)) {
        return Row(
          children: [
            SizedBox(
              height: 50,
              width: width / 8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: index % 2 == 0 ? Colors.white : Colors.black12,
                  border: Border.all(color: Colors.black38),
                ),
                child: Text(
                  width > height ? "${_programs[index].id}" : "",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: width / 8 * 2,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: index % 2 == 0 ? Colors.white : Colors.black12,
                  border: Border.all(color: Colors.black38),
                ),
                child: Text(
                  _programs[index].name ?? "no name",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: width / 8 * 2,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: index % 2 == 0 ? Colors.white : Colors.black12,
                  border: Border.all(color: Colors.black38),
                ),
                child: Text(
                  "${_programs[index].price ?? 0}",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: width / 8 * 2,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: (_programs[index].preflightEnabled != null)
                      ? (_programs[index].preflightEnabled
                          ? Colors.lightGreen
                          : Colors.red)
                      : Colors.red,
                  border: Border.all(color: Colors.black38),
                ),
                child: Center(
                  //TODO: get active status (Kronusol)
                  child: Text(
                    (_programs[index].preflightEnabled != null)
                        ? (_programs[index].preflightEnabled
                            ? "Включена"
                            : "Отключена")
                        : "Отключена",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: width / 8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: index % 2 == 0 ? Colors.white : Colors.black12,
                  border: Border.all(color: Colors.black38),
                ),
                child: IconButton(
                  icon: Icon(Icons.more_horiz),
                  onPressed: () {
                    var args = ProgramMenuEditArgs(_programs[index].id,
                        _programs[index].name, sessionData);
                    Navigator.pushNamed(context, "/mobile/programs/edit",
                            arguments: args)
                        .then(
                      (value) => GetData(sessionData),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      } else {
        return Row(
          children: [
            SizedBox(
              height: 50,
              width: width / 8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: index % 2 == 0 ? Colors.white : Colors.black12,
                  border: Border.all(color: Colors.black38),
                ),
                child: Text(
                  "",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: width / 8 * 2,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: index % 2 == 0 ? Colors.white : Colors.black12,
                  border: Border.all(color: Colors.black38),
                ),
                child: Text(
                  "",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: width / 8 * 2,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: index % 2 == 0 ? Colors.white : Colors.black12,
                  border: Border.all(color: Colors.black38),
                ),
                child: Text(
                  "",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: width / 8 * 2,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: index % 2 == 0 ? Colors.white : Colors.black12,
                  border: Border.all(color: Colors.black38),
                ),
                child: FlatButton(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: width / 8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: index % 2 == 0 ? Colors.white : Colors.black12,
                  border: Border.all(color: Colors.black38),
                ),
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.pushNamed(context, "/mobile/programs/add",
                            arguments: sessionData)
                        .then(
                      (value) => GetData(sessionData),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }
    });
  }
}
