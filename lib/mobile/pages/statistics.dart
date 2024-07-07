import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/common/snackBars.dart';
import 'package:mobile_wash_control/mobile/widgets/common/washNavigationDrawer.dart';
import 'package:mobile_wash_control/mobile/widgets/statistics/StatisticsView.dart';
import 'package:mobile_wash_control/repository/repository.dart';
import 'package:easy_localization/easy_localization.dart';

class StatisticsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StatisticsPageState();
}

enum StatisticsShowMode { Dates, FromLastIncass, LastIncass }

class _StatisticsPageState extends State<StatisticsPage> with TickerProviderStateMixin {
  ValueNotifier<StatisticsShowMode> _mode = ValueNotifier(StatisticsShowMode.FromLastIncass);
  ValueNotifier<DateTimeRange> _dateRange = ValueNotifier(DateTimeRange(start: DateTime.now(), end: DateTime.now()));

  late final AnimationController _animationController;

  final _dateFormatter = DateFormat('dd.MM.yyyy');
  @override
  void initState() {
    var now = DateTime.now();

    _dateRange.value = DateTimeRange(
      start: DateTime(now.year, now.month, 1),
      end: DateTime(now.year, now.month, now.day).add(Duration(days: 1, microseconds: -1)),
    );

    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 2), // this will decide the speed of the rotation
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.stop();
    _animationController.dispose();
    _mode.dispose();
    _dateRange.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final Repository repository = args[PageArgCode.repository];

