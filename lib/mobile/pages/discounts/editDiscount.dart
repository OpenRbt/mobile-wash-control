import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/dialogs/discounts/edit/pickDaysDialog.dart';
import 'package:mobile_wash_control/mobile/dialogs/discounts/edit/programDiscountDialog.dart';
import 'package:mobile_wash_control/mobile/dialogs/discounts/edit/timeRangeDialog.dart';
import 'package:mobile_wash_control/mobile/widgets/common/ProgressButton.dart';
import 'package:mobile_wash_control/mobile/widgets/discounts/edit/programDiscountListTIle.dart';
import 'package:mobile_wash_control/repository/repository.dart';

class EditDiscountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditDiscountPageState();
}

class _EditDiscountPageState extends State<EditDiscountPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late ValueNotifier<DiscountCampaign> _currentDiscount;
  ValueNotifier<DiscountCampaign?> _discount = ValueNotifier(null);
  ValueNotifier<DateTimeRange> _dateRange = ValueNotifier(DateTimeRange(start: DateTime.now(), end: DateTime.now()));

  final _dateFormatter = DateFormat('dd.MM.yyyy');

  Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    var now = DateTime.now();
    _dateRange.value = DateTimeRange(
      start: DateTime(now.year, now.month, 1),
      end: (now.month + 1) <= 12 ? DateTime(now.year, now.month + 1) : DateTime(now.year + 1, 1) ,
    );

    _currentDiscount = ValueNotifier(DiscountCampaign(
      startDate: _dateRange.value.start,
      endDate: _dateRange.value.end,
      name: 'new_discount_program'.tr(),
      startMinute: 0,
      endMinute: 24 * 60 - 1,
    ));
    _controllers["name"] = TextEditingController();
    _controllers["discount"] = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _currentDiscount.dispose();
    _discount.dispose();
    _dateRange.dispose();
    _controllers.values.forEach((element) {
      element.dispose();
    });

    super.dispose();
  }

  Future<void> _getDiscount(int? id, Repository repository, BuildContext context) async {
    if (id == null) {
      return;
    }

    final discount = await repository.getDiscountCampaign(id, context: context);
    if (_discount.value == null) {
      _discount.value = discount;
    }
  }

  Future<void> _resetUI() async {
    if (_discount.value != null) {
      _currentDiscount.value = _discount.value!.copyWith(startDate: null, endDate: null, name: _discount.value!.name ?? 'new_discount_program'.tr());
    }

    _controllers["name"]!.text = _currentDiscount.value.name ?? "";
    _controllers["discount"]!.text = _currentDiscount.value.defaultDiscount?.toString() ?? "0";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    var args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final Repository repository = args[PageArgCode.repository];

    final int? discountID = args[PageArgCode.discountID] as int?;

    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(
          valueListenable: _discount,
          builder: (BuildContext context, DiscountCampaign? value, Widget? child) {
            return Text(value?.name != null ? "${context.tr('editing')}" : '${context.tr('discount_program_creation')}');
          },
        ),
        actions: [
          discountID != null
              ? TextButton.icon(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(context.tr('are_you_sure')),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                await repository.deleteDiscountCampaign(discountID, context: context);
                                Navigator.of(context).pop();
                                Navigator.pop(context);
                              },
                              child: Text(context.tr('yes')),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(context.tr('no')),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    color: theme.colorScheme.onPrimary,
                  ),
                  label: Text(
                    "${context.tr('delete')}",
                    style: theme.textTheme.titleMedium!.copyWith(color: theme.colorScheme.onPrimary),
                  ),
                )
              : Container(),
        ],
      ),
      body: FutureBuilder(
        future: _getDiscount(discountID, repository, context).then((value) => _resetUI()),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          return Form(
            key: _formKey,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Card(
                  child: ExpansionTile(
                    title: Text(
                      context.tr('discount_program_settings'),
                      style: theme.textTheme.titleLarge,
                    ),
                    childrenPadding: EdgeInsets.all(8),
                    children: [
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Text(
                              "${context.tr('name')}",
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: TextFormField(
                              controller: _controllers["name"]!,
                              onChanged: (val) {
                                _currentDiscount.value = _currentDiscount.value.copyWith(name: val);
                              },
                              validator: (val) {
                                if ((val ?? "").trim().isEmpty) {
                                  return "${context.tr('field_must_not_be_empty')}";
                                }
                                return null;
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
                              context.tr('is_active'),
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: ValueListenableBuilder(
                              valueListenable: _currentDiscount,
                              builder: (BuildContext context, DiscountCampaign value, Widget? child) {
                                return Switch(
                                  value: value.enabled ?? false,
                                  onChanged: (val) {
                                    _currentDiscount.value = _currentDiscount.value.copyWith(enabled: val);
                                  },
                                );
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
                              context.tr('discount'),
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _controllers["discount"],
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      FilteringTextInputFormatter.singleLineFormatter,
                                    ],
                                    onChanged: (val) {
                                      if (val.isEmpty) {
                                        //_controllers["motor"]!.text = "0";
                                      } else {
                                        if (int.parse(val) > 100) {
                                          _controllers["discount"]!.text = "100";
                                        }
                                      }
                                      int discount = int.tryParse(val ?? "0") ?? 0;
                                      _currentDiscount.value = _currentDiscount.value.copyWith(defaultDiscount: discount);
                                    },
                                    validator: (val) {
                                      int res = int.tryParse(val ?? "0") ?? 0;
                                      if (res > 100) {
                                        return "${context.tr('the_discount_cannot_be_greater_than')} 100%";
                                      }
                                      if (res < 0) {
                                        return "${context.tr('the_discount_must_be_greater_than')} 0%";
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                                Text(
                                  "%",
                                  style: theme.textTheme.titleLarge,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.tr('dates_of_the_event'),
                                style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                              ),
                              ValueListenableBuilder(
                                valueListenable: _currentDiscount,
                                builder: (BuildContext context,  DiscountCampaign value, Widget? child) {
                                  _dateRange.value = DateTimeRange(start: value.startDate, end: value.endDate);
                                  return Row(
                                    children: [
                                      Text("${context.tr('from')} "),
                                      Text(
                                        _dateFormatter.format(value.startDate),
                                        style: theme.textTheme.bodyLarge!.copyWith(color: theme.primaryColor),
                                      ),
                                      Text(" ${context.tr('to')} "),
                                      Text(
                                        _dateFormatter.format(value.endDate),
                                        style: theme.textTheme.bodyLarge!.copyWith(color: theme.primaryColor),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              DateTimeRange? range = await showDateRangePicker(
                                context: context,
                                firstDate: DateTime(2023),
                                lastDate: DateTime(2030),
                                initialEntryMode: DatePickerEntryMode.calendar,
                                initialDateRange: _dateRange.value,
                              );
                              if (range != null) {
                                log("date start: ");
                                log(range.start.toString());
                                _dateRange.value = DateTimeRange(
                                  start: range.start,
                                  end: range.end.add(
                                    Duration(days: 1, microseconds: -1),
                                  ),
                                );
                                _currentDiscount.value.startDate = _dateRange.value.start;
                                _currentDiscount.value.endDate = _dateRange.value.end;
                                _currentDiscount.notifyListeners();
                              }
                            },
                            child: Text(
                              "${context.tr('choose_period')}",
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.tr('discount_active_time'),
                                style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                              ),
                              ValueListenableBuilder(
                                valueListenable: _currentDiscount,
                                builder: (BuildContext context, DiscountCampaign value, Widget? child) {
                                  return Row(
                                    children: [
                                      Text("${context.tr('from')} "),
                                      Text(
                                        _durationFormat(Duration(minutes: value.startMinute ?? 0)),
                                        style: theme.textTheme.bodyLarge!.copyWith(color: theme.primaryColor),
                                      ),
                                      Text(" ${context.tr('to')} "),
                                      Text(
                                        _durationFormat(Duration(minutes: value.endMinute ?? 0)),
                                        style: theme.textTheme.bodyLarge!.copyWith(color: theme.primaryColor),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              ValueNotifier<int> startMinute = ValueNotifier(_currentDiscount.value.startMinute ?? 0);
                              ValueNotifier<int> endMinute = ValueNotifier(_currentDiscount.value.endMinute ?? 24 * 60 - 1);

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return TimeRangeDialog(campaign: _currentDiscount);
                                },
                              );
                            },
                            child: Text(
                              "${context.tr('choose_period')}",
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
                              context.tr('active_days_of_week'),
                              style: theme.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: ValueListenableBuilder(
                              valueListenable: _currentDiscount,
                              builder: (BuildContext context, DiscountCampaign discountCampaign, Widget? child) {
                                return ElevatedButton(
                                  onPressed: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return PickDaysDialog(campaign: _currentDiscount);
                                      },
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: (discountCampaign.weekDays?.length ?? 0) > 0
                                        ? List.generate(
                                            discountCampaign.weekDays!.length,
                                            (index) => Text(
                                              discountCampaign.weekDays!.elementAt(index).labelShort(),
                                            ),
                                          )
                                        : [
                                            Text(context.tr('select_days')),
                                          ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: _currentDiscount,
                  builder: (BuildContext context, DiscountCampaign discountCampaign, Widget? child) {
                    ;
                    return Card(
                      child: ExpansionTile(
                        title: Text(
                          "${context.tr('programs_discounts')} - ${discountCampaign.discountPrograms?.length ?? 0}",
                          style: theme.textTheme.titleLarge,
                        ),
                        childrenPadding: EdgeInsets.all(8),
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (BuildContext context, int index) {
                              return Divider();
                            },
                            itemCount: discountCampaign.discountPrograms?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return EditProgramDiscountListTile(
                                index: index,
                                campaign: _currentDiscount,
                                discount: discountCampaign.discountPrograms!.elementAt(index),
                                repository: repository,
                              );
                            },
                          ),
                        ],
                        leading: IconButton(
                          icon: Icon(Icons.add_outlined),
                          onPressed: () {
                            showGeneralDialog(
                              context: context,
                              pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                                return ProgramDiscountDialog(campaign: _currentDiscount, repository: repository);
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ProgressButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await repository.saveDiscountCampaign(_currentDiscount.value, context: context);
                          Navigator.pop(context);
                        }
                      },
                      child: Text("${context.tr('save')}"),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  String _durationFormat(Duration d) {
    return "${d.inHours.toString().padLeft(2, "0")}:${d.inMinutes.remainder(60).toString().padLeft(2, "0")}";
  }
}
