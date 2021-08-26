import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';
import 'dart:async';
import 'package:mobile_wash_control/mobile/IncassationHistory.dart';

class PostMenuArgs {
  final int postID;
  final String ip;
  final String hash;
  final int currentProgramID;
  final SessionData sessionData;

  PostMenuArgs(this.postID, this.ip, this.hash, this.currentProgramID, this.sessionData);
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
  int _incassBalance = 0;
  int _balance = 0;
  int _currentProgram = -1;
  final int _maxButtons = 20;

  List<ResponseStationButtonButtons> _buttons = List();
  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    if (_updateBalanceTimer != null && _updateBalanceTimer.isActive) _updateBalanceTimer.cancel();
    super.dispose();
  }

  List<bool> _checkboxList = List();
  Map<int, String> _buttonNames = Map();

  void _loadButtons(PostMenuArgs postMenuArgs) async {
    try {
      var args = ArgStationButton(stationID: postMenuArgs.postID);
      var res = await postMenuArgs.sessionData.client.stationButton(args);
      _buttons = res.buttons;
      var programs = await postMenuArgs.sessionData.client.programs(ArgPrograms());
      if (!mounted) {
        return;
      }
      _unpackNames(programs);
    } catch (e) {
      print("Exception when calling DefaultApi->/station-button: $e\n");
      showInfoSnackBar(_scaffoldKey, _isSnackBarActive, "Произошла ошибка при запросе к api", Colors.red);
    }
  }

  void _getBalance(PostMenuArgs postMenuArgs) async {
    final SessionData sessionData = postMenuArgs.sessionData;
    final int postID = postMenuArgs.postID;
    _updateBalanceTimer.cancel();
    try {
      var res1 = await sessionData.client.status();
      StationStatus stationStatus = res1.stations.firstWhere((element) => element.id == postID, orElse: () {
        return null;
      });
      _currentProgram = stationStatus?.currentProgram ?? -1;
      _balance = stationStatus?.currentBalance ?? 0;

      var args = ArgStationReportCurrentMoney(
        id: postID,
      );
      var res = await sessionData.client.stationReportCurrentMoney(args);
      //_balance = (res.moneyReport?.banknotes ?? 0)+(res.moneyReport?.coins ?? 0)+(res.moneyReport?.electronical ?? 0);
      _incassBalance = (res.moneyReport?.banknotes ?? 0) + (res.moneyReport?.coins ?? 0);
      if (!mounted) {
        return;
      }
      _checkboxList = List.filled(_maxButtons, false);
      var checkboxID = 0;
      if (_buttons.where((element) => element.programID == _currentProgram).length != 0) {
        checkboxID = _buttons.firstWhere((element) => element.programID == _currentProgram).buttonID - 1 ?? -1;
      }
      if (checkboxID >= 0) {
        _checkboxList[checkboxID] = true;
      }
    } on ApiException catch (e) {
      if (e.code != 404) {
        print("Exception when calling DefaultApi->/station-report-current-money: $e\n");
        showInfoSnackBar(_scaffoldKey, _isSnackBarActive, "Произошла ошибка при запросе к api", Colors.red);
      }
    } catch (e) {
      if (!(e is ApiException)) {
        print("Other Exception: $e\n");
      }
    }
    _updateBalanceTimer = new Timer.periodic(Duration(seconds: 1), (timer) {
      _getBalance(postMenuArgs);
    });
    setState(() {});
  }

  void _unpackNames(List<Program> programs) {
    if ((_buttons?.length ?? 0) > 0) {
      _buttonNames = Map();
      for (int i = 0; i < _buttons.length; i++) {
        _buttonNames[_buttons[i].buttonID - 1] = programs.firstWhere((element) => element.id == _buttons[i].programID, orElse: () {
              return null;
            })?.name ??
            "NOT FOUND";
      }
    }
    setState(() {});
  }

  void _addServiceMoney(PostMenuArgs postMenuArgs) async {
    try {
      var args = ArgAddServiceAmount(
        hash: postMenuArgs.hash,
        amount: 10,
      );
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
        var args = ArgRunProgram(
          hash: postMenuArgs.hash,
          preflight: false, //TODO: use preflight trigger
        );
        await postMenuArgs.sessionData.client.runProgram(args);
        setState(() {
          if (_currentProgram != -1) _checkboxList[_currentProgram ?? 1] = false;
          _checkboxList[index] = true;
          _currentProgram = index;
        });
      } catch (e) {
        print("Exception when calling DefaultApi->runProgram in EditPostMenu: $e\n");
        showInfoSnackBar(_scaffoldKey, _isSnackBarActive, "Произошла ошибка при запросе к api", Colors.red);
      }
    } else {
      try {
        var args = ArgRunProgram(
          hash: postMenuArgs.hash,
          programID: -1,
          preflight: false, //TODO: use preflight trigger
        );
        await postMenuArgs.sessionData.client.runProgram(args);
        setState(() {
          if (_currentProgram != -1) _checkboxList[_currentProgram ?? 1] = false;
          _currentProgram = -1;
        });
      } catch (e) {
        print("Exception when calling DefaultApi->runProgram in EditPostMenu: $e\n");
        showInfoSnackBar(_scaffoldKey, _isSnackBarActive, "Произошла ошибка при запросе к api", Colors.red);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final PostMenuArgs postMenuArgs = ModalRoute.of(context).settings.arguments;

    final AppBar appBar = AppBar(
      title: Text("Пост: ${postMenuArgs.postID} | Инкасс: ${_incassBalance ?? 0} руб"),
    );

    if (_firstLoad) {
      _loadButtons(postMenuArgs);
      _updateBalanceTimer = new Timer.periodic(Duration(seconds: 1), (timer) {
        _getBalance(postMenuArgs);
      });

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
            children: [_getButtonsColumn(isPortrait, screenW, postMenuArgs), _getCheckBoxColumn(isPortrait, screenW, postMenuArgs)],
          )
        ],
      );
    } else {
      return new FittedBox(
        fit: BoxFit.fill,
        child: Row(children: [_getMainColumn(isPortrait, screenW, postMenuArgs), _getButtonsColumn(isPortrait, screenW, postMenuArgs), _getCheckBoxColumn(isPortrait, screenW, postMenuArgs)]),
      );
    }
  }

  Widget _getMainColumn(bool isPortrait, double screenW, PostMenuArgs postMenuArgs) {
    return new Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: SizedBox(
            height: 50,
            width: isPortrait ? screenW / 2 - 20 : ((_buttons?.length ?? 0) > 0 ? screenW / 3 - 20 : screenW - 100),
            child: DecoratedBox(
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Text("${_balance}"),
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
                            var args = ArgSaveCollection(
                              id: postMenuArgs.postID,
                            );
                            var res = await postMenuArgs.sessionData.client.saveCollection(args);
                          } on ApiException catch (e) {
                            if (e.code == 401) {
                              print("Exception when calling DefaultApi->/save-collection: $e\n");
                              showInfoSnackBar(_scaffoldKey, _isSnackBarActive, "Нет доступа", Colors.red);
                            } else {
                              showInfoSnackBar(_scaffoldKey, _isSnackBarActive, "Произошла ошибка при запросе к api", Colors.red);
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
                  var args = ArgOpenStation(
                    stationID: postMenuArgs.postID,
                  );
                  var res = postMenuArgs.sessionData.client.openStation(args);
                } catch (e) {
                  print("Exception when calling DefaultApi->/open-station: $e\n");
                  showInfoSnackBar(_scaffoldKey, _isSnackBarActive, "Произошла ошибка при запросе к api", Colors.red);
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
                "История инкассаций",
                style: TextStyle(fontSize: 15),
              ),
              onPressed: () {
                var args = IncassationHistoryArgs(postMenuArgs.postID, postMenuArgs.sessionData);
                if (_updateBalanceTimer.isActive) {
                  _updateBalanceTimer.cancel();
                }
                Navigator.pushNamed(context, "/mobile/incassation", arguments: args).then((value) {
                  _updateBalanceTimer = new Timer.periodic(Duration(seconds: 1), (timer) {
                    _getBalance(postMenuArgs);
                  });
                  setState(() {});
                });

                setState(() {});
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5),
          child: SizedBox(
              height: 20,
              width: isPortrait ? screenW / 2 - 20 : screenW / 3 - 20,
              child: Center(
                child: Text(
                  "IP поста: ${postMenuArgs.ip}",
                  style: TextStyle(fontSize: 14),
                ),
              )),
        ),
      ],
    );
  }

  Widget _getButtonsColumn(bool isPortrait, double screenW, PostMenuArgs postMenuArgs) {
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

  Widget _getCheckBoxColumn(bool isPortrait, double screenW, PostMenuArgs postMenuArgs) {
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
        "${_buttonNames[index] ?? "${index + 1}"}",
        style: TextStyle(fontSize: 15),
        textAlign: TextAlign.left,
      ),
    );
  }
}
