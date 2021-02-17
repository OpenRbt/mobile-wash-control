import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';
import 'package:flutter/services.dart';

class RelaysMenuArgs {
  final Program currentProgram;
  final SessionData sessionData;
  RelaysMenuArgs(this.currentProgram, this.sessionData);
}

class RelaysMenu extends StatefulWidget {
  @override
  _RelaysMenuState createState() => _RelaysMenuState();
}

class _RelaysMenuState extends State<RelaysMenu> {
  _RelaysMenuState() : super();

  final int _timeConstant = 1000;
  Program _program;

  @override
  Widget build(BuildContext context) {
    final RelaysMenuArgs dozatronsMenuArgs =
        ModalRoute.of(context).settings.arguments;
    final sessionData = dozatronsMenuArgs.sessionData;
    _program = dozatronsMenuArgs.currentProgram;

    final AppBar appBar = AppBar(
      title: Text("Реле"),
    );

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar,
      body: OrientationBuilder(
        builder: (context, orientation) {
          return new SizedBox(
              height: screenH - appBar.preferredSize.height,
              width: screenW,
              child: ListView(
                  children: [buildChildren(sessionData, screenW, screenH)]));
        },
      ),
    );
  }

  Widget buildChildren(
      SessionData sessionData, double screenW, double screenH) {
    return new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 75,
            width: screenW / 2,
            child: Center(
                child: Padding(
              padding: EdgeInsets.all(4),
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  _program.name,
                  style: TextStyle(fontSize: 60),
                ),
              ),
            )),
          ),
          SizedBox(
            height: 75,
            width: screenW / 2,
            child: Center(
                child: Padding(
              padding: EdgeInsets.all(4),
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  'Реле:',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            )),
          ),
        ]
          ..addAll(buildRelayList(sessionData, _program.relays, screenW))
          ..add(SizedBox(
            height: 75,
            width: screenW / 2,
            child: Center(
                child: Padding(
              padding: EdgeInsets.all(4),
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  'Реле прокачки:',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            )),
          ))
          ..add(CheckboxListTile(
            contentPadding: EdgeInsets.only(left: 5, right: 5),
            title: Text(
              'Прокачка',
            ),
            value: _program.preflightEnabled,
            onChanged: (newValue) async {
              var previousValue = _program.preflightEnabled;
              try {
                _program.preflightEnabled = !_program.preflightEnabled;
                await sessionData.client.setProgram(_program);
                setState(() {});
              } catch (e) {
                _program.preflightEnabled = previousValue;
                print(
                    "Exception when calling DefaultApi->setProgram in DozatronsMenu: $e\n");
              }
            },
          ))
          ..addAll(buildRelayList(
              sessionData, _program.preflightRelays, screenW)));
  }

  List<Widget> buildRelayList(SessionData sessionData, List<RelayConfig> relays,
      double screenW) {
    return List.generate(relays.length, (index) {
      var relay = relays[index];

      int on = 100 * relay.timeon ~/ (relay.timeon + relay.timeoff);

      var percentController = TextEditingController();
      percentController.value = TextEditingValue(
        text: on.toString(),
      );
      _controllers.add(percentController);

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
                  child: Text(
                    'Реле ${relay.id}',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              )),
            ),
            SizedBox(
              height: 75,
              width: screenW / 2,
              child: Row(
                children: [
                  SizedBox(
                    height: 60,
                    width: screenW / 4,
                    child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        controller: percentController,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                        onSubmitted: (newValueString) async {
                          var previousValue = on;
                          try {
                            int newValue = int.tryParse(newValueString);
                            if (newValue == null || newValue < 0 || newValue > 100) {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("Ошибка"),
                                    content: Text(
                                        "Неверное значение поля"),
                                    actionsPadding:
                                    EdgeInsets.all(10),
                                    actions: [
                                      RaisedButton(
                                        color:
                                        Colors.lightGreen,
                                        textColor:
                                        Colors.white,
                                        disabledColor:
                                        Colors.grey,
                                        disabledTextColor:
                                        Colors.black,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Ок"),
                                      )
                                    ],
                                  ));
                              return;
                            }
                            var timeon = newValue * _timeConstant ~/ 100;
                            var timeoff = _timeConstant - timeon;
                            /*print('before');
                            print(relay);*/
                            relay.timeon = timeon;
                            relay.timeoff = timeoff;
                            /*print('after');
                            print(relay);*/
                            await sessionData.client.setProgram(_program);
                          } catch (e) {
                            relay.timeon = previousValue * _timeConstant ~/ 100;
                            relay.timeoff = _timeConstant - relay.timeon;
                            print(
                                "Exception when calling DefaultApi->setProgram in DozatronsMenu: $e\n");
                          }
                        }),
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
