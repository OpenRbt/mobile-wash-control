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
  List<String> _ProgramsName = ['test1','test2'];
  /* = [
    "Пена",
    "Вода + Шампунь",
    "Ополаскивание",
    "Воск",
    "Сушка и блеск",
    "Пауза"
  ]*/

  List<String> _prices = ['11', '22'];
  int _stationId = -1;
  List<StationStatus> _stations;
  bool _firstLoad = true;

  void GetData(SessionData sessionData) async {
    try {
      if (_firstLoad) {
        /*var fake = StationStatus();
        fake.id = 5;
        _stations = [fake];*/
        StatusReport status = await sessionData.client.status();
        return; //TODO: remove afterwards
        _stations = status.stations ?? [];
        _firstLoad = false;
        return;
      }

      var args14 = Args14();
      args14.stationID = _stationId;
      List<ProgramInfo> programs = await sessionData.client.programs(args14);
      StatusReport status = await sessionData.client.status();
      var stationStatus =
          status.stations.where((st) => st.id == _stationId).single;
      //int currentProgramIndex = programs.map((e) => e.id).toList().indexOf(stationStatus.currentProgram);

      if (!mounted) {
        return;
      }
      var args9 = Args9();
      args9.hash = stationStatus.hash;
      for (int i = 0; i < programs.length; i++) {
        args9.key = programs[i].name;
        //args9.hash = ''; //TODO: fill it
        var price = await sessionData.client.load(args9);
        _prices.add(price);
      }
      _ProgramsName = programs.map((p) => p.name);
      //_ProgramsCheckbox[currentProgramIndex] = true;
      setState(() {});
    } catch (e) {
      print(
          "Exception when calling DefaultApi->programs in ProgramsMenu: $e\n");
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
            ListView(children: buildThings(sessionData, screenW, screenH)),
          );
        },
      ),
    );
  }

  List<Widget> buildThings(
      SessionData sessionData, double screenW, double screenH) {
    return [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Посты:'),
        SizedBox(width: 20),
        DropdownButton(
            value: _stationId,
            onChanged: (newValue) {
              setState(() {
                _stationId = newValue;
                GetData(sessionData);
              });
            },
            items: _stations == null
                ? []
                : List.generate(_stations.length, (index) {
                    return DropdownMenuItem(
                        value: _stations[index].id,
                        child: Text("${_stations[index].id} пост"));
                  })
              ..add(DropdownMenuItem<int>(value: -1, child: Text("--------"))))
      ])
    ]..addAll(_ProgramsName == null
        ? [Center(child: Text('Нет программ'))]
        : List.generate(_ProgramsName.length, (index) {

            var nameController = TextEditingController();
            _controllers.add(nameController);
            nameController.value = TextEditingValue(
              text: _ProgramsName[index],
            );

            var priceController = TextEditingController();
            _controllers.add(priceController);
            priceController.value = TextEditingValue(
              text: _prices[index],
            );

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
                    onSubmitted: (newValue) {
                      _ProgramsName[index] = newValue;
                      var args = Args15();
                      args.name = newValue;
                      args.stationID = _stationId;
                      // args.programID = a; TODO: get them in getdata
                      //sessionData.client.setProgramName(args);
                    }
                  ),
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
                            onSubmitted: (newValue) {
                              _prices[index] = newValue;

                              //sessionData.client.save(args); //TODO: api call
                            }
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
    for (var c in _controllers)
      c.dispose();
    super.dispose();
  }
}
