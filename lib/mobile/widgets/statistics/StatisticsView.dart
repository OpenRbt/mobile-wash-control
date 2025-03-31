import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/mobile/widgets/statistics/FullStatisticsView.dart';
import 'package:mobile_wash_control/mobile/widgets/statistics/PartStatisticsView.dart';

enum StatisticsViewMode { full, part }

class StatisticsView extends StatefulWidget {
  final List<StationMoneyReport> reports;

  const StatisticsView({super.key, required this.reports});

  @override
  State<StatisticsView> createState() => _StatisticsViewState();
}

class _StatisticsViewState extends State<StatisticsView> {

  ValueNotifier<StatisticsViewMode> _mode = ValueNotifier(StatisticsViewMode.full);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<StatisticsViewMode>(
          valueListenable: _mode,
          builder: (BuildContext context, StatisticsViewMode value, Widget? child) {
            return SegmentedButton<StatisticsViewMode>(
              segments: [
                ButtonSegment(
                  value: StatisticsViewMode.full,
                  label: Text(context.tr('full_statistics')),
                ),
                ButtonSegment(
                  value: StatisticsViewMode.part,
                  label: Text(context.tr('part_statistics')),
                ),
              ],
              selected: {value},
              multiSelectionEnabled: false,
              onSelectionChanged: (val) {
                _mode.value = val.single;
              },
            );
          },
        ),
        ValueListenableBuilder(
          valueListenable: _mode,
          builder: (BuildContext context, StatisticsViewMode mode, Widget? child) {
            switch (mode) {
              case StatisticsViewMode.full:
                return FullStatisticsView(reports: widget.reports);
              case StatisticsViewMode.part:
                return PartStatisticsView(reports: widget.reports);
            }

          },
        )
      ],
    );
  }
}
