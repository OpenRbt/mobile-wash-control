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

  List<StationStatus> _stations/*= [StationStatus()..id = 5..hash = 'test']*/;
  StationStatus _currentStation;
  var _firstLoad = true;

  void GetData(SessionData sessionData) async {
    try {
      if (_firstLoad) {
        StatusReport status = await sessionData.client.status();
        _stations = status.stations ?? [];
        _firstLoad = false;
        return;
      }
    } catch (e) {
      print("Exception when calling GetData in DozatronsMenu: $e\n");
    }
  }

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
              children: buildChildren(sessionData, screenW, screenH)
            ),
          );
        },
      ),
    );
  }

  List<Widget> buildChildren(SessionData sessionData, double screenW, double screenH)
  {
    return [DropdownButton(
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
              value: null, child: Text("--------"))))]
    ..addAll(List.generate(4, (index) {
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
    }));
  }
}
