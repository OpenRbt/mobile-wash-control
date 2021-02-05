import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';

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
  List<String> _ProgramsName = [
    "Пена",
    "Вода + Шампунь",
    "Ополаскивание",
    "Воск",
    "Сушка и блеск",
    "Пауза"
  ];

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      title: Text("Программы"),
    );

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar,
      drawer: prepareDrawer(context, Pages.Programs),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return new SizedBox(
            height: screenH - appBar.preferredSize.height,
            width: screenW,
            child: ListView(
              children: List.generate(6, (index) {
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
                            child: TextField(
                              decoration:
                                  InputDecoration(border: OutlineInputBorder()),
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
                              _ProgramsCheckbox[index] =
                                  !_ProgramsCheckbox[index];
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
