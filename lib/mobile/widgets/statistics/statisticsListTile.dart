import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';

class StatisticsListTile extends StatelessWidget {
  final int stationID;
  final StationMoneyReport? report;

  const StatisticsListTile({super.key, this.report, required this.stationID});

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
                "Пост $stationID",
                style: theme.textTheme.titleLarge,
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Center(
                child: Text(
                  report != null ? "${(report!.coins ?? 0)}" : "...",
                  style: theme.textTheme.titleLarge,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Center(
                child: Text(
                  report != null ? "${(report!.banknotes ?? 0)}" : "...",
                  style: theme.textTheme.titleLarge,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Center(
                child: Text(
                  report != null ? "${(report!.electronical ?? 0)}" : "...",
                  style: theme.textTheme.titleLarge,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Center(
                child: Text(
                  report != null ? "${(report!.carsTotal ?? 0)}" : "...",
                  style: theme.textTheme.titleLarge,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "Сервисные: ",
              style: theme.textTheme.titleMedium,
            ),
            Text(
              report != null ? "${report!.service ?? 0}" : "...",
              style: theme.textTheme.titleMedium!,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "Средний чек: ",
              style: theme.textTheme.titleMedium!.copyWith(color: theme.primaryColor),
            ),
            Text(
              report != null ? "${(((report!.coins ?? 0) + (report!.banknotes ?? 0) + (report!.electronical ?? 0)) / (report!.carsTotal ?? 1)).toStringAsFixed(2)}" : "...",
              style: theme.textTheme.titleMedium!.copyWith(color: theme.primaryColor),
            ),
          ],
        ),
      ],
    );
  }
}
