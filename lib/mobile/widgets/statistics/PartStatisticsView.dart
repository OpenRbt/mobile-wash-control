import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:easy_localization/easy_localization.dart';

class PartStatisticsView extends StatefulWidget {
  final List<StationMoneyReport> reports;

  const PartStatisticsView({super.key, required this.reports});

  @override
  State<StatefulWidget> createState() => _PartStatisticsViewState();
}

class _PartStatisticsViewState extends State<PartStatisticsView> {
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
    final smallTextStyle = theme.textTheme.bodySmall;

    final columns = [
      DataColumn(
        label: Text(
          "${context.tr('post')}",
          style: smallTextStyle,
        ),
      ),
    ];

    final rows = List.generate(
      widget.reports.length,
          (index) => DataRow(
        cells: [
          DataCell(
            Text(
              widget.reports[index].post?.toString() ?? '',
              style: smallTextStyle,
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
              style: smallTextStyle!.copyWith(
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
      columnSpacing: 0,
      dataRowMinHeight: 24,
      headingRowHeight: 50,
      horizontalMargin: 8,
    );
  }

  DataColumn wrappedColumn(String text, TextStyle? style, {double width = 58}) {
    return DataColumn(
      label: SizedBox(
        width: width,
        child: Text(
          text,
          style: style,
          softWrap: true,
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  DataTable getScrollable(ThemeData theme) {
    final total = StationMoneyReport(coins: 0, banknotes: 0, electronical: 0, qrMoney: 0, bonuses: 0, service: 0, carsTotal: 0);
    widget.reports.forEach((report) {
      total.coins = total.coins! + (report.coins ?? 0);
      total.banknotes = total.banknotes! + (report.banknotes ?? 0);
    });

    final bool addCtime = widget.reports.where((element) => element.dateTime != null).isNotEmpty;
    final smallTextStyle = theme.textTheme.bodySmall;

    final columns = [
      wrappedColumn('coins'.tr(), smallTextStyle),
      wrappedColumn('banknotes'.tr(), smallTextStyle),
    ];

    if (addCtime) {
      columns.add(DataColumn(label: Text('date'.tr(), style: smallTextStyle)));
    }

    var rows = List.generate(widget.reports.length, (index) {
      final report = widget.reports[index];
      final cells = [
        DataCell(Text(report.coins?.toString() ?? "0", style: smallTextStyle)),
        DataCell(Text(report.banknotes?.toString() ?? "0", style: smallTextStyle)),
      ];
      if (addCtime) {
        cells.add(DataCell(Text(_dateFormatter.format(report.dateTime!), style: smallTextStyle)));
      }
      return DataRow(cells: cells);
    });

    var totalRow = DataRow(
      cells: [
        DataCell(
          Text(
            total.coins.toString(),
            style: theme.textTheme.titleSmall!.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        DataCell(
          Text(
            total.banknotes?.toString() ?? "0",
            style: theme.textTheme.titleSmall!.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
    if (addCtime) {
      totalRow.cells.add(DataCell(Container()));
    }

    return DataTable(
      columns: columns,
      rows: [...rows, totalRow],
      columnSpacing: 0,
      dataRowMinHeight: 24,
      headingRowHeight: 50,
      horizontalMargin: 8,
    );
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
              child: getScrollable(theme)
            ),
          ],
        ),
      ),
    );
  }
}
