import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';

class DozatronsMenuArgs {}

class DozatronsMenu extends StatefulWidget {
  @override
  _DozatronsMenuState createState() => _DozatronsMenuState();
}

class _DozatronsMenuState extends State<DozatronsMenu> {
  _DozatronsMenuState() : super();

  List<String> _DozatronsDown = ["Активная пена", "Шампунь", "Воск", "Полимер"];


  /*
    //stub
    var _firstLoad = true;

    void GetData(SessionData sessionData) async {
    try {
      var stationId = 1; //TODO: somehow get station id

      var args14 = Args14();
      args14.stationID = stationId;
      List<ProgramInfo> _programms = await sessionData.client.programs(args14);
      if (!mounted) {
        return;
      }
      setState(() async {
        for (int i = 0; i < 0; i++)
          {
            var args16 = Args16();
            args16.stationID = stationId;
            args16.programID = _programms[i].id;
            InlineResponse2001 programRelays = await sessionData.client.programRelays(args16);
            var relays = programRelays.relays;
            relays.first.
            return new RelayData(
                programRelay.id,
                programRelay.name,
                programRelay.hash,
                programRelay.status.value);
          }

        _settingsData.sort((a, b) => a.id.compareTo(b.id));
        _firstLoad = false;
      });
    } catch (e) {
      print("Exception when calling DefaultApi->: $e\n");
    }
  }*/

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;

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
              children: List.generate(4, (index) {
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
                          child: Text(_DozatronsDown[index]),
                        ),
                      )),
                    ),
                    SizedBox(
                      height: 75,
                      width: screenW / 3,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 25,
                            width: screenW / 6,
                            child: TextField(
                              decoration:
                                  InputDecoration(border: OutlineInputBorder()),
                            ),
                          ),
                          SizedBox(
                            width: screenW / 6,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text("имп./сек."),
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
