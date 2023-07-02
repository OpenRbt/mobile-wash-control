import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_wash_control/entity/entity.dart';

class IncassationHistoryListTile extends StatelessWidget {
  final StationCollectionReport report;

  IncassationHistoryListTile({super.key, required this.report});

  final _dateFormatter = DateFormat('dd.MM.yyyy');
  final _timeFormatter = DateFormat('HH:mm:ss');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          children: [
            Flexible(
              flex: 0,
              fit: FlexFit.tight,
              child: Column(
                children: [
                  Text(
                    "${report.ctime != null ? _dateFormatter.format(report.ctime!) : "нет данных"}",
                    style: theme.textTheme.titleLarge,
                  ),
                  Text(
                    "${report.ctime != null ? _timeFormatter.format(report.ctime!) : "нет данных"}",
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              )
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Center(
                child: Text(
                  "${report.coins ?? 0}",
                  style: theme.textTheme.titleLarge,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Center(
                child: Text(
                  "${report.banknotes ?? 0}",
                  style: theme.textTheme.titleLarge,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Center(
                child: Text(
                  "${report.electronical ?? 0}",
                  style: theme.textTheme.titleLarge,
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
