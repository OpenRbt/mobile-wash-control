import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';
import 'package:flutter/services.dart';

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

  /*List<String> _ProgramsName = [
    "Пена",
    "Вода + Шампунь",
    "Ополаскивание",
    "Воск",
    "Сушка и блеск",
    "Пауза"
  ]*/

  List<ProgramInfo>
      _programs/*= [
    ProgramInfo()..id = 1..name = 'test1',
    ProgramInfo()..id = 2..name = 'test2',
  ]*/
      ;

  List<String> _prices/*= ['11', '22']*/;
  List<StationStatus> _stations/*= [StationStatus()..id = 5..hash = 'test']*/;
  StationStatus _currentStation;
  bool _firstLoad = true;

  void GetData(SessionData sessionData) async {
    try {
      if (_firstLoad) {
        StatusReport status = await sessionData.client.status();
        _stations = status.stations ?? [];
        _firstLoad = false;
        return;
      }

      var args14 = Args14();
      args14.stationID = _currentStation.id;
      _programs = await sessionData.client.programs(args14);
      StatusReport status = await sessionData.client.status();
      var stationStatus =
          status.stations.where((st) => st.id == _currentStation.id).single;
      var args9 = Args9();
      args9.hash = stationStatus.hash;
      for (int i = 0; i < _programs.length; i++) {
        args9.key = _programs[i].name;
        args9.hash = _currentStation.hash;
        var price = await sessionData.client.load(args9);
        _prices.add(price);
      }
      if (!mounted) {
        return;
      }
      setState(() {}); //TODO: check if it is needed
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
            child:
                ListView(children: buildChildren(sessionData, screenW, screenH)),
          );
        },
      ),
    );
  }

  List<Widget> buildChildren(
      SessionData sessionData, double screenW, double screenH) {
    return [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Посты:'),
        SizedBox(width: 20),
        DropdownButton(
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
                  value: null, child: Text("--------"))))
      ])
    ]..addAll(_programs == null
        ? [Center(child: Text('Нет программ'))]
        : List.generate(_programs.length, (index) {
            var nameController = TextEditingController();
            nameController.value = TextEditingValue(
              text: _programs[index].name,
            );
            _controllers.add(nameController);

            var priceController = TextEditingController();
            priceController.value = TextEditingValue(
              text: _prices[index],
            );
            _controllers.add(priceController);

            return new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 75,
                  width: screenW / 4,
                  child: TextField(
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      controller: nameController,
                      onSubmitted: (newValue) async {
                        try {
                          var args = Args15();
                          args.stationID = _currentStation.id;
                          args.programID = _programs[index].id;
                          args.name = newValue;
                          await sessionData.client.setProgramName(args);
                          _programs[index].name = newValue;
                        } catch (e) {
                          print(
                              "Exception when calling DefaultApi->setProgramName in ProgramsMenu: $e\n");
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
                        child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                            controller: priceController,
                            onSubmitted: (newValue) async {
                              try {
                                var args = Args8();
                                args.hash = _currentStation.hash;
                                args.keyPair = KeyPair()
                                  ..key = _programs[index].name
                                  ..value = newValue;
                                await sessionData.client.save(args);
                                _prices[index] = newValue;
                              } catch (e) {
                                print(
                                    "Exception when calling DefaultApi->save in ProgramsMenu: $e\n");
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
            );
          }));
  }

  List<TextEditingController> _controllers = [];
  @override
  void dispose() {
    for (var c in _controllers) c.dispose();
    super.dispose();
  }
}
