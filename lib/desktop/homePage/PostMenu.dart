import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/PagesUtils/PagesArgs.dart';
import 'package:mobile_wash_control/PagesUtils/ServerRequests/HomepageRequests.dart';
import 'package:mobile_wash_control/client/api.dart';

class PostMenu extends StatefulWidget {
  @override
  _PostMenuState createState() => _PostMenuState();
}

class _PostMenuState extends State<PostMenu> {
//
// UI VARIABLES
//
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);
  bool _firstLoad = true;
  Timer _updateBalanceTimer;
  bool _canOpenStation = true;
  bool _showButtons = false;
  bool _showIncassation = false;
  bool _incassationUpdating = false;
//
// PAGE VARIABLES
//
  final int _maxButtons = 20;
  PostMenuInfo _postMenuInfo = PostMenuInfo(0, 0, 0, List.filled(1, false));

  List<ResponseStationButtonButtons> _buttons = List();
  Map<int, String> _buttonNames = Map();
  IncassationInfo _postIncassationInfo;
  DateTime _startDate = DateTime.now().add(
    new Duration(days: -31),
  );
  DateTime _endDate = DateTime.now().add(
    new Duration(days: 1, seconds: -1),
  );
  @override
  void dispose() {
    _updateBalanceTimer.cancel();
    super.dispose();
  }

  void _getBalance(PostMenuArgs postMenuArgs) async {
    _updateBalanceTimer.cancel();
    _postMenuInfo = await GetPostInfo(postMenuArgs, _buttons);
    _updateBalanceTimer = new Timer.periodic(Duration(seconds: 1), (timer) {
      _getBalance(postMenuArgs);
    });
    if (mounted) {
      setState(() {});
    }
  }

  void _getButtons(PostMenuArgs postMenuArgs) async {
    try {
      var args = ArgStationButton(
        stationID: postMenuArgs.postID,
      );
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

  Future<Null> _selectStartDate(BuildContext context) async {
    {
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _startDate,
        firstDate: DateTime(2021),
        lastDate: DateTime.now(),
      );

      if (!mounted) {
        return;
      }
      setState(() {
        if (picked != null && picked != _startDate) {
          _startDate = picked;
        }
      });
    }
  }

  Future<Null> _selectEndDate(BuildContext context) async {
    {
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _endDate,
        firstDate: DateTime(2021),
        lastDate: DateTime.now().add(
          new Duration(days: 1),
        ),
      );

      if (!mounted) {
        return;
      }
      setState(() {
        if (picked != null && picked != _endDate) {
          _endDate = picked;
          _endDate = _endDate.add(
            Duration(days: 1, seconds: -1),
          );
          print("NEW SELECTED: $_endDate");
        }
      });
    }
  }

  void _changeServiceValue({int value = 10}) {
    GlobalData.AddServiceValue += value;
    if (GlobalData.AddServiceValue < 0) {
      GlobalData.AddServiceValue = 0;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final PostMenuArgs postMenuArgs = ModalRoute.of(context).settings.arguments;

    if (_firstLoad) {
      _getButtons(postMenuArgs);
      _updateBalanceTimer = new Timer.periodic(Duration(seconds: 1), (timer) {
        _getBalance(postMenuArgs);
      });

      _firstLoad = false;
    }

    var screenW = MediaQuery.of(context).size.width;
    var screenH = MediaQuery.of(context).size.height;

    AppBar appbar = AppBar(
      title: Text("Пост: ${postMenuArgs.postID} | Инкасс: ${_postMenuInfo.incassBalance} руб"),
    );
    var width = screenW;
    var height = screenH - appbar.preferredSize.height;

    return Scaffold(
      appBar: appbar,
      body: Center(
        child: SizedBox(
          height: height,
          width: width,
          child: Row(
            children: [
              SizedBox(
                height: height,
                width: width / 3,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(blurRadius: 4, color: Colors.black),
                    ],
                  ),
                  child: GetMainCollumn(width / 3, height, context, postMenuArgs),
                ),
              ),
              SizedBox(
                height: height,
                width: width / 3,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(blurRadius: 4, color: Colors.black),
                    ],
                  ),
                  child: GetButtonsCollumn(width / 3, height),
                ),
              ),
              SizedBox(
                height: height,
                width: width / 3,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(blurRadius: 4, color: Colors.black),
                    ],
                  ),
                  child: GetIncassationCollumn(width / 3, height, postMenuArgs),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget GetMainCollumn(double width, double height, BuildContext context, PostMenuArgs postMenuArgs) {
    return SizedBox(
      height: height,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 50,
            width: width / 2,
            child: DecoratedBox(
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Text("${_postMenuInfo.balance}"),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(color: Colors.lightGreen),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.remove_circle_outline),
                color: Colors.lightGreen,
                splashColor: Colors.lightGreenAccent,
                onPressed: () {
                  _changeServiceValue(value: -10);
                },
              ),
              Container(
                child: Text(
                  "${GlobalData.AddServiceValue} руб",
                  style: TextStyle(fontSize: 36),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add_circle_outline),
                color: Colors.lightGreen,
                splashColor: Colors.lightGreenAccent,
                onPressed: () {
                  _changeServiceValue(value: 10);
                },
              ),
            ],
          ),
          Container(
            height: 50,
            width: width / 2,
            child: RaisedButton(
              color: Colors.lightGreen,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.lightGreenAccent,
              child: Text(
                "Отправить",
                style: TextStyle(fontSize: 15),
              ),
              onPressed: () {
                AddServiceMoney(postMenuArgs);
              },
            ),
          ),
          SizedBox(
            height: 50,
            width: width / 2,
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
                DoPostIncassation(context, postMenuArgs);
              },
            ),
          ),
          SizedBox(
            height: 50,
            width: width / 2,
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
              onPressed: _canOpenStation
                  ? () {
                      OpenStation(postMenuArgs);
                    }
                  : null,
            ),
          ),
          Text(
            "IP поста: ${postMenuArgs.ip}",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget GetButtonsCollumn(double width, double height) {
    double ListSize = height - 50.0;
    return SizedBox(
      height: height,
      width: width,
      child: Column(
        children: [
          SizedBox(
            width: width,
            height: 50,
            child: RaisedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Список кнопок:",
                    style: TextStyle(fontSize: 16),
                  ),
                  Icon(_showButtons ? Icons.expand_less_outlined : Icons.expand_more_outlined)
                ],
              ),
              onPressed: () {
                _showButtons = !_showButtons;
              },
            ),
          ),
          SizedBox(
            height: ListSize,
            width: width,
            child: _showButtons
                ? ListView.builder(
                    itemCount: _maxButtons,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 50,
                        width: width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: width / 2 - 20,
                              height: 45,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.lightGreen,
                                ),
                                child: Center(
                                  child: Text(
                                    "${_buttonNames[index] ?? "${index + 1}"}",
                                    style: TextStyle(fontSize: 15),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width / 2 - 20,
                              height: 50,
                              child: CheckboxListTile(
                                controlAffinity: ListTileControlAffinity.trailing,
                                title: Text(
                                  'Активный',
                                  style: TextStyle(fontSize: 15),
                                ),
                                value: index < _postMenuInfo.activePrograms.length ? _postMenuInfo.activePrograms[index] : false,
                                onChanged: (newValue) async {
                                  //_programButtonListener(index, postMenuArgs);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    })
                : SizedBox(),
          )
        ],
      ),
    );
  }

  Widget GetIncassationCollumn(double width, double height, PostMenuArgs postMenuArgs) {
    double listSize = height - 200.0;
    return SizedBox(
      height: height,
      width: width,
      child: Column(
        children: [
          SizedBox(
            width: width,
            height: 50,
            child: RaisedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "История инкассаций:",
                    style: TextStyle(fontSize: 16),
                  ),
                  Icon(_showIncassation ? Icons.expand_less_outlined : Icons.expand_more_outlined)
                ],
              ),
              onPressed: () {
                _showIncassation = !_showIncassation;
              },
            ),
          ),
          _showIncassation
              ? SizedBox(
                  width: width,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "C ",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: width / 3,
                        height: 45,
                        child: RaisedButton(
                          onPressed: () => _selectStartDate(context),
                          child: Text("${_startDate.day}.${_startDate.month}.${_startDate.year}"),
                        ),
                      ),
                      Text(
                        " по ",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: width / 3,
                        height: 45,
                        child: RaisedButton(
                          onPressed: () => _selectEndDate(context),
                          child: Text("${_endDate.day}.${_endDate.month}.${_endDate.year}"),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.update,
                          color: _incassationUpdating ? Colors.yellow : Colors.green,
                        ),
                        onPressed: () async {
                          if (!_incassationUpdating) {
                            _incassationUpdating = true;
                            _postIncassationInfo = await GetIncassation(postMenuArgs, _startDate, _endDate);
                            _incassationUpdating = false;
                            setState(() {});
                          }
                        },
                      ),
                    ],
                  ),
                )
              : SizedBox(),
          _showIncassation
              ? SizedBox(
                  width: width,
                  height: 50,
                  child: Row(
                    children: [
                      SizedBox(
                        width: width / 3,
                        height: 50,
                        child: Center(
                          child: (Text("Дата/Время")),
                        ),
                      ),
                      SizedBox(
                        width: width / 3,
                        height: 50,
                        child: Center(
                          child: (Text("Нал.")),
                        ),
                      ),
                      SizedBox(
                        width: width / 3,
                        height: 50,
                        child: Center(
                          child: (Text("Безнал.")),
                        ),
                      )
                    ],
                  ),
                )
              : SizedBox(),
          (_showIncassation && _postIncassationInfo != null)
              ? SizedBox(
                  width: width,
                  height: listSize,
                  child: ListView.builder(
                      itemCount: _postIncassationInfo.incassations.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: width,
                          height: 50,
                          child: Row(
                            children: [
                              SizedBox(
                                width: width / 3,
                                height: 50,
                                child: Center(
                                  child: Text(formatDateTime(DateTime.fromMillisecondsSinceEpoch(_postIncassationInfo.incassations[index].ctime * 1000))),
                                ),
                              ),
                              SizedBox(
                                width: width / 3,
                                height: 50,
                                child: Center(
                                  child: Text("${(_postIncassationInfo.incassations[index].banknotes ?? 0) + (_postIncassationInfo.incassations[index].coins ?? 0)}"),
                                ),
                              ),
                              SizedBox(
                                width: width / 3,
                                height: 50,
                                child: Center(
                                  child: (Text("${_postIncassationInfo.incassations[index].electronical ?? 0}")),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                )
              : SizedBox(),
          _showIncassation
              ? SizedBox(
                  width: width,
                  height: 50,
                  child: Row(
                    children: [
                      SizedBox(
                        width: width / 3,
                        height: 50,
                        child: Center(
                          child: (Text("Итого")),
                        ),
                      ),
                      SizedBox(
                        width: width / 3,
                        height: 50,
                        child: Center(
                          child: (Text("${_postIncassationInfo?.totalNal ?? 0}")),
                        ),
                      ),
                      SizedBox(
                        width: width / 3,
                        height: 50,
                        child: Center(
                          child: (Text("${_postIncassationInfo?.totalBeznal ?? 0}")),
                        ),
                      )
                    ],
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }

  void DoPostIncassation(BuildContext context, PostMenuArgs postMenuArgs) {
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
  }

  void OpenStation(PostMenuArgs postMenuArgs) async {
    _canOpenStation = false;
    try {
      var args = ArgOpenStation(
        stationID: postMenuArgs.postID,
      );
      var res = await postMenuArgs.sessionData.client.openStation(args);
    } catch (e) {
      print("Exception when calling DefaultApi->/open-station: $e\n");
      showInfoSnackBar(_scaffoldKey, _isSnackBarActive, "Произошла ошибка при запросе к api", Colors.red);
    }
    _canOpenStation = true;
  }

  String formatDateTime(DateTime datetime) {
    return "${datetime.year.toString()}-${datetime.month.toString().padLeft(2, '0')}-${datetime.day.toString().padLeft(2, '0')} ${datetime.hour.toString()}:${datetime.minute.toString()}:${datetime.second.toString()}";
  }
}
