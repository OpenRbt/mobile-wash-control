import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import "client/api.dart";

class SettingsMenuPost extends StatefulWidget {
  @override
  _SettingsMenuPostState createState() => _SettingsMenuPostState();
}

class SettingsMenuPostArgs {
  final int stationID;
  final SessionData sessionData;
  SettingsMenuPostArgs(this.stationID, this.sessionData);
}

class _SettingsMenuPostState extends State<SettingsMenuPost> {
  _SettingsMenuPostState() : super();
  bool _firstLoad = true;
  List<String> _readerValues = ["NOT_USED", "VENDOTEK", "PAYMENT_WORLD"];
  List<InlineResponse2001Buttons> _listButtons = List();
  String _dropDownCardReader = "NOT_USED";

  List<String> _dropDownPrograms = List.filled(7, "------------");
  List<String> _programValues = ["------------"];

  List<TextEditingController> _inputControllers;

  void initState() {
    super.initState();
    _inputControllers = List.generate(2, (index) {
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

  void _getCardReader(SettingsMenuPostArgs settingsMenuPostArgs) async {
    try {
      var args = Args18();
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

  void _saveCardReader(SettingsMenuPostArgs settingsMenuPostArgs) async {
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
    } catch (e) {
      print("Exception when calling DefaultApi->/set-card-reader-config: $e\n");
    }
  }

  void _getButtons(SettingsMenuPostArgs settingsMenuPostArgs) async {
    try{
      var args = Args14();
      args.stationID = settingsMenuPostArgs.stationID;
      var res = await settingsMenuPostArgs.sessionData.client.programs(args);

      _programValues = ["------------"];
      for(int i = 0 ; i < res.length; i++){
      _programValues.add(res[i].id.toString());
      }
    } catch (e){
      print("Exception when calling DefaultApi->/programs: $e\n");
    }

    try {
      var args = Args16();
      args.stationID = settingsMenuPostArgs.stationID;
      var res =
          await settingsMenuPostArgs.sessionData.client.stationButton(args);
      for (int i = 0; i < res.buttons.length; i++){
        _dropDownPrograms[res.buttons[i].buttonID-1] =res.buttons[i].programID.toString();
      }

      setState(() {});
    } catch (e) {
      print("Exception when calling DefaultApi->/station-button: $e\n");
    }
  }

  void _saveButtons(SettingsMenuPostArgs settingsMenuPostArgs) async {
    try{

      var args = Args17();
      args.stationID = settingsMenuPostArgs.stationID;
      List<InlineResponse2001Buttons> buttons = List();
      for (int i = 0 ; i < 6; i++){
        if (_dropDownPrograms[i] != _programValues[0]){
          var value = InlineResponse2001Buttons();
          value.programID = int.parse(_dropDownPrograms[i]);
          value.buttonID = i+1;
          buttons.add(value);
        }
      }
      args.buttons = buttons;

      var res = await settingsMenuPostArgs.sessionData.client.setStationButton(args);
    }catch(e){
      print("Exception when calling DefaultApi->/set-station-button: $e\n");
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
      _getCardReader(settingsMenuPostArgs);
      _getButtons(settingsMenuPostArgs);
      _firstLoad = false;
    }

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
                              _saveCardReader(settingsMenuPostArgs);
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
                              List.generate(_programValues.length, (index) {
                                return DropdownMenuItem(
                                    value: _programValues[index],
                                    child: Text(
                                      "${_programValues[index]}",
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
                          _saveButtons(settingsMenuPostArgs);
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
