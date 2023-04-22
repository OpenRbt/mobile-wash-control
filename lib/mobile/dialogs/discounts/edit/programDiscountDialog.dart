import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/repository/repository.dart';

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
      child: Text("Не выбрано"),
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
        "Добавление скидки для программы",
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Text(
                          "Программа",
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
                              return "необходимо выбрать программу";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Добавление уже имеющейся программы перезапишет старое значение",
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
                          "Скидка",
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
                                    return "скидка должна быть больше 0%";
                                  }

                                  if (percent > 100) {
                                    return "скидка не может быть больше 100%";
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
          child: Text("Применить"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Отмена"),
        ),
      ],
    );
  }
}
