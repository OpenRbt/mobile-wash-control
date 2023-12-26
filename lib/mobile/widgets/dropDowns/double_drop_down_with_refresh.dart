import 'package:flutter/material.dart';

class DoubleDropDownWithRefresh extends StatelessWidget {

  final ValueNotifier<List<dynamic>> firstItemsList;
  final ValueNotifier<dynamic> firstCurrentItem;
  final Future<void>Function(String? value) firstOnChanged;

  final ValueNotifier<List<dynamic>> secondItemsList;
  final ValueNotifier<dynamic> secondCurrentItem;
  final Future<void>Function(String? value) secondOnChanged;

  final ValueNotifier<bool> block;


  const DoubleDropDownWithRefresh({
    Key? key,
    required this.firstItemsList,
    required this.firstCurrentItem,
    required this.firstOnChanged,

    required this.secondItemsList,
    required this.secondCurrentItem,
    required this.secondOnChanged,

    required this.block
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: ValueListenableBuilder(
                valueListenable: firstItemsList,
                builder: (BuildContext context, List<dynamic> orgs, Widget? widget){
                  return ValueListenableBuilder(
                      valueListenable: firstCurrentItem,
                      builder: (BuildContext context, dynamic org, Widget? widget) {
                        return Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: DropdownButtonFormField(
                            isExpanded: true,
                            value: (firstCurrentItem.value.id?.isEmpty ?? true) ? orgs[0].id: firstCurrentItem.value.id,
                            items: List.generate(
                              orgs.length,
                                  (index) => DropdownMenuItem(
                                value: orgs[index].id!,
                                child: Text(orgs[index].name!),
                              ),
                            ),
                            onChanged: (Object? value) async {
                              await firstOnChanged(value.toString());
                            },
                          ),
                        );
                      }
                  );
                }
            ),
        ),
        const SizedBox(width: 30,),
        Expanded(
            child: ValueListenableBuilder(
                valueListenable: secondItemsList,
                builder: (BuildContext context, List<dynamic> grps, Widget? widget) {
                  return ValueListenableBuilder(
                      valueListenable: block,
                      builder: (BuildContext context, bool blck, Widget? widget) {
                        return ValueListenableBuilder(
                            valueListenable: secondCurrentItem,
                            builder: (BuildContext context, dynamic grp, Widget? widget){
                              return Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: DropdownButtonFormField(
                                  isExpanded: true,
                                  value: (secondCurrentItem.value.id?.isEmpty ?? true) ? grps[0].id: secondCurrentItem.value.id,
                                  items: blck ? null: List.generate(
                                    grps.length,
                                        (index) => DropdownMenuItem(
                                      value: grps[index].id ?? "",
                                      child: Text(grps[index].name ?? ""),
                                    ),
                                  ),
                                  onChanged: (Object? value) async {
                                    await secondOnChanged(value.toString());
                                  },
                                ),
                              );
                            }
                        );
                      }
                  );
                }
            ),
        )
      ],
    );
  }
}
