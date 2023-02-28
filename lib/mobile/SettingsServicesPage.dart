import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../CommonElements.dart';

class SettingsServicesPage extends StatefulWidget {
  @override
  State<SettingsServicesPage> createState() => _SettingsServicesPageState();
}

class _SettingsServicesPageState extends State<SettingsServicesPage> {

  var serviceIdController = TextEditingController();
  var serviceKeyController = TextEditingController();
  String sessionKey = "key";
  String serviceId = "1";

  @override
  Widget build(BuildContext context) {

    double screenW = MediaQuery.of(context).size.width;

    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    SessionData sessionData = arguments['sessionData'];

    return Scaffold(
        appBar: AppBar(
            title: Text("Сервисы")
        ),
        drawer: prepareDrawer(context, Pages.Settings, sessionData),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Center(
              child: sessionKey == "" ? Column(
                children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 75,
                            width: screenW / 3,
                            child: Center(
                              child: Text("Service ID", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                            ),
                          ),
                          SizedBox(
                            height: 75,
                            width: screenW / 3 * 2,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                controller: serviceIdController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    Row(
                      children: [
                        SizedBox(
                          height: 75,
                          width: screenW / 3,
                          child: Center(
                            child: Text("Service Key", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                          ),
                        ),
                        SizedBox(
                          height: 75,
                          width: screenW / 3 * 2,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              controller: serviceKeyController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ElevatedButton(
                    onPressed: () { },
                    child: Text("Зарегестрировать"),
                  ),
                ],
              ): Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 75,
                          width: screenW / 3,
                          child: Center(
                            child: Text("Service ID", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                          ),
                        ),
                        SizedBox(
                          height: 75,
                          width: screenW / 3 * 2,
                          child: Center(
                            child: Text("${serviceId}"),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 75,
                          width: screenW / 3,
                          child: Center(
                            child: Text("Service Key", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                          ),
                        ),
                        SizedBox(
                          height: 75,
                          width: screenW / 3 * 2,
                          child: Center(
                            child: Text("${sessionKey}"),
                          ),
                        )
                      ],
                    ),
                  ]
              ),
            )
        )
    );
  }
}
