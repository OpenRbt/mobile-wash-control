import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';

class DozatronsMenuArgs {}

class DozatronsMenu extends StatefulWidget {
  @override
  _DozatronsMenuState createState() => _DozatronsMenuState();
}

class _DozatronsMenuState extends State<DozatronsMenu> {
  _DozatronsMenuState() : super();

  List<String> _DozatronsDown = ["Активная пена", "Шампунь", "Воск", "Полимер"];

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      title: Text("Дозатроны"),
    );

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar,
      drawer: prepareDrawer(context, Pages.Dozatrons),
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
