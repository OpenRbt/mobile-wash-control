import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/SharedData.dart';
import 'package:mobile_wash_control/main.dart';
import 'dart:async';

import 'package:mobile_wash_control/mobile/PostMenuEdit.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    SharedData.CanUpdateStatus = true;
  }

  @override
  void didPushNext() {
    SharedData.CanUpdateStatus = false;
  }

  @override
  void didPop() {
    SharedData.CanUpdateStatus = false;
  }

  @override
  void didPopNext() {
    SharedData.CanUpdateStatus = true;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);

  List<HomePageData> _homePageData = List();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Главная"),
      ),
      drawer: prepareDrawer(context, Pages.Main, sessionData),
      body: ValueListenableBuilder(
        valueListenable: SharedData.StationsData,
        builder: (BuildContext context, List<HomePageData> values, Widget child) {
          if (SharedData.StationsData.value == null || SharedData.StationsData.value.length == 0) {
            return child;
          }
          return Container(
            child: GridView.count(
              padding: const EdgeInsets.all(10),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 1,
              children: List.generate(
                SharedData.StationsData.value.length,
                (index) {
                  bool isOnline = SharedData.StationsData.value[index].status == "online";
                  return Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 1,
                          ),
                        ],
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Flex(
                            direction: Axis.horizontal,
                            children: [
                              Expanded(
                                child: Container(
                                  color: isOnline ? Colors.green : Colors.red,
                                  child: Column(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          var args = PostMenuArgs(
                                            SharedData.StationsData.value[index].id,
                                            SharedData.StationsData.value[index].ip,
                                            SharedData.StationsData.value[index].hash,
                                            SharedData.StationsData.value[index].currentProgramID,
                                            sessionData,
                                          );
                                          Navigator.pushNamed(context, "/mobile/editPost", arguments: args);
                                        },
                                        child: Column(
                                          children: [
                                            Text(
                                              SharedData.StationsData.value[index].name,
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            Divider(
                                              thickness: 2,
                                            ),
                                            Text(
                                              "Баланс: ${SharedData.StationsData.value[index].currentBalance}",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            Text(
                                              "IP: ${SharedData.StationsData.value[index].ip}",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Flex(
                            direction: Axis.horizontal,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(top: 5, bottom: 5),
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Text("Текущая программа:"),
                                      Divider(
                                        thickness: 3,
                                      ),
                                      Text(
                                        SharedData.StationsData.value[index].currentProgramID == 0 ? (isOnline ? "Ожидание клиента" : "") : SharedData.StationsData.value[index].currentProgramName ?? "Загрузка...",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
        child: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
