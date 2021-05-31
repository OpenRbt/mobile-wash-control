import 'package:flutter/material.dart';
import 'package:mobile_wash_control/desktop/DEditPost.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:flutter/services.dart';
import 'package:mobile_wash_control/client/api.dart';
import 'dart:async';

class DHomePage extends StatefulWidget {
  @override
  _DHomePageState createState() => _DHomePageState();
}

class HomePageData {
  final int id;
  final String name;
  final String ip;
  final String hash;
  final String status;
  final String info;
  final int currentBalance;
  int currentProgramID;

  HomePageData(this.id, this.name, this.ip, this.hash, this.status, this.info,
      this.currentBalance, this.currentProgramID);
}

class _DHomePageState extends State<DHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);

  Timer _updateTimer;
  Timer _updateLabelsTimer;

  List<Program> _programs;
  Map<int, List<InlineResponse2001Buttons>> _stationProgramsButtons = Map();
  Map<int, Map<int, String>> _stationLabels = Map();
  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;
    if (_firstLoad) {
      _getStations(sessionData);
      _getLabels(sessionData);
      _updateTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        _getStations(sessionData);
      });
      _updateLabelsTimer = Timer.periodic(Duration(seconds: 10), (timer) {
        _getLabels(sessionData);
      });
      _firstLoad = false;
    }

    var screenW = MediaQuery.of(context).size.width;
    var screenH = MediaQuery.of(context).size.height;

    var width = screenW - screenW / 4;
    var height = screenH;
    return Scaffold(
      key: _scaffoldKey,
      body: Row(
        children: [
          DGetDrawer(screenH, screenW / 4, context, Pages.Main, sessionData),
          SizedBox(
            height: screenH,
            width: width,
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(10),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 4,
              childAspectRatio: (width / 4) / (height / 3),
              children: List.generate(_homePageData?.length ?? 0, (index) {
                var activeProgramIndex = _homePageData[index].currentProgramID;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 60,
                      width: width / 4,
                      child: FlatButton(
                        color: _homePageData[index].status == "online"
                            ? Colors.green
                            : Colors.red,
                        highlightColor: _homePageData[index].status == "online"
                            ? Colors.greenAccent
                            : Colors.redAccent,
                        disabledColor: Colors.red,
                        disabledTextColor: Colors.black,
                        onPressed: () {
                          var args = DEditPostArgs(
                              _homePageData[index].id,
                              _homePageData[index].ip,
                              _homePageData[index].hash,
                              _homePageData[index].currentProgramID,
                              _stationProgramsButtons[_homePageData[index].id],
                              _programs,
                              this._homePageData[index].currentBalance,
                              sessionData);
                          Navigator.pushNamed(context, "/desktop/home/edit",
                              arguments: args);

                          setState(() {});
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_homePageData[index].name),
                            Text(
                                "Баланс: ${_homePageData[index].currentBalance ?? '__'}"),
                            Text(
                                "IP: ${_homePageData[index].ip}"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 115,
                      child: DecoratedBox(
                        child: Center(
                          child: SizedBox(
                            height: 100,
                            child: DecoratedBox(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Текущая программа",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                      thickness: 3,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Text(activeProgramIndex == -1
                                          ? "Idle"
                                          : _programs.firstWhere(
                                                  (element) =>
                                                      element.id ==
                                                      activeProgramIndex,
                                                  orElse: () {
                                                return null;
                                              })?.name ??
                                              "Загрузка..."),
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.grey, width: 3),
                              ),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(color: Colors.grey),
                      ),
                    )
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  bool _firstLoad = true;
  List<HomePageData> _homePageData = List.generate(12, (index) {
    return HomePageData(-1, "Loading...", "...", "...", "...", "...", -1, -1);
  });

  void initState() {
    super.initState();
  }

  void _getLabels(SessionData sessionData) async {
    bool redraw = false;
    try {
      if (!mounted) {
        return;
      }
      var args14 = ProgramsArgs();
      _programs = await sessionData.client.programs(args14);

      for (int i = 0; i < _homePageData.length; i++) {
        try {
          var args = StationButtonArgs();
          args.stationID = _homePageData[i].id;
          var res = await sessionData.client.stationButton(args);

          Map<int, String> labels = Map();

          if (res.buttons != null) {
            _stationProgramsButtons[i + 1] = res.buttons;

            for (int i = 0; i < res.buttons.length; i++) {
              if (res.buttons[i].buttonID != null) {
                Program program = _programs
                    .where((element) => element.id == res.buttons[i].programID)
                    .first;
                if (program != null) {
                  String label = program.name.length > 0 ? program.name[0] : "";
                  if (program.name.length > 0 &&
                      program.name.lastIndexOf(" ") > 0 &&
                      program.name.lastIndexOf(" ") + 1 < program.name.length) {
                    label += program.name[program.name.lastIndexOf(" ") + 1];
                  }
                  labels[res.buttons[i].buttonID - 1] = label;
                }
              }
            }
          }
          redraw = _stationLabels[_homePageData[i].id] != labels;
          _stationLabels[_homePageData[i].id] = labels;
        } catch (e) {}
      }
    } catch (e) {
      print("Exception when calling DefaultApi->Status in HomePage: $e\n");
      showInfoSnackBar(_scaffoldKey, _isSnackBarActive,
          "Произошла ошибка при запросе к api", Colors.red);
    }
    if (redraw) setState(() {});
  }

  void _getStations(SessionData sessionData) async {
    bool redraw = false;
    try {
      var res = await sessionData.client.status();
      res.stations =
          res.stations.where((element) => element.id != null).toList();
      if (!mounted) {
        return;
      }
      var tmpHomepage = List.generate((res.stations.length), (index) {
        return HomePageData(
            res.stations[index].id ?? index + 1,
            res.stations[index].name ?? "Station ${index + 1}",
            res.stations[index].ip ?? "",
            res.stations[index].hash ?? "",
            res.stations[index].status.value ?? "",
            res.stations[index].info ?? "",
            res.stations[index].currentBalance ?? 0,
            res.stations[index].currentProgram ?? -1);
      });

      tmpHomepage.sort(
        (a, b) => a.id.compareTo(b.id),
      );
      redraw = _homePageData != tmpHomepage;
      if (redraw) _homePageData = tmpHomepage;
    } catch (e) {
      print("Exception when calling DefaultApi->Status in HomePage: $e\n");
      showInfoSnackBar(_scaffoldKey, _isSnackBarActive,
          "Произошла ошибка при запросе к api", Colors.red);
    }

    if (redraw) setState(() {});
  }
}
