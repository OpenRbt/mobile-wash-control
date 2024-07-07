import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:easy_localization/easy_localization.dart';

class StatisticsView extends StatefulWidget {
  final List<StationMoneyReport> reports;

  const StatisticsView({super.key, required this.reports});

  @override
  State<StatefulWidget> createState() => _StatisticsViewState();
}

class _StatisticsViewState extends State<StatisticsView> {
  ScrollController _scrollableController = ScrollController();
  ScrollController _viewScrollController = ScrollController();
  final _dateFormatter = DateFormat('dd.MM.yyyy HH:mm:ss');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollableController.dispose();
    _viewScrollController.dispose();
    super.dispose();
  }

  DataTable getStatic(ThemeData theme) {
    final columns = [
      DataColumn(
        label: Text(
          "${context.tr('post')}",
          style: theme.textTheme.titleLarge,
        ),
      ),
    ];
    final rows = List.generate(
      widget.reports.length,
      (index) => DataRow(
        cells: [
          DataCell(
            Text(
              widget.reports[index].post!.toString(),
              style: theme.textTheme.titleLarge,
            ),
          ),
        ],
      ),
    )..add(
        DataRow(
          cells: [
            DataCell(
              Text(
                'total'.tr(),
                style: theme.textTheme.titleLarge!.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      );
    return DataTable(
      columns: columns,
      rows: rows,
    );
  }

  DataTable getScrollable(ThemeData theme) {
    final total = StationMoneyReport(coins: 0, banknotes: 0, electronical: 0, qrMoney: 0, bonuses: 0, service: 0, carsTotal: 0);
    widget.reports.forEach((report) {
      total.coins = total.coins! + (report.coins ?? 0);
      total.banknotes = total.banknotes! + (report.banknotes ?? 0);
      total.electronical = total.electronical! + (report.electronical ?? 0);
      total.qrMoney = total.qrMoney! + (report.qrMoney ?? 0);
      total.service = total.service! + (report.service ?? 0);
      total.bonuses = total.bonuses! + (report.bonuses ?? 0);
      total.carsTotal = total.carsTotal! + (report.carsTotal ?? 0);
    });

    final bool addCtime = widget.reports.where((element) => element.dateTime != null).isNotEmpty;

    var columns = [
      DataColumn(
        label: Text(
          'coins'.tr(),
          style: theme.textTheme.titleLarge,
        ),
      ),
      DataColumn(
        label: Text(
          'banknotes'.tr(),
          style: theme.textTheme.titleLarge,
        ),
      ),
      DataColumn(
        label: Text(
          'electronic'.tr(),
          style: theme.textTheme.titleLarge,
        ),
      ),
      DataColumn(
        label: Text(
          'qr_payments'.tr(),
          style: theme.textTheme.titleLarge,
        ),
      ),
      DataColumn(
        label: Text(
          'bonuses'.tr(),
          style: theme.textTheme.titleLarge,
        ),
      ),
      DataColumn(
        label: Text(
          'service_money'.tr(),
          style: theme.textTheme.titleLarge,
        ),
      ),
      DataColumn(
        label: Text(
          'cars_count'.tr(),
          style: theme.textTheme.titleLarge,
        ),
      ),
      DataColumn(
        label: Text(
          'average_bill'.tr(),
          style: theme.textTheme.titleLarge,
        ),
      ),
    ];
    if (addCtime) {
      columns.add(
        DataColumn(
          label: Text(
            'date'.tr(),
            style: theme.textTheme.titleLarge,
          ),
        ),
      );
    }
    var rows = List.generate(
      widget.reports.length,
      (index) {
        var row = DataRow(
          cells: [
            DataCell(
              Text(
                widget.reports[index].coins?.toString() ?? "0",
                style: theme.textTheme.titleMedium,
              ),
            ),
            DataCell(
              Text(
                widget.reports[index].banknotes?.toString() ?? "0",
                style: theme.textTheme.titleMedium,
              ),
            ),
            DataCell(
              Text(
                widget.reports[index].electronical?.toString() ?? "0",
                style: theme.textTheme.titleMedium,
              ),
            ),
            DataCell(
              Text(
                widget.reports[index].qrMoney?.toString() ?? "0",
                style: theme.textTheme.titleMedium,
              ),
            ),
            DataCell(
              Text(
                widget.reports[index].bonuses?.toString() ?? "0",
                style: theme.textTheme.titleMedium,
              ),
            ),
            DataCell(
              Text(
                widget.reports[index].service?.toString() ?? "0",
                style: theme.textTheme.titleMedium,
              ),
            ),
            DataCell(
              Text(
                widget.reports[index].carsTotal?.toString() ?? "0",
                style: theme.textTheme.titleMedium,
              ),
            ),
            DataCell(
              Text(
                widget.reports[index].Average().toStringAsFixed(2),
                style: theme.textTheme.titleMedium,
              ),
            ),
          ],
        );

        if (addCtime) {
          row.cells.add(
            DataCell(
              Text(
                _dateFormatter.format(widget.reports[index].dateTime!),
                style: theme.textTheme.titleMedium,
              ),
            ),
          );
        }

        return row;
      },
    );
    var totalRow = DataRow(
      cells: [
        DataCell(
          Text(
            total.coins.toString(),
            style: theme.textTheme.titleMedium!.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        DataCell(
          Text(
            total.banknotes?.toString() ?? "0",
            style: theme.textTheme.titleMedium!.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        DataCell(
          Text(
            total.electronical?.toString() ?? "0",
            style: theme.textTheme.titleMedium!.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        DataCell(
          Text(
            total.qrMoney?.toString() ?? "0",
            style: theme.textTheme.titleMedium!.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        DataCell(
          Text(
            total.bonuses?.toString() ?? "0",
            style: theme.textTheme.titleMedium!.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        DataCell(
          Text(
            total.service?.toString() ?? "0",
            style: theme.textTheme.titleMedium!.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        DataCell(
          Text(
            total.carsTotal?.toString() ?? "0",
            style: theme.textTheme.titleMedium!.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        DataCell(
          Text(
            total.Average().toStringAsFixed(2),
            style: theme.textTheme.titleMedium!.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
    if (addCtime) {
      totalRow.cells.add(DataCell(Container()));
    }

    rows.add(totalRow);

    return DataTable(columns: columns, rows: rows);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scrollbar(
      thumbVisibility: true,
      controller: _viewScrollController,
      child: SingleChildScrollView(
        controller: _viewScrollController,
        scrollDirection: Axis.vertical,
        child: Row(
          children: [
            getStatic(theme),
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                controller: _scrollableController,
                child: SingleChildScrollView(
                  controller: _scrollableController,
                  scrollDirection: Axis.horizontal,
                  child: getScrollable(theme),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
