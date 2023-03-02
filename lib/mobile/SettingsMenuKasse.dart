import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';

class SettingsMenuKasse extends StatefulWidget {
  @override
  _SettingsMenuKasseState createState() => _SettingsMenuKasseState();
}

class _SettingsMenuKasseState extends State<SettingsMenuKasse> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);
  bool _inUpdate = false;
  bool _firstLoad = true;

  _SettingsMenuKasseState() : super();
  List<String> _taxValues = ["TAX_VAT110", "TAX_VAT0", "TAX_NO", "TAX_VAT120"];
  String _dropDownValue = "TAX_NO";

  late List<TextEditingController> _inputControllers;

  void initState() {
    super.initState();
    _inputControllers = List.generate(3, (index) {
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

  void _getKasse(SessionData sessionData) async {
    try {
      var res = await sessionData.client.kasse();
      if (!mounted) {
        return;
      }
      _dropDownValue = res?.tax?.value ?? "";
      _inputControllers[0].text = res?.receiptItemName ?? "";
      _inputControllers[1].text = res?.cashier ?? "";
      _inputControllers[2].text = res?.cashierINN ?? "";
      setState(() {});
    } catch (e) {
      print("Exception when calling DefaultApi->kasse: $e\n");
    }
  }

  void _setKasse(SessionData sessionData, BuildContext context) async {
    _inUpdate = true;
    try {
      if (_inputControllers[1].value.text.length > 0 && _inputControllers[2].value.text.length != 12) {
        throw Exception("");
      }

      var args = KasseConfig();
      switch (_dropDownValue) {
        case "TAX_VAT110":
          {
            args.tax = KasseConfigTaxEnum.vAT110;
            break;
          }
        case "TAX_VAT0":
          {
            args.tax = KasseConfigTaxEnum.vAT0;
            break;
          }
        case "TAX_NO":
          {
            args.tax = KasseConfigTaxEnum.NO;
            break;
          }
        case "TAX_VAT120":
          {
            args.tax = KasseConfigTaxEnum.vAT120;
            break;
          }
      }
      args.receiptItemName = _inputControllers[0].value.text;
      args.cashier = _inputControllers[1].value.text;
      args.cashierINN = _inputControllers[2].value.text;

      var res = await sessionData.client.setKasse(args);
      showInfoSnackBar(context, _scaffoldKey, _isSnackBarActive, "Настройки кассы сохрианены", Colors.green);
    } catch (e) {
      print("Exception when calling DefaultApi->set-kasse: $e\n");
      showInfoSnackBar(context, _scaffoldKey, _isSnackBarActive, "Не удалось сохранить настройки кассы", Colors.red);
    }
    _inUpdate = false;
  }

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context)?.settings.arguments as SessionData;

    if (_firstLoad) {
      _getKasse(sessionData);
      _firstLoad = false;
    }
    var appBar = AppBar(
      title: Text("Касса"),
    );

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appBar,
      key: _scaffoldKey,
      body: OrientationBuilder(
        builder: (context, orientation) {
          return new SizedBox(
            height: screenH - appBar.preferredSize.height,
            child: ListView(children: [
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 75,
                        width: screenW / 3,
                        child: Center(
                          child: Text("TAX", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                        ),
                      ),
                      SizedBox(
                        height: 75,
                        width: screenW / 3 * 2,
                        child: DropdownButton(
                            value: _dropDownValue,
                            isExpanded: true,
                            items: List.generate(_taxValues.length, (index) {
                              return DropdownMenuItem(
                                value: _taxValues[index],
                                child: Text(
                                  "${_taxValues[index]}",
                                  textAlign: TextAlign.end,
                                ),
                              );
                            }),
                            onChanged: (newValue) {
                              _dropDownValue = newValue!;
                              setState(() {});
                            }),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 75,
                        width: screenW / 3,
                        child: Center(
                          child: Text("ReceiptItem", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                        ),
                      ),
                      SizedBox(
                        height: 75,
                        width: screenW - screenW / 3,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            controller: _inputControllers[0],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(),
                            ),
                          ),
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
                          child: Text("Cashier", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                        ),
                      ),
                      SizedBox(
                        height: 75,
                        width: screenW - screenW / 3,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            controller: _inputControllers[1],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(),
                            ),
                          ),
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
                          child: Text("CashierINN", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                        ),
                      ),
                      SizedBox(
                        height: 75,
                        width: screenW - screenW / 3,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            maxLength: 12,
                            controller: _inputControllers[2],
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp("[0-9_]"),
                              )
                            ],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      )
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
                        child: ElevatedButton(
                          onPressed: _inUpdate
                              ? null
                              : () {
                                  _setKasse(sessionData, context);
                                },
                          child: Text("Сохранить"),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: screenW / 3,
                        child: ElevatedButton(
                          onPressed: _inUpdate
                              ? null
                              : () {
                                  _getKasse(sessionData);
                                },
                          child: Text("Отменить"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ]),
          );
        },
      ),
    );
  }
}
