import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';

import 'EditPostMenu.dart';

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
  final int programID;

  HomePageData(this.id, this.name, this.hash, this.status, this.info,
      this.currentBalance, this.programID);
}

class _HomePageState extends State<HomePage> {
  bool _firstLoad = true;
  List<HomePageData> _homePageData = List.generate(8, (index) {
    return new HomePageData(-1, "Loading...", "...", "...", "...", -1, -1);
  });

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
      _firstLoad = false;
      setState(() {});
    } catch (e) {
      print("Exception when calling DefaultApi->Status: $e\n");
    }
  }

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;

    if (_firstLoad) {
      GetStations(sessionData);
    }

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
              childAspectRatio: 1,
              children: List.generate(_homePageData?.length ?? 0, (index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 165,
                      child: RaisedButton(
                        color: _homePageData[index].status == "online" ?  Colors.lightGreen : Colors.red,
                        highlightColor: _homePageData[index].status == "online" ?  Colors.lightGreenAccent : Colors.redAccent,
                        onPressed: () {
                          var args = PostMenuArgs(_homePageData[index].id,
                              _homePageData[index].hash, _homePageData[index].programID, _programs, sessionData);
                          Navigator.pushNamed(context, "/home/editPost",
                              arguments: args);
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
                            children: List.generate(6, (btn) {
                              return SizedBox(
                                  height: 50,
                                  width: 200,
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: RaisedButton(
                                      color: btn + 1 ==
                                              _homePageData[index].programID
                                          ? Colors.lightGreenAccent
                                          : Colors.white,
                                      onPressed: () {},
                                      child: Text(_buttonLabel[btn]),
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
}
