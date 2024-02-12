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
        LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Row(
                children: [
                  Container(
                    width: constraints.maxWidth * 0.4,
                    child: Text(
                      "Итого",
                      style: theme.textTheme.titleLarge!.copyWith(color: theme.primaryColor),
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.2,
                    child: Center(
                      child: Text(
                        "${report.coins ?? 0}",
                        style: theme.textTheme.titleLarge!.copyWith(color: theme.primaryColor),
                      ),
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.2,
                    child: Center(
                      child: Text(
                        "${report.banknotes ?? 0}",
                        style: theme.textTheme.titleLarge!.copyWith(color: theme.primaryColor),
                      ),
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.2,
                    child: Center(
                      child: Text(
                        "${report.electronical ?? 0}",
                        style: theme.textTheme.titleLarge!.copyWith(color: theme.primaryColor),
                      ),
                    ),
                  ),
                ],
              );
            }
        ),
        Row(),
      ],
    );
  }
}
