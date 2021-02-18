import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';
import 'package:flutter/services.dart';
import 'RelaysMenu.dart';

class ProgramsMenuArgs {}

class ProgramsMenu extends StatefulWidget {
  @override
  _ProgramsMenuState createState() => _ProgramsMenuState();
}

class _ProgramsMenuState extends State<ProgramsMenu> {
  _ProgramsMenuState() : super();

  List<bool> _ProgramsCheckbox = List.generate(20, (index) {
    return false;
  });

  List<Program> _programs /*= [
    Program()
      ..name = 'test'
      ..price = 11
      ..preflightEnabled = true
      ..preflightRelays = [
        RelayConfig()
          ..timeoff = 800
          ..timeon = 200
          ..id = 1,
        RelayConfig()
          ..timeoff = 600
          ..timeon = 400
          ..id = 2
      ]
      ..relays = [
        RelayConfig()
          ..timeoff = 800
          ..timeon = 200
          ..id = 1,
        RelayConfig()
          ..timeoff = 600
          ..timeon = 400
          ..id = 2
      ],
    Program()
      ..name = 'test2'
      ..price = 22
      ..preflightEnabled = false
      ..preflightRelays = [
        RelayConfig()
          ..timeoff = 400
          ..timeon = 600
          ..id = 3,
        RelayConfig()
          ..timeoff = 500
          ..timeon = 500
          ..id = 4
      ]
      ..relays = [
        RelayConfig()
          ..timeoff = 400
          ..timeon = 600
          ..id = 3,
        RelayConfig()
          ..timeoff = 500
          ..timeon = 500
          ..id = 4
      ]
  ]*/;
  bool _firstLoad = true;

  void GetData(SessionData sessionData) async {
    try {
      var args14 = Args14();
      _programs = await sessionData.client.programs(args14);
      _firstLoad = false;
      /*if (!mounted) {
        return;
      }
      setState(() {});*/ //TODO: uncomment if it is needed
    } catch (e) {
      print("Exception when calling GetData in ProgramsMenu: $e\n");
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
      drawer: prepareDrawer(context, Pages.Programs, sessionData),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return new SizedBox(
            height: screenH - appBar.preferredSize.height,
            width: screenW,
            child: ListView(
                children: buildChildren(sessionData, screenW, screenH)),
          );
        },
      ),
    );
  }

  List<Widget> buildChildren(
      SessionData sessionData, double screenW, double screenH) {
    var prices = _programs?.map((e) => e.price)?.toList();
    return _programs == null || _programs.length == 0
        ? [Center(child: Text('Нет программ'))]
        : List.generate(_programs.length, (index) {
            var nameController = TextEditingController();
            nameController.value = TextEditingValue(
              text: _programs[index].name,
            );
            _controllers.add(nameController);

            var priceController = TextEditingController();
            priceController.value = TextEditingValue(
              text: prices[index].toString(),
            );
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
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                            controller: nameController,
                            onSubmitted: (newValue) async {
                              var previousName = _programs[index].name;
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
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder()),
                                  controller: priceController,
                                  onSubmitted: (newValue) async {
                                    var previousPrice = _programs[index].price;
                                    try {
                                      _programs[index].price =
                                          int.parse(newValue);
                                      await sessionData.client
                                          .setProgram(_programs[index]);
                                      setState(() {});
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
                            value: _ProgramsCheckbox[index],
                            onChanged: (newValue) {
                              setState(() {
                                //TODO: add real logic
                                print('Checkbox pressed');
                                //_ProgramsCheckbox[index] = !_ProgramsCheckbox[index];
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

  /*Widget generateDropdownButton(StationStatus _currentStation, SessionData sessionData)
  {
    return DropdownButton(
        value: _currentStation,
        onChanged: (newValue) {
          setState(() {
            _currentStation = newValue;
            if (_currentStation != null) GetData(sessionData);
          });
        },
        items: _stations == null
            ? []
            : List.generate(_stations.length, (index) {
          return DropdownMenuItem(
              value: _stations[index],
              child: Text("${_stations[index].id} пост"));
        })
          ..add(DropdownMenuItem<StationStatus>(
              value: null, child: Text("--------"))));
  }*/

  List<TextEditingController> _controllers = [];
  @override
  void dispose() {
    for (var c in _controllers) c.dispose();
    super.dispose();
  }
}
