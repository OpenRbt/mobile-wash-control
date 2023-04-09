import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/SharedData.dart';
import 'package:mobile_wash_control/client/api.dart';

class KassePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _KassePageState();
}

class _KassePageState extends State<KassePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _inUpdate = false;
  bool _firstLoad = true;

  List<String> _taxValues = ["TAX_VAT110", "TAX_VAT0", "TAX_NO", "TAX_VAT120"];
  String _dropDownValue = "TAX_NO";

  late List<TextEditingController> _inputControllers;

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
    } catch (e) {
      print("Exception when calling DefaultApi->set-kasse: $e\n");
    }
    _inUpdate = false;
  }

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

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = SharedData.sessionData!;

    final theme = Theme.of(context);

    if (_firstLoad) {
      _getKasse(sessionData);
      _firstLoad = false;
    }

    double screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Параметры кассы"),
      ),
      key: _scaffoldKey,
      body: ListView(children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Text("TAX", style: theme.textTheme.bodyLarge),
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
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
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Text("Товар", style: theme.textTheme.bodyLarge),
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: TextField(
                              controller: _inputControllers[0],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Text("Кассир", style: theme.textTheme.bodyLarge),
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: TextField(
                              controller: _inputControllers[1],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Text("ИНН Кассира", style: theme.textTheme.bodyLarge),
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: TextField(
                              maxLength: 12,
                              controller: _inputControllers[2],
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp("[0-9_]"),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _inUpdate
                        ? null
                        : () {
                            _setKasse(sessionData, context);
                          },
                    child: Text("Сохранить"),
                  ),
                  ElevatedButton(
                    onPressed: _inUpdate
                        ? null
                        : () {
                            _getKasse(sessionData);
                          },
                    child: Text("Отменить"),
                  ),
                ],
              ),
            )
          ],
        ),
      ]),
    );
  }
}
