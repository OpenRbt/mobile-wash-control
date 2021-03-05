import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';
import 'dart:async';

import 'PostMenuEdit.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class HomePageData {
  final int id;
  final String name;
  final String hash;
  final String status;
  final String info;
  final int currentBalance;
  int currentProgramID;

  HomePageData(this.id, this.name, this.hash, this.status, this.info,
      this.currentBalance, this.currentProgramID);
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);

  bool _firstLoad = true;
  List<HomePageData>
      _homePageData /* = List.generate(8, (index) {
    return new HomePageData(-1, "Loading...", "...", "...", "...", -1, -1);
  })*/
      ;
  Timer _updateTimer;

  List<Program> _programs;

  final List<String> _buttonLabel = ["П", "Ш", "О", "В", "С", "| |"];

  void GetStations(SessionData sessionData) async {
    try {
      var res = await sessionData.client.status();
      var args14 = Args14();
      _programs = await sessionData.client.programs(args14);

      if (!mounted) {
        return;
      }
      _homePageData = List.generate((res.stations.length), (index) {
        return new HomePageData(
            res.stations[index].id,
            res.stations[index].name,
            res.stations[index].hash,
            res.stations[index].status.value,
            res.stations[index].info,
            res.stations[index].currentBalance,
            res.stations[index].currentProgram);
      });

      _homePageData.sort((a, b) => a.id.compareTo(b.id));
      setState(() {});
    } catch (e) {
      print("Exception when calling DefaultApi->Status in HomePage: $e\n");
      showErrorSnackBar(_scaffoldKey, _isSnackBarActive);
    }
  }

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;
    if (_firstLoad) {
      GetStations(sessionData);
      _updateTimer = new Timer.periodic(Duration(seconds: 1), (timer) {
        GetStations(sessionData);
      });
      _firstLoad = false;
    }

    return Scaffold(
        key: _scaffoldKey,
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
              childAspectRatio: 1,
              children: List.generate(_homePageData?.length ?? 0, (index) {
                var activeProgramIndex = _programs?.indexWhere((element) =>
                        (element.id ?? 1) ==
                        (_homePageData[index].currentProgramID ?? 1)) ??
                    -1;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 165,
                      child: FlatButton(
                        color: _homePageData[index].status == "online"
                            ? Colors.lightGreen
                            : Colors.red,
                        highlightColor: _homePageData[index].status == "online"
                            ? Colors.lightGreenAccent
                            : Colors.redAccent,
                        onPressed: () {
                          var args = PostMenuArgs(
                              _homePageData[index].id,
                              _homePageData[index].hash,
                              _homePageData[index].currentProgramID,
                              _programs,
                              sessionData);
                          _updateTimer.cancel();
                          Navigator.pushNamed(context, "/home/editPost",
                                  arguments: args)
                              .then((value) {
                            if (value != -1)
                              _homePageData[index].currentProgramID =
                                  _programs[value ?? 1].id;
                            else
                              _homePageData[index].currentProgramID = -1;
                            _updateTimer = new Timer.periodic(
                                Duration(seconds: 1), (timer) {
                              GetStations(sessionData);
                            });
                            setState(() {});
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_homePageData[index].name),
                            Text(
                                "Баланс: ${_homePageData[index].currentBalance ?? '__'}"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 115,
                      width: 165,
                      child: DecoratedBox(
                          child: GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 3,
                            children: List.generate(6, (btnIndex) {
                              return SizedBox(
                                  height: 50,
                                  width: 200,
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: FlatButton(
                                      color: btnIndex == activeProgramIndex
                                          ? Colors.lightGreenAccent
                                          : Colors.white,
                                      onPressed: () async {
                                        if (btnIndex <
                                            (_programs?.length ?? 0)) {
                                          if (btnIndex != activeProgramIndex) {
                                            try {
                                              var args = Args24();
                                              args.hash =
                                                  _homePageData[index].hash;
                                              args.programID =
                                                  _programs[btnIndex].id ?? 1;
                                              await sessionData.client
                                                  .runProgram(args);
                                              setState(() {
                                                _homePageData[index]
                                                        .currentProgramID =
                                                    _programs[btnIndex].id ?? 1;
                                              });
                                            } catch (e) {
                                              print(
                                                  "Exception when calling DefaultApi->runProgram in EditPostMenu: $e\n");
                                            }
                                          } else {
                                            try {
                                              var args = Args24();
                                              args.hash =
                                                  _homePageData[index].hash;
                                              args.programID = -1;
                                              await sessionData.client
                                                  .runProgram(args);
                                              setState(() {
                                                _homePageData[index]
                                                    .currentProgramID = -1;
                                              });
                                            } catch (e) {
                                              print(
                                                  "Exception when calling DefaultApi->runProgram in EditPostMenu: $e\n");
                                            }
                                          }
                                        }
                                      },
                                      child: Text(
                                          btnIndex < (_programs?.length ?? 0)
                                              ? _buttonLabel[btnIndex]
                                              : ""),
                                    ),
                                  ));
                            }),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black26,
                          )),
                    )
                  ],
                );
              }),
            );
          },
        ));
  }

  @override
  void dispose() {
    if (_updateTimer != null && _updateTimer.isActive) {
      _updateTimer.cancel();
    }
    super.dispose();
  }
}
