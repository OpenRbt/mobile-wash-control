import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';
import 'package:flutter/services.dart';

class DozatronsMenuArgs {}

class DozatronsMenu extends StatefulWidget {
  @override
  _DozatronsMenuState createState() => _DozatronsMenuState();
}

class _DozatronsMenuState extends State<DozatronsMenu> {
  _DozatronsMenuState() : super();

  final int timeConstant = 100; //TODO change to 1000?
  List<Program> _programs = [
    Program()..name = 'test'..preflightRelays = [
      RelayConfig()..timeoff = 800..timeon = 200..id = 1
      , RelayConfig()..timeoff = 600..timeon = 400..id = 2
    ] ..relays = [
      RelayConfig()..timeoff = 800..timeon = 200..id = 1
      , RelayConfig()..timeoff = 600..timeon = 400..id = 2
    ]
    , Program()..name = 'test2'..preflightRelays = [
      RelayConfig()..timeoff = 400..timeon = 600..id = 3
      , RelayConfig()..timeoff = 500..timeon = 500..id = 4
    ]..relays = [
      RelayConfig()..timeoff = 400..timeon = 600..id = 3
      , RelayConfig()..timeoff = 500..timeon = 500..id = 4
    ]
  ];
  var _firstLoad = true;

  void GetData(SessionData sessionData) async {
    try {
      var args14 = Args14();
      _programs = await sessionData.client.programs(args14);
      _firstLoad = false;
    } catch (e) {
      print("Exception when calling GetData in DozatronsMenu: $e\n");
    }
  }

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;

    if (_firstLoad) {
      GetData(sessionData);
    }

    final AppBar appBar = AppBar(
      title: Text("Дозатроны"),
    );

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar,
      drawer: prepareDrawer(context, Pages.Dozatrons, sessionData),
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
    return _programs == null || _programs.length == 0
        ? [Center(child: Text('Нет программ'))]
        : List.generate(_programs.length, (index) {
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
                        width: screenW / 2,
                        child: Center(
                            child: Padding(
                          padding: EdgeInsets.all(10),
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text(_programs[index].name, style: TextStyle(fontSize: 60),),
                          ),
                        )),
                      ),
                    ],
                  )
                ]..addAll(buildRelayList(_programs[index].relays, screenW))..add(SizedBox(
                  height: 75,
                  width: screenW / 2,
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
                        child: Text("Прокачка"),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ))..addAll(buildRelayList(_programs[index].preflightRelays, screenW))
            );
          });
  }

  List<Widget> buildRelayList(List<RelayConfig> relays, double screenW) {
    return List.generate(relays.length, (index) {
      var relay = relays[index];

      //TODO 0 check
      int on = timeConstant * relay.timeon ~/ (relay.timeon + relay.timeoff);
      int off = timeConstant * relay.timeoff ~/ (relay.timeon + relay.timeoff);

      var percentOnController = TextEditingController();
      percentOnController.value = TextEditingValue(
        text: on.toString(),
      );
      _controllers.add(percentOnController);

      var percentOffController = TextEditingController();
      percentOffController.value = TextEditingValue(
        text: off.toString(),
      );
      _controllers.add(percentOffController);

      return new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 75,
              width: screenW / 2,
              child: Center(
                  child: Padding(
                padding: EdgeInsets.all(10),
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text('Реле ${relay.id}'),
                ),
              )),
            ),
            SizedBox(
              height: 75,
              width: screenW / 2,
              child: Row(
                children: [
                  SizedBox(
                    height: 25,
                    width: screenW / 4,
                    child: TextField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: percentOnController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    width: screenW / 4,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text("%"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
