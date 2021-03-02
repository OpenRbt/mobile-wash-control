import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';

class ProgramMenuAdd extends StatefulWidget {
  @override
  _ProgramMenuAddState createState() => _ProgramMenuAddState();
}
//TODO: connect to api (Kronusol)
class _ProgramMenuAddState extends State<ProgramMenuAdd> {
  final int _maxPercent = 100;

  List<TextEditingController> _program;
  List<TextEditingController> _relays;
  List<TextEditingController> _relaysPreflight;

  void initState() {
    super.initState();
    _program = List.generate(2, (index) {
      var controller = new TextEditingController();
      switch (index) {
        default:
          break;
      }
      return controller;
    });
    _relays = List.generate(10, (index) {
      var controller = new TextEditingController();
      switch (index) {
        default:
          controller.addListener(() {
            final text = controller.text.toLowerCase();
            if (text.length > 0) {
              int value = int.tryParse(text);
              value = value ?? 0;
              value = value > _maxPercent ? _maxPercent : value;
              controller.value = controller.value.copyWith(
                  text: value.toString(),
                  selection: TextSelection(
                      baseOffset: value.toString().length,
                      extentOffset: value.toString().length),
                  composing: TextRange.empty);
            }
          });
          break;
      }
      return controller;
    });
    _relaysPreflight = List.generate(10, (index) {
      var controller = new TextEditingController();
      switch (index) {
        default:
          controller.addListener(() {
            final text = controller.text.toLowerCase();
            if (text.length > 0) {
              int value = int.tryParse(text);
              value = value ?? 0;
              value = value > _maxPercent ? _maxPercent : value;
              controller.value = controller.value.copyWith(
                  text: value.toString(),
                  selection: TextSelection(
                      baseOffset: value.toString().length,
                      extentOffset: value.toString().length),
                  composing: TextRange.empty);
            }
          });
          break;
      }
      return controller;
    });
  }

  void dispose() {
    for (var controller in _relays) {
      controller.dispose();
    }
    for (var controller in _relaysPreflight) {
      controller.dispose();
    }
    for (var controller in _program) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;
    final AppBar appBar = AppBar(
      title: Text("Новая программа"),
    );

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar,
      body: OrientationBuilder(
        builder: (context, orientation) {
          return SizedBox(
            height: screenH - appBar.preferredSize.height,
            width: screenW,
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
                              child: Text("Название",
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center),
                            )),
                        SizedBox(
                            height: 75,
                            width: screenW / 3 * 2,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                controller: _program[0],
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
                              child: Text("Цена",
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center),
                            )),
                        SizedBox(
                            height: 75,
                            width: screenW / 3 * 2,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                controller: _program[0],
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder()),
                              ),
                            ))
                      ],
                    ),
                    Center(
                        child: CheckboxListTile(
                      contentPadding: EdgeInsets.only(left: 5, right: 5),
                      title: Text(
                        'Прокачка',
                      ),
                      value: false,
                      onChanged: (newValue) {},
                    )),
                  ],
                ),
                Divider(
                  color: Colors.lightGreen,
                  thickness: 3,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 50,
                      width: screenW / 9 * 4,
                      child: Center(
                        child: Text("Реле",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: screenW / 9,
                    ),
                    SizedBox(
                      height: 50,
                      width: screenW / 9 * 4,
                      child: Center(
                        child: Text("Реле прокачки",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 50,
                      width: screenW / 9 * 2,
                      child: Center(
                        child: Text("ID",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: screenW / 9 * 2,
                      child: Center(
                        child: Text("%",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: screenW / 9,
                    ),
                    SizedBox(
                      height: 50,
                      width: screenW / 9 * 2,
                      child: Center(
                        child: Text("ID",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: screenW / 9 * 2,
                      child: Center(
                        child: Text("%",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center),
                      ),
                    )
                  ],
                ),
                Column(
                  children: List.generate(10, (index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: 50,
                            width: screenW / 9 * 2,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? Colors.white
                                      : Colors.black12,
                                  border: Border.all(color: Colors.black38)),
                              child: Center(
                                  child: Text("${index + 1}",
                                      style: TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center)),
                            )),
                        SizedBox(
                            height: 50,
                            width: screenW / 9 * 2,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? Colors.white
                                      : Colors.black12,
                                  border: Border.all(color: Colors.black38)),
                              child: TextField(
                                style: TextStyle(fontSize: 20),
                                controller: _relays[index],
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 50,
                          width: screenW / 9,
                        ),
                        SizedBox(
                            height: 50,
                            width: screenW / 9 * 2,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? Colors.white
                                      : Colors.black12,
                                  border: Border.all(color: Colors.black38)),
                              child: Center(
                                  child: Text("${index + 1}",
                                      style: TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center)),
                            )),
                        SizedBox(
                            height: 50,
                            width: screenW / 9 * 2,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? Colors.white
                                      : Colors.black12,
                                  border: Border.all(color: Colors.black38)),
                              child: TextField(
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                controller: _relaysPreflight[index],
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            )),
                      ],
                    );
                  }),
                ),
                SizedBox(
                  height: 10,
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
                        color: Colors.lightGreen,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        splashColor: Colors.lightGreenAccent,
                        onPressed: () {},
                        child: Text("Сохранить"),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: screenW / 3,
                      child: RaisedButton(
                        color: Colors.lightGreen,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        splashColor: Colors.lightGreenAccent,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Отмена"),
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
