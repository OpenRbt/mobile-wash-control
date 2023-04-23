import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';

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
        if (data.currentProgram != null) {
          leading = Container(
            height: theme.iconTheme.size ?? 24,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: CircularProgressIndicator(color: Colors.green),
            ),
          );
        } else {
          leading = Icon(
            Icons.circle,
            color: data.status == "online" ? Colors.green : Colors.red,
          );
        }
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
        title: Text("Пост: ${data.name} | Баланс: ${data.currentBalance ?? "-"}"),
        subtitle: Row(
          children: [
            Text("Программа: ${data.hash != null ? data.currentProgramName ?? "Ожидание клиента" : "-"} "),
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
                    "Хэш: ${data.hash ?? "-"}",
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
