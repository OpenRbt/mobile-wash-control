import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'client/api.dart';
import 'dart:async';

class PostMenuArgs {
  final int postID;
  final String hash;
  final int currentProgramID;
  final List<Program> programs;
  final SessionData sessionData;
  PostMenuArgs(this.postID, this.hash, this.currentProgramID, this.programs,
      this.sessionData);
}

class EditPostMenu extends StatefulWidget {
  EditPostMenu({Key key}) : super(key: key);

  @override
  _EditPostMenuState createState() => _EditPostMenuState();
}

class _EditPostMenuState extends State<EditPostMenu> {
  bool _firstLoad = true;
  Timer _updateBalanceTimer;
  int _service_balance = 0;
  int _balance = 0;
  int _current_program_index = -1;
  bool _program_execution_server_side = true;

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    if (_updateBalanceTimer != null && _updateBalanceTimer.isActive)
      _updateBalanceTimer.cancel();
    super.dispose();
  }

  List<bool> _checkboxList = [false, false, false, false, false, false];
  List<String> _buttonNames = [
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
      _current_program_index = res1.stations
          .where((element) => element.id == postID)
          .last
          .currentProgram;
      _current_program_index = _current_program_index ?? 1;
      var args = Args1();
      args.id = postID;
      var res = await sessionData.client.stationReportCurrentMoney(args);
      _balance = res.moneyReport.coins + res.moneyReport.banknotes;
      _service_balance = res.moneyReport.service;
      if (!mounted) {
        return;
      }
      setState(() {});
    } catch (e) {
      print(
          "Exception when calling DefaultApi->/station-report-current-money: $e\n");
    }
  }

  void _addServiceMoney(PostMenuArgs postMenuArgs) async {
    try {
      var args = Args2();
      args.hash = postMenuArgs.hash;
      args.amount = 10;
      var res = await postMenuArgs.sessionData.client.addServiceAmount(args);
    } catch (e) {
      print("Exception when calling DefaultApi->/add-service-amount: $e\n");
    }
  }

  void _programButtonListener(index, PostMenuArgs postMenuArgs) async {
    if (index != _current_program_index) {
      try {
        var args = Args24();
        args.hash = postMenuArgs.hash;
        args.programID = postMenuArgs.programs[index].id ?? 1;
        await postMenuArgs.sessionData.client.runProgram(args);
        setState(() {
          if (_current_program_index != -1)
            _checkboxList[_current_program_index ?? 1] = false;
          _checkboxList[index] = true;
          _current_program_index = index;
        });
      } catch (e) {
        print(
            "Exception when calling DefaultApi->runProgram in EditPostMenu: $e\n");
      }
    } else {
      try {
        var args = Args24();
        args.hash = postMenuArgs.hash;
        args.programID = -1;
        await postMenuArgs.sessionData.client.runProgram(args);
        setState(() {
          if (_current_program_index != -1)
            _checkboxList[_current_program_index ?? 1] = false;
          _current_program_index = -1;
        });
      } catch (e) {
        print(
            "Exception when calling DefaultApi->runProgram in EditPostMenu: $e\n");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final PostMenuArgs postMenuArgs = ModalRoute.of(context).settings.arguments;

    final AppBar appBar = AppBar(
      title: Text("Пост: ${postMenuArgs.postID} | Баланс: $_balance руб"),
    );

    if (_firstLoad) {
      _getBalance(postMenuArgs.sessionData, postMenuArgs.postID);
      _updateBalanceTimer = new Timer.periodic(Duration(seconds: 15), (timer) {
        _getBalance(postMenuArgs.sessionData, postMenuArgs.postID);
      });

      if (postMenuArgs.programs != null && postMenuArgs.programs.length > 0) {
        _buttonNames = postMenuArgs.programs.map((e) => e.name ?? "").toList();
        _checkboxList = List.filled(_buttonNames.length, false);
        _current_program_index = postMenuArgs.programs.indexWhere((element) =>
            (element.id ?? 1) == (postMenuArgs.currentProgramID ?? 1));
        if (_current_program_index != -1)
          _checkboxList[_current_program_index] = true;
      }
      _firstLoad = false;
    }

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;

    if (screenW > screenH) {
      SystemChrome.setEnabledSystemUIOverlays([]);
    } else {
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    }

    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, _current_program_index);
          return false;
        },
        child: Scaffold(
          appBar: appBar,
          body: OrientationBuilder(
            builder: (context, orientation) {
              return new SizedBox(
                  height: screenH - appBar.preferredSize.height,
                  width: screenW,
                  child: _getMenu(screenH > screenW, screenW, postMenuArgs));
            },
          ),
        ));
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
              _getButtonsColumn(isPortrait, screenW, postMenuArgs),
              _getCheckBoxColumn(isPortrait, screenW, postMenuArgs)
            ],
          )
        ],
      );
    } else {
      return new FittedBox(
          fit: BoxFit.fill,
          child: Row(children: [
            _getMainColumn(isPortrait, screenW, postMenuArgs),
            _getButtonsColumn(isPortrait, screenW, postMenuArgs),
            _getCheckBoxColumn(isPortrait, screenW, postMenuArgs)
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
                  child: Text("$_service_balance"),
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
                          _addServiceMoney(postMenuArgs);
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
        Padding(
          padding: EdgeInsets.all(10),
          child: SizedBox(
            height: 50,
            width: isPortrait ? screenW / 2 - 20 : screenW / 3 - 20,
            child: DropdownButton(
                isExpanded: true,
                value: _program_execution_server_side,
                onChanged: (newValue) {
                  setState(() {
                    if (newValue != true)
                      showErrorDialog(
                          context, "Поддерживаются только платы 2 ревизии");
                  });
                },
                items: [
                  DropdownMenuItem(value: false, child: Text("Локально")),
                  DropdownMenuItem(value: true, child: Text("На сервере"))
                ]),
          ),
        ),
      ],
    );
  }

  Widget _getButtonsColumn(
      bool isPortrait, double screenW, PostMenuArgs postMenuArgs) {
    return new Column(
      children: List.generate(postMenuArgs.programs?.length ?? 0, (index) {
        return Padding(
            padding: EdgeInsets.all(10),
            child: SizedBox(
              height: 50,
              width: isPortrait ? screenW / 2 - 20 : screenW / 3 - 20,
              child: _getListButton(index, postMenuArgs),
            ));
      }),
    );
  }

  Widget _getCheckBoxColumn(
      bool isPortrait, double screenW, PostMenuArgs postMenuArgs) {
    return new Column(
      children: List.generate(postMenuArgs.programs?.length ?? 0, (index) {
        return Padding(
            padding: EdgeInsets.all(10),
            child: SizedBox(
              height: 50,
              width: isPortrait ? screenW / 2 - 20 : screenW / 3 - 20,
              child: _getCheckBox(index, postMenuArgs),
            ));
      }),
    );
  }

  Widget _getCheckBox(int index, PostMenuArgs postMenuArgs) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.trailing,
      title: Text(
        'Активный',
        style: TextStyle(fontSize: 15),
      ),
      value: index < _checkboxList.length ? _checkboxList[index] : false,
      onChanged: (newValue) async {
        _programButtonListener(index, postMenuArgs);
      },
    );
  }

  Widget _getListButton(int index, PostMenuArgs postMenuArgs) {
    return new RaisedButton(
      color: (_current_program_index ?? 1) == index
          ? Colors.lightGreen
          : Colors.white10,
      textColor: Colors.white,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      splashColor: Colors.lightGreenAccent,
      onPressed: () async {
        _programButtonListener(index, postMenuArgs);
      },
      child: Text(
        "${index < _buttonNames.length ? _buttonNames[index] : ""}",
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}
