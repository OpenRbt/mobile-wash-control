import 'package:flutter/material.dart';
import 'package:mobile_wash_control/SharedData.dart';

class StationCard extends StatelessWidget {
  final HomePageData data;

  final void Function()? onPressed;

  const StationCard({super.key, required this.data, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Icon icon;
    if (data.hash.isNotEmpty) {
      icon = Icon(
        Icons.circle,
        color: data.status == "online" ? Colors.green : Colors.red,
      );
    } else {
      icon = Icon(Icons.circle_outlined);
    }

    return Card(
      child: ExpansionTile(
        title: Text("Пост: ${data.name}"),
        subtitle: Text("Баланс: ${data.currentBalance}"),
        leading: icon,
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
                    "IP: ${data.ip}",
                    style: theme.textTheme.bodyMedium,
                  ),
                  Text(
                    "Программа: ${data.currentProgramName}",
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
              OutlinedButton.icon(
                onPressed: onPressed,
                icon: Icon(Icons.settings_outlined),
                label: Text("Управление"),
              )
            ],
          )
        ],
      ),
    );
  }
}
