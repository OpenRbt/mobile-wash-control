import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/repository/repository.dart';
import 'package:easy_localization/easy_localization.dart';

class ProgramDiscountDialog extends StatefulWidget {
  final ValueNotifier<DiscountCampaign> campaign;
  final Repository repository;
  final DiscountProgram? discount;
  final int? index;

  ProgramDiscountDialog({super.key, required this.campaign, required this.repository, this.discount, this.index});

  @override
  State<ProgramDiscountDialog> createState() => _ProgramDiscountDialogState();
}

class _ProgramDiscountDialogState extends State<ProgramDiscountDialog> {
  ValueNotifier<List<Program>?> programs = ValueNotifier(null);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController discountController = TextEditingController();

  int selectedID = -1;
  List<DropdownMenuItem<int>> items = [
    DropdownMenuItem(
      child: Text('not_selected').tr(),
      value: -1,
    )
  ];

  @override
  void initState() {
    discountController.text = widget.discount?.discount?.toString() ?? "0";
    selectedID = widget.discount?.programID ?? selectedID;
    var programs = widget.repository.getProgramsNotifier().value;
    items.addAll(
      List.generate(
        programs?.length ?? 0,
        (index) {
          final program = programs![index];
          return DropdownMenuItem(
            child: Text(
              program.name,
              overflow: TextOverflow.ellipsis,
            ),
            value: program.id!,
          );
        },
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    programs.dispose();
    discountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var appBarPadding = AppBar().preferredSize.height + MediaQuery.of(context).padding.top;

    return AlertDialog(
      title: Text(
        (widget.discount == null ? 'adding'.tr(): 'editing'.tr()) + 'discounts_for_program'.tr(),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  widget.discount != null ? Container():
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Text(
                          context.tr('program'),
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: DropdownButtonFormField(
                          isExpanded: true,
                          items: items,
                          onChanged: (val) {
                            selectedID = val!;
                          },
                          value: selectedID,
                          validator: (value) {
                            if (value == -1) {
                              return context.tr('you_must_select_the_program');
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  widget.discount != null ? Container():
                  Text(
                    context.tr('adding_an_existing_program_will_overwrite_the_old_value'),
                    style: theme.textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
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
                                controller: discountController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  FilteringTextInputFormatter.singleLineFormatter,
                                ],
                                validator: (value) {
                                  int percent = int.tryParse(value ?? "0") ?? 0;
                                  if (percent <= 0) {
                                    return "${context.tr('the_discount_must_be_greater_than')} 0%";
                                  }

                                  if (percent > 100) {
                                    return "${context.tr('the_discount_cannot_be_greater_than')} 100%";
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
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              var programs = widget.campaign.value.discountPrograms ?? {};
              var program = DiscountProgram(programID: selectedID, discount: int.parse(discountController.text));

              if (programs.contains(program)) {
                programs.remove(program);
              }
              programs.add(program);

              widget.campaign.value = widget.campaign.value.copyWith(
                discountPrograms: programs,
              );

              Navigator.pop(context);
            }
          },
          child: Text(context.tr('accept'),),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(context.tr('cancel'),),
        ),
      ],
    );
  }
}
