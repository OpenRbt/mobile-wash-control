import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';

class ServerGroupCard extends StatelessWidget {

  final ServerGroup data;
  final void Function()? onPressed;

  const ServerGroupCard({super.key, required this.data, this.onPressed});

  @override
  Widget build(BuildContext context)  {
    final theme = Theme.of(context);

    return Card(
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              (data.name ?? ""),
              style: theme.textTheme.titleLarge,
            ),
          ],
        ),
        childrenPadding: const EdgeInsets.all(8),
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text(
                  "${context.tr('description')}",
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Text(data.description ?? "-")
              ),
            ],
          ),
          const Divider(),
          OutlinedButton(
            onPressed: onPressed,
            child: const Text("${context.tr('edit')}"),
          ),
        ],
      ),
    );
  }
}
