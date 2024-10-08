import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:easy_localization/easy_localization.dart';

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
        LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Row(
                children: [
                  Container(
                    width: constraints.maxWidth * 0.4,
                    child: Column(
                      children: [
                        Text(
                          "${report.ctime != null ? _dateFormatter.format(report.ctime!) : context.tr('no_data')}",
                          style: theme.textTheme.titleLarge,
                        ),
                        Text(
                          "${report.ctime != null ? _timeFormatter.format(report.ctime!) : context.tr('no_data')}",
                          style: theme.textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.2,
                    child: Center(
                      child: Text(
                        "${report.coins ?? 0}",
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.2,
                    child: Center(
                      child: Text(
                        "${report.banknotes ?? 0}",
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.1,
                    child: Center(
                      child: Text(
                        "${report.electronical ?? 0}",
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.1,
                    child: Center(
                      child: Text(
                        "${report.bonuses ?? 0}",
                        style: theme.textTheme.titleLarge,
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
