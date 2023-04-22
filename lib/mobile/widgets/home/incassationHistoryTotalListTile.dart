import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_wash_control/entity/entity.dart';

class IncassationHistoryTotalListTile extends StatelessWidget {
  final StationCollectionReport report;

  IncassationHistoryTotalListTile({super.key, required this.report});

  final _dateFormatter = DateFormat('dd.MM.yyyy hh.mm.ss');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text(
                "Итого",
                style: theme.textTheme.titleLarge!.copyWith(color: theme.primaryColor),
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Center(
                child: Text(
                  "${report.coins ?? 0}",
                  style: theme.textTheme.titleLarge!.copyWith(color: theme.primaryColor),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Center(
                child: Text(
                  "${report.banknotes ?? 0}",
                  style: theme.textTheme.titleLarge!.copyWith(color: theme.primaryColor),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Center(
                child: Text(
                  "${report.electronical ?? 0}",
                  style: theme.textTheme.titleLarge!.copyWith(color: theme.primaryColor),
                ),
              ),
            ),
          ],
        ),
        Row(),
      ],
    );
  }
}
