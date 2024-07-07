import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:easy_localization/easy_localization.dart';

class IncasHistoryView extends StatefulWidget {
  final List<StationCollectionReport> reports;

  const IncasHistoryView({super.key, required this.reports});

  @override
  State<StatefulWidget> createState() => _IncasHistoryViewState();
}

class _IncasHistoryViewState extends State<IncasHistoryView> {

  final _dateFormatter = DateFormat('dd.MM.yyyy');
  final _timeFormatter = DateFormat('HH:mm:ss');

  ScrollController _scrollableController = ScrollController();
  ScrollController _viewScrollController = ScrollController();

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
          'date'.tr(),
          style: theme.textTheme.titleLarge,
        ),
      ),
    ];
    final rows = List.generate(
      widget.reports.length,
      (index) => DataRow(
        cells: [
          DataCell(
            Column(
              children: [
                Text(
                  "${widget.reports[index].ctime != null ? _dateFormatter.format(widget.reports[index].ctime!) : 'no_data'.tr()}",
                  style: theme.textTheme.titleLarge,
                ),
                Text(
                  "${widget.reports[index].ctime != null ? _timeFormatter.format(widget.reports[index].ctime!) : 'no_data'.tr()}",
                  style: theme.textTheme.titleMedium,
                )
              ],
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
      total.bonuses = total.bonuses! + (report.bonuses ?? 0);
      total.service = total.service! + (report.service ?? 0);
    });

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
    ];
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
          ],
        );

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
      ],
    );

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
