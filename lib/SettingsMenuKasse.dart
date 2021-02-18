import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "client/api.dart";

class SettingsMenuKasse extends StatefulWidget {
  @override
  _SettingsMenuKasseState createState() => _SettingsMenuKasseState();
}

class _SettingsMenuKasseState extends State<SettingsMenuKasse> {
  _SettingsMenuKasseState() : super();

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text("Касса"),
    );

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appBar,
      body: OrientationBuilder(
        builder: (context, orientation) {
          return new SizedBox(
            height: screenH - appBar.preferredSize.height,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                        height: 75,
                        width: screenW / 3,
                        child: Center(
                          child: Text("TAX",
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.center),
                        )),
                    SizedBox(
                      height: 75,
                      width: screenW / 3 * 2,
                      child: DropdownButton(
                          isExpanded: true,
                          items: List.generate(5, (index) {
                            return DropdownMenuItem(
                                child: Text(
                              "Var $index",
                              textAlign: TextAlign.end,
                            ));
                          }),
                          onChanged: (newValue) => () {}),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                        height: 75,
                        width: screenW / 3,
                        child: Center(
                          child: Text("ReceiptItem",
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.center),
                        )),
                    SizedBox(
                        height: 75,
                        width: screenW - screenW / 3,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: TextField(
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
                          child: Text("Cashier",
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.center),
                        )),
                    SizedBox(
                        height: 75,
                        width: screenW - screenW / 3,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: TextField(
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
                          child: Text("CashierINN",
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.center),
                        )),
                    SizedBox(
                        height: 75,
                        width: screenW - screenW / 3,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: TextField(
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
                        onPressed: () {},
                        child: Text("Сохранить"),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: screenW / 3,
                      child: RaisedButton(
                        onPressed: () {},
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
