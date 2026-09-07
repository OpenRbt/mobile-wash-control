import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/common/ProgressTextButton.dart';
import 'package:mobile_wash_control/repository/repository.dart';
import 'package:mobile_wash_control/utils/utils.dart';

class KassePage extends StatefulWidget {
  const KassePage({super.key});

  @override
  State<KassePage> createState() => _KassePageState();
}

class _KassePageState extends State<KassePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Map<String, TextEditingController> _controller = {};

  final ValueNotifier<KasseConfig> _config =
      ValueNotifier(KasseConfig(taxType: TaxType.no));

  Repository? _repository;
  bool _loaded = false;
  late Future<void> _loadFuture;

  @override
  void initState() {
    super.initState();

    _controller["receipt"] = TextEditingController();
    _controller["cashier"] = TextEditingController();
    _controller["cashierINN"] = TextEditingController();
  }

  @override
  void dispose() {
    for (final c in _controller.values) {
      c.dispose();
    }
    _config.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_loaded) return;

    final initialArgs = ModalRoute.of(context)?.settings.arguments;
    if (!isArgsValid(initialArgs, context)) return;

    final args = initialArgs as Map<PageArgCode, dynamic>;
    _repository = args[PageArgCode.repository] as Repository;

    _loadFuture = _loadKasseConfig();
    _loaded = true;
  }

  Future<void> _loadKasseConfig() async {
    final config =
        await _repository!.getKasseConfig(context: context) ??
            KasseConfig(taxType: TaxType.no);

    _config.value = config;

    _controller["receipt"]!.text = config.receiptItemName ?? "";
    _controller["cashier"]!.text = config.cashier ?? "";
    _controller["cashierINN"]!.text = config.cashierINN ?? "";
  }

  Future<void> _saveConfig() async {
    if (!_formKey.currentState!.validate()) return;

    await _repository!.saveKasseConfig(
      _config.value,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(context.tr('cash_desk_parameters')),
      ),
      body: FutureBuilder<void>(
        future: _loadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(12),
            children: [
              Card(
                child: ExpansionTile(
                  initiallyExpanded: true,
                  title: Text(
                    context.tr('cash_desk_parameters'),
                    style: theme.textTheme.titleLarge,
                  ),
                  childrenPadding: const EdgeInsets.all(12),
                  children: [
                    ValueListenableBuilder<KasseConfig>(
                      valueListenable: _config,
                      builder: (context, value, _) {
                        return Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "TAX",
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: DropdownButtonFormField<TaxType>(
                                      initialValue: value.taxType,
                                      isExpanded: true,
                                      items: TaxType.values
                                          .map(
                                            (e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e.label()),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (val) {
                                        if (val == null) return;
                                        _config.value =
                                            value.copyWith(taxType: val);
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      context.tr('product'),
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      controller: _controller["receipt"],
                                      validator: (val) {
                                        if ((val ?? "").trim().isEmpty) {
                                          return context.tr(
                                              'field_must_not_be_empty');
                                        }
                                        return null;
                                      },
                                      onChanged: (val) {
                                        _config.value = value.copyWith(
                                          receiptItemName: val.trim(),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      context.tr('cashier'),
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      controller: _controller["cashier"],
                                      onChanged: (val) {
                                        _config.value = value.copyWith(
                                          cashier: val.trim(),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      context.tr('cashier_document'),
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      controller: _controller["cashierINN"],
                                      maxLength: 12,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      validator: (val) {
                                        if (value.cashier?.isNotEmpty ?? false) {
                                          if ((val ?? "").length < 12) {
                                            return context.tr(
                                              'field_must_contain_more_symbols',
                                            );
                                          }
                                        }
                                        return null;
                                      },
                                      onChanged: (val) {
                                        _config.value = value.copyWith(
                                          cashierINN: val.trim(),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ProgressTextButton(
                                    onPressed: _saveConfig,
                                    child: Text(context.tr('save')),
                                  ),
                                  ProgressTextButton(
                                    onPressed: _loadKasseConfig,
                                    child: Text(context.tr(
                                        'get_current_configuration')),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
