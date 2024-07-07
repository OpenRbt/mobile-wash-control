import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:easy_localization/easy_localization.dart';

class StationCard extends StatelessWidget {
  final Station data;

  final void Function()? onPressed;

  const StationCard({super.key, required this.data, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget leading;
    if (data.hash != null) {
      if (data.status != null) {
        leading = Icon(
          Icons.circle,
          color: data.status == "online" ? Colors.green : Colors.red,
        );
      } else {
        leading = Icon(
          Icons.circle,
        );
      }
    } else {
      leading = Icon(Icons.circle_outlined);
    }

    return Card(
      child: ExpansionTile(
        title: Text("${context.tr('post')}: ${data.name} | ${context.tr('balance')}: ${data.currentBalance ?? "-"}"),
        subtitle: Row(
          children: [
            Text("${context.tr('program')}: ${data.hash != null ? data.currentProgramName ?? "${context.tr('waiting_for_the_customer')}" : "-"} "),
          ],
        ),
        leading: leading,
        childrenPadding: EdgeInsets.all(8.0),
        expandedAlignment: Alignment.center,
        expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "IP: ${data.ip ?? "-"}",
                    style: theme.textTheme.bodyMedium,
                  ),
                  Text(
                    "${context.tr('hash')}: ${data.hash ?? "-"}",
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
              OutlinedButton.icon(
                onPressed: onPressed,
                icon: Icon(Icons.settings_outlined),
                label: Text(context.tr('management')),
              )
            ],
          )
        ],
      ),
    );
  }
}
