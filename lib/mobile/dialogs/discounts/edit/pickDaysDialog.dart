import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:easy_localization/easy_localization.dart';

class PickDaysDialog extends StatelessWidget {
  final ValueNotifier<DiscountCampaign> campaign;

  PickDaysDialog({super.key, required this.campaign});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Set<WeekDay> days = campaign.value.weekDays ?? {};

    return AlertDialog(
      //
      title: Text(context.tr('select_days')),
      content: StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              7,
              (index) => CheckboxListTile(
                value: days.contains(WeekDay.values[index]),
                title: Text(WeekDay.values[index].label()),
                onChanged: (value) {
                  if (value ?? false) {
                    days.add(WeekDay.values[index]);
                  } else {
                    days.remove(WeekDay.values[index]);
                  }
                  setState(() {});
                },
              ),
            ),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            campaign.value = campaign.value.copyWith(weekDays: WeekDaySorting.sortDays(days));
            Navigator.pop(context);
          },
          child: Text(context.tr('accept')),
        ),
      ],
    );
  }
}
