import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import "client/api.dart";

class SettingsMenuPost extends StatefulWidget {
  @override
  _SettingsMenuPostState createState() => _SettingsMenuPostState();
}

class SettingsMenuPostArgs {
  final int stationID;
  final SessionData sessionData;
  final List<String> availableHashes;

  SettingsMenuPostArgs(this.stationID, this.availableHashes, this.sessionData);
}

class _SettingsMenuPostState extends State<SettingsMenuPost> {
  _SettingsMenuPostState() : super();
  bool _firstLoad = true;
  List<String> _readerValues = ["NOT_USED", "VENDOTEK", "PAYMENT_WORLD"];
  String _dropDownCardReader = "NOT_USED";

  List<String> _dropDownPrograms = List.filled(7, "------------");
  List<String> _programIDs = ["------------"];
  List<String> _programNames = ["------------"];
  List<TextEditingController> _inputControllers;

  void initState() {
    super.initState();
    //0-1 CardReader inputs
    //2-4 Post inputs
    _inputControllers = List.generate(5, (index) {
      var controller = new TextEditingController();
      switch (index) {
        default:
          break;
      }
      return controller;
    });
  }

  void dispose() {
    for (var controller in _inputControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _getPost(SettingsMenuPostArgs settingsMenuPostArgs) async {
    try {
      var args = StationArgs();
      args.id = settingsMenuPostArgs.stationID;

      var res = await settingsMenuPostArgs.sessionData.client.station(args);
      if (!mounted) {
        return;
      }
      _inputControllers[2].text = res.name ?? "";
      _inputControllers[3].text = res.hash ?? "";
      _inputControllers[4].text = res.preflightSec ?? "";
    } catch (e) {
      print("Exception when calling DefaultApi->/station: $e\n");
    }
  }

  void _savePost(
      SettingsMenuPostArgs settingsMenuPostArgs, BuildContext context) async {
    try {
      var args = StationConfig();
      args.id = settingsMenuPostArgs.stationID;
      args.name = _inputControllers[2].value.text ?? "";
      args.hash = _inputControllers[3].value.text ?? "";
      args.preflightSec = int.tryParse(_inputControllers[4].value.text) ?? 0;

      var res = await settingsMenuPostArgs.sessionData.client.setStation(args);
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Настройки станции сохранены")));
    } catch (e) {
      print("Exception when calling DefaultApi->/set-station: $e\n");
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Произошла ошибка при сохранении")));
    }
  }

  void _getCardReader(SettingsMenuPostArgs settingsMenuPostArgs) async {
    try {
      var args = CardReaderConfigArgs();
      args.stationID = settingsMenuPostArgs.stationID;
      var res =
          await settingsMenuPostArgs.sessionData.client.cardReaderConfig(args);
      if (!mounted) {
        return;
      }
      _dropDownCardReader = res.cardReaderType ?? _dropDownCardReader;
      _inputControllers[0].text = res.host ?? _inputControllers[0].value.text;
      _inputControllers[1].text = res.port ?? _inputControllers[1].value.text;

      setState(() {});
    } catch (e) {
      print(
          "Exception when calling DefaultApi->/card-reader-config-by-hash: $e\n");
    }
  }

  void _saveCardReader(
      SettingsMenuPostArgs settingsMenuPostArgs, BuildContext context) async {
    try {
      var args = CardReaderConfig();
      args.stationID = settingsMenuPostArgs.stationID;
      args.cardReaderType = _dropDownCardReader;
      args.host = _inputControllers[0].value.text.isNotEmpty
          ? _inputControllers[0].value.text
          : " ";
      args.port = _inputControllers[1].value.text.isNotEmpty
          ? _inputControllers[1].value.text
          : " ";
      var res = await settingsMenuPostArgs.sessionData.client
          .setCardReaderConfig(args);
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Настройки кардридера сохранены")));
    } catch (e) {
      print("Exception when calling DefaultApi->/set-card-reader-config: $e\n");
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Произошла ошибка при сохранении")));
    }
  }

  void _getButtons(SettingsMenuPostArgs settingsMenuPostArgs) async {
    try {
      var args = ProgramsArgs();
      var res = await settingsMenuPostArgs.sessionData.client.programs(args);

      if (!mounted) {
        return;
      }
      _programIDs = ["------------"];
      _programNames = ["------------"];
      for (int i = 0; i < res.length; i++) {
        _programIDs.add(res[i].id.toString());
        _programNames.add(res[i].name);
      }
    } catch (e) {
      print("Exception when calling DefaultApi->/programs: $e\n");
    }

    try {
      var args = StationButtonArgs();
      args.stationID = settingsMenuPostArgs.stationID;
      var res =
          await settingsMenuPostArgs.sessionData.client.stationButton(args);

      if (!mounted) {
        return;
      }
      for (int i = 0; i < res.buttons.length; i++) {
        // TODO button with known programs should be set here, button = programid and buttonid
        _dropDownPrograms[res.buttons[i].buttonID - 1] =
            res.buttons[i].programID.toString();
      }

      setState(() {});
    } catch (e) {
      print("Exception when calling DefaultApi->/station-button: $e\n");
    }
  }

  void _saveButtons(
      SettingsMenuPostArgs settingsMenuPostArgs, BuildContext context) async {
    try {
      var args = SetStationButtonsArgs();
      args.stationID = settingsMenuPostArgs.stationID;
      List<InlineResponse2001Buttons> buttons = List();
      for (int i = 0; i < 6; i++) {
        if (_dropDownPrograms[i] != _programIDs[0]) {
          var value = InlineResponse2001Buttons();
          value.programID = int.parse(_dropDownPrograms[i]);
          value.buttonID = i + 1;
          buttons.add(value);
        }
      }
      args.buttons = buttons;
      var res =
          await settingsMenuPostArgs.sessionData.client.setStationButton(args);
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Настройки кнопок сохранены")));
    } catch (e) {
      print("Exception when calling DefaultApi->/set-station-button: $e\n");
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Произошла ошибка при сохранении")));
    }
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text("Пост"),
    );
    SettingsMenuPostArgs settingsMenuPostArgs =
        ModalRoute.of(context).settings.arguments;
    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;

    if (_firstLoad) {
      _getPost(settingsMenuPostArgs);
      _getCardReader(settingsMenuPostArgs);
      _getButtons(settingsMenuPostArgs);
      _firstLoad = false;
    }

    var availableHashes = settingsMenuPostArgs.availableHashes;

    return Scaffold(
      appBar: appBar,
      body: OrientationBuilder(
        builder: (context, orientation) {
          return new SizedBox(
            height: screenH - appBar.preferredSize.height,
            child: ListView(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                            height: 75,
                            width: screenW / 3,
                            child: Center(
                              child: Text("ID",
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center),
                            )),
                        SizedBox(
                          height: 75,
                          width: screenW / 3 * 2,
                          child: Center(
                            child: Text("${settingsMenuPostArgs.stationID}"),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                            height: 75,
                            width: screenW / 3,
                            child: Center(
                              child: Text("Имя",
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center),
                            )),
                        SizedBox(
                            height: 75,
                            width: screenW / 3 * 2,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                controller: _inputControllers[2],
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder()),
                              ),
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                            height: 75,
                            width: screenW / 3,
                            child: Center(
                              child: Text("Хэш",
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center),
                            )),
                        SizedBox(
                            height: 75,
                            width: screenW / 3 * 2,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: DropdownButton(
                                value: _inputControllers[3].text,
                                isExpanded: true,
                                items:
                                List.generate(availableHashes.length, (index) {
                                  return DropdownMenuItem(
                                      value: availableHashes[index],
                                      child: Text(
                                        "${availableHashes[index]}",
                                        textAlign: TextAlign.end,
                                      ));
                                }),
                                onChanged: (newValue) {
                                  _inputControllers[3].text = newValue;
                                  setState(() {});
                                }),
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                            height: 75,
                            width: screenW / 3,
                            child: Center(
                              child: Text("Прокачка",
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center),
                            )),
                        SizedBox(
                            height: 75,
                            width: screenW / 3 * 2,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                controller: _inputControllers[4],
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9_]"))
                                ],
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder()),
                              ),
                            ))
                      ],
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.center,
                      spacing: 25,
                      children: [
                        SizedBox(
                          height: 50,
                          width: screenW / 3,
                          child: RaisedButton(
                            onPressed: () {
                              _savePost(settingsMenuPostArgs, context);
                            },
                            child: Text("Сохранить настройки"),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: screenW / 3,
                          child: RaisedButton(
                            onPressed: () {
                              _getPost(settingsMenuPostArgs);
                            },
                            child: Text("Отменить"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: Colors.lightGreen,
                  thickness: 3,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                            height: 75,
                            width: screenW / 3,
                            child: Center(
                              child: Text("Кардридер",
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center),
                            )),
                        SizedBox(
                          height: 75,
                          width: screenW / 3 * 2,
                          child: DropdownButton(
                              value: _dropDownCardReader,
                              isExpanded: true,
                              items:
                                  List.generate(_readerValues.length, (index) {
                                return DropdownMenuItem(
                                    value: _readerValues[index],
                                    child: Text(
                                      "${_readerValues[index]}",
                                      textAlign: TextAlign.end,
                                    ));
                              }),
                              onChanged: (newValue) {
                                _dropDownCardReader = newValue;
                                setState(() {});
                              }),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                            height: 75,
                            width: screenW / 3,
                            child: Center(
                              child: Text("Хост",
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center),
                            )),
                        SizedBox(
                            height: 75,
                            width: screenW / 3 * 2,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                controller: _inputControllers[0],
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder()),
                              ),
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                            height: 75,
                            width: screenW / 3,
                            child: Center(
                              child: Text("Порт",
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center),
                            )),
                        SizedBox(
                            height: 75,
                            width: screenW / 3 * 2,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                controller: _inputControllers[1],
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder()),
                              ),
                            ))
                      ],
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.center,
                      spacing: 25,
                      children: [
                        SizedBox(
                          height: 50,
                          width: screenW / 3,
                          child: RaisedButton(
                            onPressed: () {
                              _saveCardReader(settingsMenuPostArgs, context);
                            },
                            child: Text("Сохранить кардридер"),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: screenW / 3,
                          child: RaisedButton(
                            onPressed: () {
                              _getCardReader(settingsMenuPostArgs);
                            },
                            child: Text("Отменить"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: Colors.lightGreen,
                  thickness: 3,
                ),
                Column(
                  children: List.generate(7, (index) {
                    return Row(
                      children: [
                        SizedBox(
                            height: 75,
                            width: screenW / 3,
                            child: Center(
                              child: Text("Кнопка ${index + 1}",
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center),
                            )),
                        SizedBox(
                          height: 75,
                          width: screenW / 3 * 2,
                          child: DropdownButton(
                              value: _dropDownPrograms[index],
                              isExpanded: true,
                              items:
                                  List.generate(_programIDs.length, (index) {
                                return DropdownMenuItem(
                                    value: _programIDs[index],
                                    child: Text(
                                      "${_programNames[index]}",
                                      textAlign: TextAlign.end,
                                    ));
                              }),
                              onChanged: (newValue) {
                                _dropDownPrograms[index] = newValue;
                                setState(() {});
                              }),
                        )
                      ],
                    );
                  }),
                ),
                Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  spacing: 25,
                  children: [
                    SizedBox(
                      height: 50,
                      width: screenW / 3,
                      child: RaisedButton(
                        onPressed: () {
                          _saveButtons(settingsMenuPostArgs, context);
                        },
                        child: Text("Сохранить кнопки"),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: screenW / 3,
                      child: RaisedButton(
                        onPressed: () {
                          _getButtons(settingsMenuPostArgs);
                        },
                        child: Text("Отменить"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
