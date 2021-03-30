import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';
import 'dart:async';

class DEditPostArgs {
  final int postID;
  final String hash;
  final int currentProgramID;
  final List<InlineResponse2001Buttons> buttonPrograms;
  final List<Program> programs;
  final SessionData sessionData;
  int serviceBalance;

  DEditPostArgs(
    this.postID,
    this.hash,
    this.currentProgramID,
    this.buttonPrograms,
    this.programs,
    this.serviceBalance,
    this.sessionData,
  );
}

class DEditPost extends StatelessWidget {
  final DEditPostArgs editData;
  BuildContext context;
  DEditPost({Key key, this.editData, this.context}) : super(key: key);

  bool _firstLoad = true;
  Timer _updateBalanceTimer;
  int _currentProgram = -1;

  final int _maxButtons = 8;

  List<bool> _checkboxList;
  Map<int, String> _buttonNames = Map();

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;
    if (true) {
      _firstLoad = true;
      //_serviceBalance = 0;
      //_balance = 0;
      _currentProgram = -1;
    }
    if (editData == null) {
      return Scaffold();
    }
    // final AppBar appBar = AppBar(
    //   title: Text("Пост: ${editData.postID} | Баланс: ${_balance ?? 0} руб"),
    // );

    if (_firstLoad) {
      _updateBalanceTimer = new Timer.periodic(Duration(seconds: 10), (timer) {
        //_getBalance(editData.sessionData, editData.postID);
      });

      if (editData.buttonPrograms != null &&
          editData.buttonPrograms.length > 0) {
        _buttonNames = Map();
        for (int i = 0; i < editData.buttonPrograms.length; i++) {
          try {
            _buttonNames[editData.buttonPrograms[i].buttonID - 1] = editData
                    .programs
                    .where((element) =>
                        element.id == editData.buttonPrograms[i].programID)
                    .first
                    .name ??
                "NOT FOUND";
          } catch (e) {
            _buttonNames[i] = "NOT FOUND";
          }
        }
        _checkboxList = List.filled(_buttonNames.length, false);
        _currentProgram = editData.programs.indexWhere(
          (element) => (element.id ?? -1) == (editData.currentProgramID ?? -1),
        );
        if (_currentProgram != -1) _checkboxList[_currentProgram] = true;
      }
      _firstLoad = false;
    }