    return Scaffold(
      appBar: AppBar(
          title: Row(
            children: [
              Text(context.tr('statistics')),
              Align(
                alignment: Alignment.centerRight
              )
            ],
          ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: RotationTransition(
              turns: _animationController,
              child: Icon(Icons.refresh),
            ),
          ),
        ],
      ),
      drawer: WashNavigationDrawer(
        selected: SelectedPage.Statistics,
        repository: repository,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ValueListenableBuilder<StatisticsShowMode>(
                  valueListenable: _mode,
                  builder: (BuildContext context, StatisticsShowMode value, Widget? child) {
                    return SegmentedButton<StatisticsShowMode>(
                      segments: [
                        ButtonSegment(
                          value: StatisticsShowMode.FromLastIncass,
                          label: Text(context.tr('from_last_collection')),
                        ),
                        ButtonSegment(
                          value: StatisticsShowMode.Dates,
                          label: Text(context.tr('by_dates')),
                        ),
                        ButtonSegment(
                          value: StatisticsShowMode.LastIncass,
                          label: Text(context.tr('last_collection')),
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
                  builder: (BuildContext context, StatisticsShowMode mode, Widget? child) {
                    bool canSelectDates = mode == StatisticsShowMode.Dates;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ValueListenableBuilder(
                          valueListenable: _dateRange,
                          builder: (BuildContext context, DateTimeRange value, Widget? child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${context.tr('period')} ${context.tr('from')} ",
                                  style: canSelectDates ? theme.textTheme.bodyLarge : theme.textTheme.bodyLarge!.copyWith(color: theme.disabledColor),
                                ),
                                Text(
                                  _dateFormatter.format(value.start),
                                  style: canSelectDates ? theme.textTheme.bodyLarge!.copyWith(color: theme.primaryColor) : theme.textTheme.bodyLarge!.copyWith(color: theme.disabledColor),
                                ),
                                Text(
                                  " ${context.tr('to')} ",
                                  style: canSelectDates ? theme.textTheme.bodyLarge : theme.textTheme.bodyLarge!.copyWith(color: theme.disabledColor),
                                ),
                                Text(
                                  _dateFormatter.format(value.end),
                                  style: canSelectDates ? theme.textTheme.bodyLarge!.copyWith(color: theme.primaryColor) : theme.textTheme.bodyLarge!.copyWith(color: theme.disabledColor),
                                ),
                              ],
                            );
                          },
                        ),
                        ElevatedButton(
                          onPressed: mode == StatisticsShowMode.Dates
                              ? () async {
                                  DateTimeRange? range = await showDateRangePicker(
                                    context: context,
                                    firstDate: DateTime(2018),
                                    lastDate: DateTime.now(),
                                    initialEntryMode: DatePickerEntryMode.calendar,
                                    initialDateRange: DateTimeRange(
                                      start: _dateRange.value.start,
                                      end: _dateRange.value.end,
                                    ),
                                  );
                                  if (range != null) {
                                    _dateRange.value = DateTimeRange(
                                      start: range.start,
                                      end: range.end.add(
                                        Duration(days: 1, microseconds: -1),
                                      ),
                                    );
                                  }
                                }
                              : null,
                          child: Text("${context.tr('choose_period')}"),
                        )
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ValueListenableBuilder(
                valueListenable: _mode,
                builder: (BuildContext context, StatisticsShowMode value, Widget? child) {
                  switch (value) {
                    case StatisticsShowMode.Dates:
                      return ValueListenableBuilder(
                        valueListenable: _dateRange,
                        builder: (BuildContext context, DateTimeRange dateTimeRange, Widget? child) {
                          return FutureBuilder(
                            future: _loadStatisticsByDates(dateTimeRange, repository, context),
                            builder: (BuildContext context, AsyncSnapshot<List<StationMoneyReport>> snapshot) {
                              if (snapshot.connectionState != ConnectionState.done) {
                                return Column(
                                  children: [
                                    LinearProgressIndicator(),
                                    Expanded(
                                      child: StatisticsView(reports: snapshot.data ?? []),
                                    ),
                                  ],
                                );
                              }
                              if(snapshot.hasData){
                                return StatisticsView(reports: snapshot.data!);
                              }
                              return StatisticsView(reports: [],);
                            },
                          );
                        },
                      );
                    case StatisticsShowMode.FromLastIncass:
                      return FutureBuilder(
                        future: _loadStatisticsFromLastIncass(repository, context),
                        builder: (BuildContext context, AsyncSnapshot<List<StationMoneyReport>> snapshot) {
                          if (snapshot.connectionState != ConnectionState.done) {
                            return Column(
                              children: [
                                LinearProgressIndicator(),
                                Expanded(
                                  child: StatisticsView(reports: snapshot.data ?? []),
                                ),
                              ],
                            );
                          }
                          if(snapshot.hasData){
                            return StatisticsView(reports: snapshot.data!);
                          }
                          return StatisticsView(reports: [],);
                        },
                      );
                    case StatisticsShowMode.LastIncass:
                      return FutureBuilder(
                        future: _loadStatisticsLastIncass(repository, context),
                        builder: (BuildContext context, AsyncSnapshot<List<StationMoneyReport>> snapshot) {
                          if (snapshot.connectionState != ConnectionState.done) {
                            return Column(
                              children: [
                                LinearProgressIndicator(),
                                Expanded(
                                  child: StatisticsView(reports: snapshot.data ?? []),
                                ),
                              ],
                            );
                          }
                          if(snapshot.hasData){
                            return StatisticsView(reports: snapshot.data!);
                          }
                          return StatisticsView(reports: [],);
                        },
                      );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<StationMoneyReport>> _loadStatisticsByDates(DateTimeRange range, Repository repository, BuildContext context) async {
    List<StationMoneyReport> reports = [];
    var startTime = DateTime.now();

    for (int i = 0; i <= 12; i++) {
      final res = await repository.getStationMoneyReportByDates(i, range.start, range.end, context: context);
      if (res != null) {
        reports.add(res);
      }
    }

    var timeTotal = DateTime.now().difference(startTime);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBars.getInfoSnackBar(
        message: "${context.tr('statistics_uploaded_in')} ${timeTotal.inSeconds}.${timeTotal.inMilliseconds % 1000} ${context.tr('seconds')}",
      ),
    );

    return reports;
  }

  Future<List<StationMoneyReport>> _loadStatisticsLastIncass(Repository repository, BuildContext context) async {
    var startTime = DateTime.now();

    final reports = await repository.lastCollectionReportsStats(context: context);

    var timeTotal = DateTime.now().difference(startTime);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBars.getInfoSnackBar(
        message: "${context.tr('statistics_uploaded_in')} ${timeTotal.inSeconds}.${timeTotal.inMilliseconds % 1000} ${context.tr('seconds')}",
      ),
    );

    return reports;
  }

  Future<List<StationMoneyReport>> _loadStatisticsFromLastIncass(Repository repository, BuildContext context) async {
    List<StationMoneyReport> reports = [];
    var startTime = DateTime.now();

    for (int i = 0; i <= 12; i++) {
      final res = await repository.getStationMoneyReport(i + 1, context: context);
      if (res != null) {
        reports.add(res);
      }
    }

    var timeTotal = DateTime.now().difference(startTime);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBars.getInfoSnackBar(
        message: "${context.tr('statistics_uploaded_in')} ${timeTotal.inSeconds}.${timeTotal.inMilliseconds % 1000} ${context.tr('seconds')}",
      ),
    );

    return reports;
  }
}
