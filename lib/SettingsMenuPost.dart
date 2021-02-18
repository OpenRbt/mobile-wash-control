import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "client/api.dart";

class SettingsMenuPost extends StatefulWidget {
  @override
  _SettingsMenuPostState createState() => _SettingsMenuPostState();
}

class _SettingsMenuPostState extends State<SettingsMenuPost> {
  _SettingsMenuPostState() : super();

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text("Пост"),
    );

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appBar,
      body: OrientationBuilder(
        builder: (context, orientation) {
          return new SizedBox(
            height: screenH - appBar.preferredSize.height,
            child: Column(
              children: [
              ],
            ),
          );
        },
      ),
    );
  }
}
