import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_wash_control/CommonElements.dart';
class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SessionData sessionData;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Главная"),
        ),
        drawer: prepareDrawer(context, Pages.Main, sessionData),
        body: OrientationBuilder(
          builder: (context, orientation) {
            return GridView.count(
              padding: const EdgeInsets.all(10),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
              children: List.generate(12, (index) {
                return SizedBox(
                  height: 200,
                  width: 200,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(color: Colors.black12),
                    //padding: const EdgeInsets.all(0),
                    //color: Colors.black12,
                    //onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 50,
                            width: 200,
                            child: Column(
                              children: [
                                Text("FIELD: ${index + 1}"),
                                Text("PROGRAM: ${index + 1}"),
                              ],
                            )),
                        SizedBox(
                            height: 102.5,
                            width: 200,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: FlatButton(
                                        color: Colors.lightGreen,
                                        splashColor: Colors.lightGreenAccent,
                                        onPressed: () {
                                          print(
                                              "Tapped on button 1 from ${index + 1}");
                                        },
                                        child: Text("1"),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.5,
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: FlatButton(
                                        color: Colors.lightGreen,
                                        splashColor: Colors.lightGreenAccent,
                                        onPressed: () {
                                          print(
                                              "Tapped on button 2 from ${index + 1}");
                                        },
                                        child: Text("2"),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.5,
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: FlatButton(
                                        color: Colors.lightGreen,
                                        splashColor: Colors.lightGreenAccent,
                                        onPressed: () {
                                          print(
                                              "Tapped on button 3 from ${index + 1}");
                                        },
                                        child: Text("3"),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 2.5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: FlatButton(
                                        color: Colors.lightGreen,
                                        splashColor: Colors.lightGreenAccent,
                                        onPressed: () {
                                          print(
                                              "Tapped on button 4 from ${index + 1}");
                                        },
                                        child: Text("4"),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.5,
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: FlatButton(
                                        color: Colors.lightGreen,
                                        splashColor: Colors.lightGreenAccent,
                                        onPressed: () {
                                          print(
                                              "Tapped on button 5 from ${index + 1}");
                                        },
                                        child: Text("5"),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.5,
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: FlatButton(
                                        color: Colors.lightGreen,
                                        splashColor: Colors.lightGreenAccent,
                                        onPressed: () {
                                          print(
                                              "Tapped on button 6 from ${index + 1}");
                                        },
                                        child: Text("6"),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                );
              }),
            );
          },
        ));
  }
}
