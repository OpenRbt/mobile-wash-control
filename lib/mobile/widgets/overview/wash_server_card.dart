import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';

class WashServerCard extends StatelessWidget {

  final WashServer data;
  final void Function()? onPressed;

  const WashServerCard({super.key, required this.data, this.onPressed});

  @override
  Widget build(BuildContext context) {
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
        subtitle: Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text(
                "ServiceKey",
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Text(
                data.serviceKey ?? "-",
                style: theme.textTheme.bodyLarge,
              ),
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
                  "Описание",
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
          const SizedBox(height: 20,),
          Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text(
                  "Создатель",
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Text(data.createdBy ?? "-")
              ),
            ],
          ),
          const Divider(),
          OutlinedButton(
            onPressed: onPressed,
            child: const Text("Редактировать"),
          ),
        ],
      ),
    );
  }
}
