import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wash_control/utils/common.dart';
import 'package:mobile_wash_control/wash-admin-client/api.dart';

import '../CommonElements.dart';

class SettingsServicesPage extends StatefulWidget {
  @override
  State<SettingsServicesPage> createState() => _SettingsServicesPageState();
}

class _SettingsServicesPageState extends State<SettingsServicesPage> {

  Future<WashServer?> _getWashServer() async {
      try{
        Future<WashServer?> washServer = Common.washServersApi!.callGet(body: WashServerGet(id: ""));
        return washServer;
      } on HttpException catch(e){
        print("HttpException");
      } catch(e){
        print("OtherException");
      }
  }

  User? user = FirebaseAuth.instance.currentUser;
  var serviceIdController = TextEditingController();
  var serviceKeyController = TextEditingController();
  String sessionKey = "";
  String serviceId = "";

  @override
  void initState() {
    super.initState();
    _getWashServer();
  }

  //Где брать service id??????
  //Пользователю должен возвращаться список wash server или только один ash server?

  @override
  Widget build(BuildContext context) {

    double screenW = MediaQuery.of(context).size.width;

    //final arguments =
    SessionData sessionData = ModalRoute.of(context)?.settings.arguments as SessionData;

    return user != null ?
    Scaffold(
        appBar: AppBar(
            title: Text("Сервисы")
        ),
        drawer: prepareDrawer(context, Pages.Services, sessionData),
        backgroundColor: Colors.white,
        body: FutureBuilder<WashServer?>(
        future: _getWashServer(),
        builder: (BuildContext context, AsyncSnapshot<WashServer?> snapshot){
          log("Hashcode errror: " + snapshot.error.hashCode.toString());
          if(snapshot.hasData){
            return Center(
              child: Column(
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
                            child: Text("${snapshot.data!.id.toString()}"),
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
                            child: Text("${snapshot.data!.serviceKey.toString()}"),
                          ),
                        )
                      ],
                    ),
                  ]
              ),
            );
          }
          else if(snapshot.error.hashCode == 404){
            return Center(
              child: Column(
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
                    onPressed: () async {
                      Common.washServersApi?.add(body: WashServerAdd(name: serviceIdController.text, description: serviceKeyController.text));
                    },
                    child: Text("Зарегестрировать"),
                  ),
                ],
              ),
            );
          }
          else if(snapshot.hasError){
            return Container(
              child: Text("Server error", style: TextStyle(
                fontSize: 30,
                fontFamily: 'Roboto',
                color: Colors.black,
                decoration: TextDecoration.none,
              )),
            );
          }
          else{
            return Column(
              children: [
                SizedBox(
                  height: 300.0,
                ),
                Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.lightGreen,
                    ),
                  ),
                )
              ],
            );
          }
        }
        )
    ):
    Container( );
  }
}


/*
SafeArea(
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
 */