    var screenW = MediaQuery.of(context).size.width;
    var screenH = MediaQuery.of(context).size.height;
    screenW = screenW > 1280 ? screenW / 4 * 3 : 960;
    screenW /= 2;
    return Scaffold(
      // appBar: appBar,
      body: OrientationBuilder(
        builder: (context, orientation) {
          return new SizedBox(
            height: screenH,
            width: screenW,
            child: _getMenu(screenH > screenW, screenW, sessionData),
          );
        },
      ),
    );
  }

  void dispose() {
    if (_updateBalanceTimer != null && _updateBalanceTimer.isActive)
      _updateBalanceTimer.cancel();
  }

  void _getBalance(SessionData sessionData, int postID) async {
    try {
      var res1 = await sessionData.client.status();
      _currentProgram = res1.stations
          .where((element) => element.id == postID)
          .last
          .currentProgram;
      // _balance = res1.stations
      //     .where((element) => element.id == postID)
      //     .last
      //     .currentBalance;
      _currentProgram = _currentProgram ?? -1;
      var args = StationReportCurrentMoneyArgs();
      args.id = postID;
      var res = await sessionData.client.stationReportCurrentMoney(args);
      //_serviceBalance = res.moneyReport.service;
    } on ApiException catch (e) {
      if (e.code != 404) {
        print(
            "Exception when calling DefaultApi->/station-report-current-money: $e\n");
        // showInfoSnackBar(scaffoldKey, isSnackBarActive,
        //     "Произошла ошибка при запросе к api", Colors.red);
      }
    } catch (e) {
      if (!(e is ApiException)) {
        print("Other Exception: $e\n");
      }
    }
  }

  void _addServiceMoney() async {
    try {
      var args = AddServiceAmountArgs();
      args.hash = editData.hash;
      args.amount = 10;
      var res = await editData.sessionData.client.addServiceAmount(args);
    } catch (e) {
      print("Exception when calling DefaultApi->/add-service-amount: $e\n");
      //  showInfoSnackBar(scaffoldKey, isSnackBarActive,
      //      "Произошла ошибка при запросе к api", Colors.red);
    }
  }

  Widget _getMenu(bool isPortrait, double screenW, SessionData sessionData) {
    return new ListView(
      children: [
        _getMainColumn(isPortrait, screenW, sessionData),
        Divider(
          height: 5,
          thickness: 5,
          color: Colors.lightGreen,
        ),
        Row(
          children: [
            _getButtonsColumn(isPortrait, screenW),
            _getCheckBoxColumn(
              isPortrait,
              screenW,
            )
          ],
        )
      ],
    );
  }

  Widget _getMainColumn(
      bool isPortrait, double screenW, SessionData sessionData) {
    return new Column(
      children: [
        SizedBox(
          height: 50,
          width: screenW / 2,
          child: Center(
            child: Text(
              "Пост: ${editData.postID}",
              style: TextStyle(fontSize: 32),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: SizedBox(
            height: 50,
            width: isPortrait
                ? screenW / 2 - 20
                : ((editData.buttonPrograms?.length ?? 0) > 0
                    ? screenW / 3 - 20
                    : screenW - 100),
            child: DecoratedBox(
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Text("${editData.serviceBalance ?? 0}"),
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
                width: 150,
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
                width: 50,
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
                        _addServiceMoney();
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
            width: screenW / 2 - 20,
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
                            args.id = editData.postID;
                            var res = await editData.sessionData.client
                                .saveCollection(args);
                          } on ApiException catch (e) {
                            if (e.code == 401) {
                              print(
                                  "Exception when calling DefaultApi->/save-collection: $e\n");
                              //  showInfoSnackBar(scaffoldKey, isSnackBarActive,
                              //      "Нет доступа", Colors.red);
                            } else {
                              //  showInfoSnackBar(
                              //      scaffoldKey,
                              //      isSnackBarActive,
                              //      "Произошла ошибка при запросе к api",
                              //      Colors.red);
                            }
                          } catch (e) {
                            if (!(e is ApiException)) {
                              print("Other Exception: $e\n");
                            }
                          }
                          //  showInfoSnackBar(scaffoldKey, isSnackBarActive,
                          //      "Пост проинкассирован", Colors.green);
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
            width: screenW / 2 - 20,
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
                  args.stationID = editData.postID;
                  var res = sessionData.client.openStation(args);
                } catch (e) {
                  print(
                      "Exception when calling DefaultApi->/open-station: $e\n");
                  //  showInfoSnackBar(scaffoldKey, isSnackBarActive,
                  //      "Произошла ошибка при запросе к api", Colors.red);
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
      children: List.generate(_maxButtons, (index) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: SizedBox(
            height: 50,
            width: screenW / 2 - 20,
            child: _getListButton(index),
          ),
        );
      }),
    );
  }

  Widget _getCheckBoxColumn(bool isPortrait, double screenW) {
    return new Column(
      children: List.generate(_maxButtons, (index) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: SizedBox(
            height: 50,
            width: screenW / 2 - 20,
            child: _getCheckBox(index),
          ),
        );
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
      value: index < _checkboxList.length ? _checkboxList[index] : false,
      onChanged: (newValue) async {
        //_programButtonListener(index);
      },
    );
  }

  Widget _getListButton(int index) {
    return RaisedButton(
      color: Colors.white10,
      textColor: Colors.white,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      splashColor: Colors.lightGreenAccent,
      onPressed: () async {
        //_programButtonListener(index);
      },
      child: Text(
        _buttonNames[index] ?? " ",
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}
