import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/ProgramMenuEdit.dart';
import 'package:mobile_wash_control/client/api.dart';
import 'package:flutter/services.dart';
import 'RelaysMenu.dart';

class ProgramsMenu extends StatefulWidget {
  @override
  _ProgramsMenuState createState() => _ProgramsMenuState();
}

class _ProgramsMenuState extends State<ProgramsMenu> {
  _ProgramsMenuState() : super();

  List<Program> _programs;
  bool _firstLoad = true;

  Future<String> GetData(SessionData sessionData) async {
    try {
      var args14 = Args14();
      _programs = await sessionData.client.programs(args14);
      if (!mounted) {
        return null;
      }
      _firstLoad = false;
      setState(() {});
      return null;
    } catch (e) {
      print("Exception when calling GetData in ProgramsMenu: $e\n");
      return 'Произошла ошибка при вызове апи';
    }
  }

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;
    if (_firstLoad) {
      GetData(sessionData);
      //TODO: return some error if unsuccessful (snackbar)?
    }

    final AppBar appBar = AppBar(
      title: Text("Программы"),
    );

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar,
      drawer: prepareDrawer(context, Pages.Programs, sessionData),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return new SizedBox(
              height: screenH - appBar.preferredSize.height,
              child: RefreshIndicator(
                  onRefresh: () async {
                    var err = await GetData(sessionData);
                    await Future.delayed(Duration(milliseconds: 500));
                    if (err != null)
                      showErrorDialog(context, err);
                    else
                      setState(() {});
                  },
                  child: Column(children: [
                    SizedBox(
                      height: 50,
                      width: screenW,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                            width: screenW / 7 * 2,
                            child: Text(
                              "Название",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: screenW / 7 * 2,
                            child: Text(
                              "Цена",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: screenW / 7 * 2,
                            child: Text(
                              "Активная",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenH - appBar.preferredSize.height - 91,
                      width: screenW,
                      child: ListView(
                          //children: buildChildren(sessionData, screenW, screenH)),
                          children:
                              programsTable(sessionData, screenW, screenH)),
                    ),
                  ])));
        },
      ),
    );
  }

  List<Widget> programsTable(
      SessionData sessionData, double screenW, double screenH) {
    return List.generate((_programs != null ? _programs.length : 0) + 1,
        (index) {
      if (index < (_programs?.length ?? 0)) {
        return Row(
          children: [
            SizedBox(
                height: 50,
                width: screenW / 7 * 2,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: index % 2 == 0 ? Colors.white : Colors.black12,
                      border: Border.all(color: Colors.black38)),
                  child: Text(
                    _programs[index].name ?? "no name",
                    textAlign: TextAlign.center,
                  ),
                )),
            SizedBox(
                height: 50,
                width: screenW / 7 * 2,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: index % 2 == 0 ? Colors.white : Colors.black12,
                      border: Border.all(color: Colors.black38)),
                  child: Text(
                    "${_programs[index].price ?? 0}",
                    textAlign: TextAlign.center,
                  ),
                )),
            SizedBox(
                height: 50,
                width: screenW / 7 * 2,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: index % 2 == 0 ? Colors.lightGreen : Colors.red,
                      border: Border.all(color: Colors.black38)),
                  child: Center(
                    //TODO: get active status (Kronusol)
                      child: Text(index % 2 == 0 ? "Active" : "Disabled",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 15))),
                )),
            SizedBox(
                height: 50,
                width: screenW / 7,
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: index % 2 == 0 ? Colors.white : Colors.black12,
                        border: Border.all(color: Colors.black38)),
                    child: IconButton(
                      icon: Icon(Icons.more_horiz),
                      onPressed: () {
                        var args =
                            ProgramMenuEditArgs(_programs[index], sessionData);
                        Navigator.pushNamed(context, "/home/programs/edit",
                            arguments: args);
                      },
                    ))),
          ],
        );
      } else {
        return Row(
          children: [
            SizedBox(
                height: 50,
                width: screenW / 7 * 2,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: index % 2 == 0 ? Colors.white : Colors.black12,
                      border: Border.all(color: Colors.black38)),
                  child: Text(
                    "",
                    textAlign: TextAlign.center,
                  ),
                )),
            SizedBox(
                height: 50,
                width: screenW / 7 * 2,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: index % 2 == 0 ? Colors.white : Colors.black12,
                      border: Border.all(color: Colors.black38)),
                  child: Text(
                    "",
                    textAlign: TextAlign.center,
                  ),
                )),
            SizedBox(
                height: 50,
                width: screenW / 7 * 2,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: index % 2 == 0 ? Colors.white : Colors.black12,
                      border: Border.all(color: Colors.black38)),
                  child: FlatButton(
                    color: Colors.white,
                  ),
                )),
            SizedBox(
                height: 50,
                width: screenW / 7,
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: index % 2 == 0 ? Colors.white : Colors.black12,
                        border: Border.all(color: Colors.black38)),
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        Navigator.pushNamed(context, "/home/programs/add",
                            arguments: sessionData);
                      },
                    ))),
          ],
        );
      }
    });
  }

  //TODO: remove after final implementation of ProgramsMenuAdd, ProgramsMenuEdit (Kronusol)
  List<Widget> buildChildren(
      SessionData sessionData, double screenW, double screenH) {
    var prices = _programs?.map((e) => e.price ?? 0)?.toList();
    return _programs == null || (_programs != null && _programs.length == 0)
        ? [Center(child: Text('Нет программ'))]
        : List.generate(_programs.length, (index) {
            var nameController = TextEditingController();
            nameController.value = TextEditingValue(
              text: _programs[index].name ?? "no name",
            );
            nameController.selection = TextSelection.fromPosition(
                TextPosition(offset: nameController.text.length));
            _controllers.add(nameController);

            var priceController = TextEditingController();
            priceController.value = TextEditingValue(
              text: prices[index].toString(),
            );
            priceController.selection = TextSelection.fromPosition(
                TextPosition(offset: priceController.text.length));
            _controllers.add(priceController);

            return new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 75,
                        width: screenW / 4,
                        child: buildForm(
                            style: TextStyle(fontSize: 24),
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                            controller: nameController,
                            onSubmitted: (newValue) async {
                              var previousName =
                                  _programs[index].name ?? "no name";
                              try {
                                _programs[index].name = newValue;
                                await sessionData.client
                                    .setProgram(_programs[index]);
                                return null;
                              } catch (e) {
                                _programs[index].name = previousName;
                                print(
                                    "Exception when calling DefaultApi->setProgram in ProgramsMenu: $e\n");
                                return 'Произошла ошибка при вызове апи';
                              }
                            }),
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
                              child: buildForm(
                                  style: TextStyle(fontSize: 24),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder()),
                                  controller: priceController,
                                  onSubmitted: (newValueString) async {
                                    var previousPrice =
                                        _programs[index].price ?? 0;
                                    try {
                                      var newValue = int.parse(newValueString);
                                      _programs[index].price = newValue;
                                      await sessionData.client
                                          .setProgram(_programs[index]);
                                      return null;
                                    } catch (e) {
                                      _programs[index].price = previousPrice;
                                      print(
                                          "Exception when calling DefaultApi->setProgram in ProgramsMenu: $e\n");
                                      return 'Произошла ошибка при вызове апи';
                                    }
                                  }),
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
                            value: false,
                            onChanged: (newValue) {
                              setState(() {
                                //TODO: add real logic
                                print('Checkbox pressed');
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 75,
                            width: screenW,
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: RaisedButton(
                                  color: Colors.lightGreen,
                                  textColor: Colors.white,
                                  disabledColor: Colors.grey,
                                  disabledTextColor: Colors.black,
                                  padding: EdgeInsets.all(8.0),
                                  splashColor: Colors.lightGreenAccent,
                                  child: FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Text("Реле",
                                        style: TextStyle(fontSize: 40)),
                                  ),
                                  onPressed: () {
                                    var args = RelaysMenuArgs(
                                        _programs[index], sessionData);
                                    Navigator.pushNamed(context, "/home/relays",
                                        arguments: args);
                                  },
                                )))
                      ])
                ]);
          });
  }

  List<TextEditingController> _controllers = [];
  @override
  void dispose() {
    for (var c in _controllers) c.dispose();
    super.dispose();
  }
}
