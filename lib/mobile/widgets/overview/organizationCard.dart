import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../entity/entity.dart';

class OrganizationCard extends StatelessWidget {
  final Organization data;

  final void Function()? onPressed;

  const OrganizationCard({super.key, required this.data, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget leading;

    return Card(
      child: ExpansionTile(
        title: Text("Организация: ${data.name} "),
        subtitle: Row(
          children: [
            Text("Владелец: ${data.owner ?? "-"}"),
          ],
        ),
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
                    "Стандартная: ${(data.isDefault ?? true) ? "Да": "Нет"} ",
                    style: theme.textTheme.bodyMedium,
                  ),
                  Text(
                    "Описание: ${data.description} ",
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
