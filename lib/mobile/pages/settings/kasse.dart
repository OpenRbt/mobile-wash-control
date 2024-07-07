import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/common/ProgressTextButton.dart';
import 'package:mobile_wash_control/repository/repository.dart';
import 'package:easy_localization/easy_localization.dart';

class KassePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _KassePageState();
}

class _KassePageState extends State<KassePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  late List<TextEditingController> _inputControllers;

  Map<String, TextEditingController> _controller = Map();
  ValueNotifier<KasseConfig> _config = ValueNotifier(KasseConfig(taxType: TaxType.no));

  void initState() {
    _controller["receipt"] = TextEditingController();
    _controller["cashier"] = TextEditingController();
    _controller["cashierINN"] = TextEditingController();

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
    _controller.values.forEach((element) {
      element.dispose();
    });

    for (var controller in _inputControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _getKasseConfig(Repository repository, BuildContext context) async {
    _config.value = await repository.getKasseConfig(context: context) ?? KasseConfig(taxType: TaxType.no);

    _controller["receipt"]!.text = _config.value.receiptItemName ?? "";
    _controller["cashier"]!.text = _config.value.cashier ?? "";
    _controller["cashierINN"]!.text = _config.value.cashierINN ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final repository = args[PageArgCode.repository] as Repository;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('cash_desk_parameters')),
      ),
      key: _scaffoldKey,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          FutureBuilder(
            future: _getKasseConfig(repository, context),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              return Card(
                child: ExpansionTile(
                  title: Text(
                    context.tr('cash_desk_parameters'),
                    style: theme.textTheme.titleLarge,
                  ),
                  childrenPadding: EdgeInsets.all(8),
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _config,
                      builder: (BuildContext context, KasseConfig value, Widget? child) {
                        return Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      "TAX",
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: DropdownButtonFormField(
                                      isExpanded: true,
                                      value: _config.value.taxType,
                                      items: List.generate(
                                        TaxType.values.length,
                                        (index) => DropdownMenuItem(
                                          child: Text(
                                            TaxType.values[index].label(),
                                          ),
                                          value: TaxType.values[index],
                                        ),
                                      ),
                                      onChanged: (val) {
                                        _config.value = _config.value.copyWith(taxType: val);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      context.tr('product'),
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: TextFormField(
                                      controller: _controller["receipt"],
                                      validator: (val) {
                                        if ((val ?? "").trim().isEmpty) {
                                          return "${context.tr('field_must_not_be_empty')}";
                                        }

                                        return null;
                                      },
                                      onChanged: (val) {
                                        val = (val ?? "").trim();
                                        _config.value = _config.value.copyWith(receiptItemName: val);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      context.tr('cashier'),
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: TextFormField(
                                      controller: _controller["cashier"],
                                      validator: (val) {
                                        if (val?.isNotEmpty ?? false) {
                                          var trimmed = (val ?? "").trim();
                                          if (trimmed.isEmpty) {
                                            return "${context.tr('field_must_not_be_empty')}";
                                          }
                                          if (trimmed.length < 1) {
                                            return context.tr('field_must_contain_more_symbols');
                                          }
                                        }

                                        return null;
                                      },
                                      onChanged: (val) {
                                        val = (val ?? "").trim();
                                        _config.value = _config.value.copyWith(cashier: val);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      context.tr('cashier_document'),
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: TextFormField(
                                      controller: _controller["cashierINN"],
                                      maxLength: 12,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        FilteringTextInputFormatter.singleLineFormatter,
                                      ],
                                      validator: (val) {
                                        if (_config.value.cashier?.isNotEmpty ?? false) {
                                          var trimmed = (val ?? "").trim();
                                          if (trimmed.isEmpty) {
                                            return "${context.tr('field_must_not_be_empty')}";
                                          }

                                          if (trimmed.length < 12) {
                                            return context.tr('field_must_contain_more_symbols');
                                          }
                                        }
                                        return null;
                                      },
                                      onChanged: (val) {
                                        val = (val ?? "").trim();
                                        _config.value = _config.value.copyWith(cashierINN: val);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ProgressTextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await repository.saveKasseConfig(_config.value, context: context);
                            }
                          },
                          child: Text("${context.tr('save')}"),
                        ),
                        Flexible(
                          flex: 1,
                            fit: FlexFit.tight,
                            child: ProgressTextButton(
                              onPressed: () async {
                                await _getKasseConfig(repository, context);
                              },
                              child: Text("${context.tr('get_current_configuration')}"),
                            )
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
