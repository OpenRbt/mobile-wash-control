import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';

class ProgramsMenuArgs {}

class ProgramsMenu extends StatefulWidget {
  @override
  _ProgramsMenuState createState() => _ProgramsMenuState();
}

class _ProgramsMenuState extends State<ProgramsMenu> {
  _ProgramsMenuState() : super();

  List<bool> _ProgramsCheckbox = List.generate(6, (index) {
    return false;
  });
  List<String> _ProgramsName; /* = [
    "Пена",
    "Вода + Шампунь",
    "Ополаскивание",
    "Воск",
    "Сушка и блеск",
    "Пауза"
  ]*/

  List<String> _prices;

  var _firstLoad = true;

  void GetData(SessionData sessionData) async {
    try {
      var stationId = 1; //TODO: somehow get station id

      var args14 = Args14();
      args14.stationID = stationId;
      List<ProgramInfo> programs = await sessionData.client.programs(args14);
      StatusReport status = await sessionData.client.status();
      var stationStatus = status.stations.where((st) => st.id == stationId).single;
      int currentProgramId = programs.map((e) => e.id).toList().indexOf(stationStatus.currentProgram); //TODO: check if it is actually an id, redo the command

      if (!mounted) {
        return;
      }
      var args9 = Args9();
      args9.hash = stationStatus.hash;
      for (int i = 0; i < programs.length; i++)
      {
        args9.key = programs[i].name;//TODO: check if it is the right key
        var price = await sessionData.client.load(args9);
        _prices.add(price);
      }
      _ProgramsName = programs.map((p) => p.name);
      _ProgramsCheckbox[currentProgramId - 1] = true;
      _firstLoad = false;

      setState(()  {
      });
    } catch (e) {
      print("Exception when calling DefaultApi->programs in ProgramsMenu: $e\n");
    }
  }
  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;

    if (_firstLoad) {
      GetData(sessionData);
    }

    final AppBar appBar = AppBar(
      title: Text("Программы"),
    );

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar,
      drawer: prepareDrawer(context, Pages.Programs,sessionData),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return new SizedBox(
            height: screenH - appBar.preferredSize.height,
            width: screenW,
            child: ListView(
              children: _ProgramsName == null ? [] : List.generate(_ProgramsName.length, (index) {
                return new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 75,
                      width: screenW / 3,
                      child: Center(
                          child: Padding(
                        padding: EdgeInsets.all(10),
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(_ProgramsName[index]),
                        ),
                      )),
                    ),
                    SizedBox(
                      height: 75,
                      width: screenW / 3,
                      child: Row(
                        children: [
                          SizedBox(
                            width: screenW / 9,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text("Цена."),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 75,
                            width: screenW / 9,
                            child: Text(
                              /*decoration:
                                  InputDecoration(border: OutlineInputBorder()),*/
                              _prices[index] //TODO: switch back to TextField
                            ),
                          ),
                          SizedBox(
                            width: screenW / 9,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text("руб."),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 75,
                      width: screenW / 3,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.trailing,
                          title: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text(
                              'Активный',
                            ),
                          ),
                          value: _ProgramsCheckbox[index],
                          onChanged: (newValue) {
                            setState(() {
                              //TODO: check if checkboxes are meant to be changeable
                              /*_ProgramsCheckbox[index] =
                                  !_ProgramsCheckbox[index];*/
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
