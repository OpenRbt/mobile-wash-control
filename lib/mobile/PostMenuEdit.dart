import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';
import 'dart:async';

class PostMenuArgs {
  final int postID;
  final String hash;
  final int currentProgramID;
  final List<InlineResponse2001Buttons> buttonPrograms;
  final List<Program> programs;
  final SessionData sessionData;

  PostMenuArgs(this.postID, this.hash, this.currentProgramID,
      this.buttonPrograms, this.programs, this.sessionData);
}

//TODO: Buttons rework and fix
class EditPostMenu extends StatefulWidget {
  EditPostMenu({Key key}) : super(key: key);

  @override
  _EditPostMenuState createState() => _EditPostMenuState();
}

class _EditPostMenuState extends State<EditPostMenu> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);
  bool _firstLoad = true;
  Timer _updateBalanceTimer;
  int _serviceBalance = 0;
  int _balance = 0;
  int _currentProgram = -1;
  final int _maxButtons = 20;

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    if (_updateBalanceTimer != null && _updateBalanceTimer.isActive)
      _updateBalanceTimer.cancel();
    super.dispose();
  }

  List<bool> _checkboxList;
  Map<int, String> _buttonNames = Map();

  void _getBalance(SessionData sessionData, int postID) async {
    try {
      var res1 = await sessionData.client.status();
      _currentProgram = res1.stations
          .where((element) => element.id == postID)
          .last
          .currentProgram;
      _balance = res1.stations
          .where((element) => element.id == postID)
          .last
          .currentBalance;
      _currentProgram = _currentProgram ?? -1;
      var args = StationReportCurrentMoneyArgs();
      args.id = postID;
      var res = await sessionData.client.stationReportCurrentMoney(args);
      _serviceBalance = res.moneyReport.service;
      if (!mounted) {
        return;
      }
    } on ApiException catch (e) {
      if (e.code != 404) {
        print(
            "Exception when calling DefaultApi->/station-report-current-money: $e\n");
        showInfoSnackBar(_scaffoldKey, _isSnackBarActive, "Произошла ошибка при запросе к api", Colors.red);
      }
    } catch (e) {
      if (!(e is ApiException)) {
        print("Other Exception: $e\n");
      }
    }
    setState(() {});
  }

  void _addServiceMoney(PostMenuArgs postMenuArgs) async {
    try {
      var args = AddServiceAmountArgs();
      args.hash = postMenuArgs.hash;
      args.amount = 10;
      var res = await postMenuArgs.sessionData.client.addServiceAmount(args);
    } catch (e) {
      print("Exception when calling DefaultApi->/add-service-amount: $e\n");
      showInfoSnackBar(_scaffoldKey, _isSnackBarActive, "Произошла ошибка при запросе к api", Colors.red);
    }
  }

  //TODO: add preflight parameter
  void _programButtonListener(index, PostMenuArgs postMenuArgs) async {
    if (index != _currentProgram) {
      try {
        var args = RunProgramArgs();
        args.hash = postMenuArgs.hash;
        // args.programID = postMenuArgs.programs[index].id ?? 1;
        args.preflight = false; //TODO: use preflight trigger
        await postMenuArgs.sessionData.client.runProgram(args);
        setState(() {
          if (_currentProgram != -1)
            _checkboxList[_currentProgram ?? 1] = false;
          _checkboxList[index] = true;
          _currentProgram = index;
        });
      } catch (e) {
        print(
            "Exception when calling DefaultApi->runProgram in EditPostMenu: $e\n");
        showInfoSnackBar(_scaffoldKey, _isSnackBarActive, "Произошла ошибка при запросе к api", Colors.red);
      }
    } else {
      try {
        var args = RunProgramArgs();
        args.hash = postMenuArgs.hash;
        args.programID = -1;
        args.preflight = false; //TODO: use preflight trigger
        await postMenuArgs.sessionData.client.runProgram(args);
        setState(() {
          if (_currentProgram != -1)
            _checkboxList[_currentProgram ?? 1] = false;
          _currentProgram = -1;
        });
      } catch (e) {
        print(
            "Exception when calling DefaultApi->runProgram in EditPostMenu: $e\n");
        showInfoSnackBar(_scaffoldKey, _isSnackBarActive, "Произошла ошибка при запросе к api", Colors.red);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final PostMenuArgs postMenuArgs = ModalRoute.of(context).settings.arguments;

    final AppBar appBar = AppBar(
      title:
          Text("Пост: ${postMenuArgs.postID} | Баланс: ${_balance ?? 0} руб"),
    );

    if (_firstLoad) {
      _updateBalanceTimer = new Timer.periodic(Duration(seconds: 1), (timer) {
        _getBalance(postMenuArgs.sessionData, postMenuArgs.postID);
      });

      if (postMenuArgs.buttonPrograms != null &&
          postMenuArgs.buttonPrograms.length > 0) {
        _buttonNames = Map();
        for (int i = 0; i < postMenuArgs.buttonPrograms.length; i++) {
          try {
            _buttonNames[postMenuArgs.buttonPrograms[i].buttonID - 1] =
                postMenuArgs
                        .programs
                        .where((element) =>
                            element.id ==
                            postMenuArgs.buttonPrograms[i].programID)
                        .first
                        .name ??
                    "NOT FOUND";
          } catch (e) {
            _buttonNames[i] = "NOT FOUND";
          }
        }
        _checkboxList = List.filled(_buttonNames.length, false);
        _currentProgram = postMenuArgs.programs.indexWhere(
          (element) =>
              (element.id ?? -1) == (postMenuArgs.currentProgramID ?? -1),
        );
        if (_currentProgram != -1) _checkboxList[_currentProgram] = true;
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
        Navigator.pop(context, _currentProgram);
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: appBar,
        body: OrientationBuilder(
          builder: (context, orientation) {
            return new SizedBox(
              height: screenH - appBar.preferredSize.height,
              width: screenW,
              child: _getMenu(screenH > screenW, screenW, postMenuArgs),
            );
          },
        ),
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
        ]),
      );
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
            width: isPortrait
                ? screenW / 2 - 20
                : ((postMenuArgs.buttonPrograms?.length ?? 0) > 0
                    ? screenW / 3 - 20
                    : screenW - 100),
            child: DecoratedBox(
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Text("$_serviceBalance"),
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
                  ),
                ),
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
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Инакссировать?"),
                    content: Text("Вы уверены?"),
                    actionsPadding: EdgeInsets.all(10),
                    actions: [
                      RaisedButton(
                        color: Colors.lightGreen,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        onPressed: () async {
                          try {
                            var args = SaveCollectionArgs();
                            args.id = postMenuArgs.postID;
                            var res = await postMenuArgs.sessionData.client
                                .saveCollection(args);
                          } on ApiException catch (e) {
                            if (e.code == 401) {
                              print(
                                  "Exception when calling DefaultApi->/save-collection: $e\n");
                              showInfoSnackBar(_scaffoldKey, _isSnackBarActive, "Нет доступа", Colors.red);
                            } else{
                              showInfoSnackBar(_scaffoldKey, _isSnackBarActive,  "Произошла ошибка при запросе к api", Colors.red);
                            }
                          } catch (e) {
                            if (!(e is ApiException)) {
                              print("Other Exception: $e\n");
                            }
                          }
                          showInfoSnackBar(_scaffoldKey, _isSnackBarActive, "Пост проинкассирован", Colors.green);
                          Navigator.pop(context);
                        },
                        child: Text("Да"),
                      ),
                      RaisedButton(
                        color: Colors.white,
                        textColor: Colors.black,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Нет"),
                      )
                    ],
                  ),
                );
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
                  var args = OpenStationArgs();
                  args.stationID = postMenuArgs.postID;
                  var res = postMenuArgs.sessionData.client.openStation(args);
                } catch (e) {
                  print(
                      "Exception when calling DefaultApi->/open-station: $e\n");
                  showInfoSnackBar(_scaffoldKey, _isSnackBarActive, "Произошла ошибка при запросе к api", Colors.red);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _getButtonsColumn(
      bool isPortrait, double screenW, PostMenuArgs postMenuArgs) {
    return new Column(
      children: List.generate(_maxButtons, (index) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: SizedBox(
            height: 50,
            width: isPortrait ? screenW / 2 - 20 : screenW / 3 - 20,
            child: _getListButton(index, postMenuArgs),
          ),
        );
      }),
    );
  }

  Widget _getCheckBoxColumn(
      bool isPortrait, double screenW, PostMenuArgs postMenuArgs) {
    return new Column(
      children: List.generate(_maxButtons, (index) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: SizedBox(
            height: 50,
            width: isPortrait ? screenW / 2 - 20 : screenW / 3 - 20,
            child: _getCheckBox(index, postMenuArgs),
          ),
        );
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
        //_programButtonListener(index, postMenuArgs);
      },
    );
  }

  Widget _getListButton(int index, PostMenuArgs postMenuArgs) {
    return new RaisedButton(
      color: Colors.white10,
      textColor: Colors.white,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      splashColor: Colors.lightGreenAccent,
      onPressed: () async {
        //_programButtonListener(index, postMenuArgs);
      },
      child: Text(
        _buttonNames[index] ?? " ",
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}
