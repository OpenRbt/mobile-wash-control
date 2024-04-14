import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';

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
          /*
          children: [
            Text("Описание: ${data.description ?? "-"}"),
          ],
           */
        ),
        childrenPadding: const EdgeInsets.all(8.0),
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
                    "Описание: ${data.description} ",
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
              OutlinedButton.icon(
                onPressed: onPressed,
                icon: const Icon(Icons.settings_outlined),
                label: const Text("Управление"),
              )
            ],
          )
        ],
      ),
    );
  }
}
