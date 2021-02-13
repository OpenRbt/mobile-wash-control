import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'client/api.dart';
import 'dart:async';

class PostMenuArgs {
  final int postID;
  final String hash;
  final SessionData sessionData;
  PostMenuArgs(this.postID, this.hash, this.sessionData);
}

class EditPostMenu extends StatefulWidget {
  EditPostMenu({Key key}) : super(key: key);

  @override
  _EditPostMenuState createState() => _EditPostMenuState();
}

class _EditPostMenuState extends State<EditPostMenu> {
  bool _firstLoad = true;
  Timer _updateBalanceTimer;
  int _balance = 0;
  int _current_program = -1;

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    if (_updateBalanceTimer.isActive) _updateBalanceTimer.cancel();
    super.dispose();
  }

  List<bool> _checkboxList = [false, false, false, false, false, false];
  final List<String> _buttonNames = [
    "пена",
    "вода + шампунь",
    "ополаскивание",
    "воск",
    "сушка и блеск",
    "пауза"
  ];

  void _getBalance(SessionData sessionData, int postID) async {
    try {
      var res1 = await sessionData.client.status();
      _current_program = res1.stations
          .where((element) => element.id == postID)
          .last
          .currentProgram;
      _current_program = _current_program ?? -1;
      var args = Args1();
      args.id = postID;
      var res = await sessionData.client.stationReportCurrentMoney(args);
      _balance = res.moneyReport.coins + res.moneyReport.banknotes;

      if (!mounted) {
        return;
      }
      setState(() {});
    } catch (e) {
      print(
          "Exception when calling DefaultApi->/station-report-current-money: $e\n");
    }
  }

  @override
  Widget build(BuildContext context) {
    final PostMenuArgs postMenuArgs = ModalRoute.of(context).settings.arguments;

    if (_firstLoad) {
      _getBalance(postMenuArgs.sessionData, postMenuArgs.postID);
      _updateBalanceTimer = new Timer.periodic(Duration(seconds: 15), (timer) {
        _getBalance(postMenuArgs.sessionData, postMenuArgs.postID);
      });
      _firstLoad = false;
    }

    final AppBar appBar = AppBar(
      title: Text("Пост: ${postMenuArgs.postID} | Баланс: $_balance руб"),
    );

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;

    if (screenW > screenH) {
      SystemChrome.setEnabledSystemUIOverlays([]);
    } else {
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    }

    return Scaffold(
      appBar: appBar,
      body: OrientationBuilder(
        builder: (context, orientation) {
          return new SizedBox(
              height: screenH - appBar.preferredSize.height,
              width: screenW,
              child: _getMenu(screenH > screenW, screenW, postMenuArgs));
        },
      ),
    );
  }

  Widget _getMenu(bool isPortrait, double screenW, PostMenuArgs postMenuArgs) {
    if (isPortrait) {
      return new ListView(
        children: [
          _getMainColumn(isPortrait, screenW, postMenuArgs),
          Divider(
            height: 5,
            thickness: 5,
            color: Colors.lightGreen,
          ),
          Row(
            children: [
              _getButtonsColumn(isPortrait, screenW),
              _getCheckBoxColumn(isPortrait, screenW)
            ],
          )
        ],
      );
    } else {
      return new FittedBox(
          fit: BoxFit.fill,
          child: Row(children: [
            _getMainColumn(isPortrait, screenW, postMenuArgs),
            _getButtonsColumn(isPortrait, screenW),
            _getCheckBoxColumn(isPortrait, screenW)
          ]));
    }
  }

  Widget _getMainColumn(
      bool isPortrait, double screenW, PostMenuArgs postMenuArgs) {
    return new Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: SizedBox(
            height: 50,
            width: isPortrait ? screenW / 2 - 20 : screenW / 3 - 20,
            child: DecoratedBox(
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Text("${_balance.toString()}"),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(color: Colors.lightGreen),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(
              //   height: 50,
              //   width: isPortrait ? 50 : (screenW / 3 - 20) / 6,
              //   child: Align(
              //       alignment: Alignment.center,
              //       child: FittedBox(
              //         fit: BoxFit.fill,
              //         child: IconButton(
              //           iconSize: 75,
              //           icon: Icon(Icons.remove_circle_outline),
              //           color: Colors.lightGreen,
              //           splashColor: Colors.lightGreenAccent,
              //           onPressed: () {
              //             setState(() {});
              //           },
              //         ),
              //       )),
              // ),
              SizedBox(
                height: 50,
                width: isPortrait ? 150 : (screenW / 3 - 20) / 6 * 4,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "10 руб",
                    style: TextStyle(fontSize: 36),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: isPortrait ? 50 : (screenW / 3 - 20) / 6,
                child: Align(
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: IconButton(
                        iconSize: 75,
                        icon: Icon(Icons.add_circle_outline),
                        color: Colors.lightGreen,
                        splashColor: Colors.lightGreenAccent,
                        onPressed: () {
                          setState(() {
                            try {
                              var args = Args2();
                              args.hash = postMenuArgs.hash;
                              args.amount = 10;
                              var res = postMenuArgs.sessionData.client
                                  .addServiceAmount(args);
                            } catch (e) {
                              print(
                                  "Exception when calling DefaultApi->/add-service-amount: $e\n");
                            }
                          });
                        },
                      ),
                    )),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: SizedBox(
            height: 50,
            width: isPortrait ? screenW / 2 - 20 : screenW / 3 - 20,
            child: RaisedButton(
              color: Colors.lightGreen,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.lightGreenAccent,
              child: Text(
                "Инкассировать",
                style: TextStyle(fontSize: 15),
              ),
              onPressed: () {
                try {
                  var args = Args6();
                  args.id = postMenuArgs.postID;
                  var res =
                      postMenuArgs.sessionData.client.saveCollection(args);
                } catch (e) {
                  print(
                      "Exception when calling DefaultApi->/save-collection: $e\n");
                }
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: SizedBox(
            height: 50,
            width: isPortrait ? screenW / 2 - 20 : screenW / 3 - 20,
            child: RaisedButton(
              color: Colors.lightGreen,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.lightGreenAccent,
              child: Text(
                "Открыть дверь",
                style: TextStyle(fontSize: 15),
              ),
              onPressed: () {
                try {
                  var args = Args13();
                  args.stationID = postMenuArgs.postID;
                  var res = postMenuArgs.sessionData.client.openStation(args);
                } catch (e) {
                  print(
                      "Exception when calling DefaultApi->/open-station: $e\n");
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _getButtonsColumn(bool isPortrait, double screenW) {
    return new Column(
      children: List.generate(6, (index) {
        return Padding(
            padding: EdgeInsets.all(10),
            child: SizedBox(
              height: 50,
              width: isPortrait ? screenW / 2 - 20 : screenW / 3 - 20,
              child: _getListButton(index),
            ));
      }),
    );
  }

  Widget _getCheckBoxColumn(bool isPortrait, double screenW) {
    return new Column(
      children: List.generate(6, (index) {
        return Padding(
            padding: EdgeInsets.all(10),
            child: SizedBox(
              height: 50,
              width: isPortrait ? screenW / 2 - 20 : screenW / 3 - 20,
              child: _getCheckBox(index),
            ));
      }),
    );
  }

  Widget _getCheckBox(int index) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.trailing,
      title: Text(
        'Активный',
        style: TextStyle(fontSize: 15),
      ),
      value: _checkboxList[index],
      onChanged: (newValue) {
        setState(() {
          _checkboxList[index] = !_checkboxList[index];
        });
      },
    );
  }

  Widget _getListButton(int index) {
    return new RaisedButton(
      color:
          (_current_program - 1) == index ? Colors.lightGreen : Colors.white10,
      textColor: Colors.white,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      splashColor: Colors.lightGreenAccent,
      onPressed: () {},
      child: Text(
        _buttonNames[index],
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}
