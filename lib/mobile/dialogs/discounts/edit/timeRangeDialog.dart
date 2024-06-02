import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';

class TimeRangeDialog extends StatefulWidget {
  final ValueNotifier<DiscountCampaign> campaign;

  TimeRangeDialog({super.key, required this.campaign});

  @override
  State<TimeRangeDialog> createState() => _TimeRangeDialogState();
}

class _TimeRangeDialogState extends State<TimeRangeDialog> {
  ValueNotifier<int> startMinute = ValueNotifier(0);
  ValueNotifier<int> endMinute = ValueNotifier(24 * 60 - 1);

  @override
  void initState() {
    startMinute.value = widget.campaign.value.startMinute ?? 0;
    endMinute.value = widget.campaign.value.endMinute ?? 24 * 60 - 1;
    super.initState();
  }

  @override
  void dispose() {
    startMinute.dispose();
    endMinute.dispose();
    super.dispose();
  }

  String _durationFormat(Duration d) {
    return "${d.inHours.toString().padLeft(2, "0")}:${d.inMinutes.remainder(60).toString().padLeft(2, "0")}";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: Text("Время действия скидки"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ValueListenableBuilder(
            valueListenable: startMinute,
            builder: (BuildContext context, int value, Widget? child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "С ",
                        style: theme.textTheme.bodyLarge,
                      ),
                      Text(
                        _durationFormat(Duration(minutes: value)),
                        style: theme.textTheme.bodyLarge!.copyWith(color: theme.primaryColor),
                      )
                    ],
                  ),
                  TextButton(
                    onPressed: () async {
                      var res = await showTimePicker(
                        context: context,
                        initialEntryMode: TimePickerEntryMode.dialOnly,
                        initialTime: TimeOfDay(hour: value ~/ 60, minute: value % 60),
                      );

                      if (res != null) {
                        startMinute.value = res.hour * 60 + res.minute;
                      }
                    },
                    child: Text("Выбрать"),
                  ),
                ],
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: endMinute,
            builder: (BuildContext context, int value, Widget? child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "По ",
                        style: theme.textTheme.bodyLarge,
                      ),
                      Text(
                        _durationFormat(Duration(minutes: value)),
                        style: theme.textTheme.bodyLarge!.copyWith(color: theme.primaryColor),
                      )
                    ],
                  ),
                  TextButton(
                    onPressed: () async {
                      var res = await showTimePicker(
                        context: context,
                        initialEntryMode: TimePickerEntryMode.dialOnly,
                        initialTime: TimeOfDay(hour: value ~/ 60, minute: value % 60),
                      );

                      if (res != null) {
                        endMinute.value = res.hour * 60 + res.minute;
                      }
                    },
                    child: Text("Выбрать"),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              widget.campaign.value = widget.campaign.value.copyWith(startMinute: startMinute.value, endMinute: endMinute.value);
              Navigator.pop(context);
            },
            child: Text("Применить"))
      ],
    );
  }
}
