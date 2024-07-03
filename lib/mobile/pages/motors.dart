import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/dialogs/motors/resetMotorsStatsDialog.dart';
import 'package:mobile_wash_control/mobile/widgets/common/snackBars.dart';
import 'package:mobile_wash_control/mobile/widgets/common/washNavigationDrawer.dart';
import 'package:mobile_wash_control/mobile/widgets/motors/MotorsView.dart';
import 'package:mobile_wash_control/repository/repository.dart';

class MotorPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MotorPageState();
}

enum MotorStatsViewMode { current, dates }

class _MotorPageState extends State<MotorPage> {
  ValueNotifier<bool> _showMode = ValueNotifier(true);
  ValueNotifier<bool> _showRelays = ValueNotifier(true);
  ValueNotifier<MotorStatsViewMode> _statsMode = ValueNotifier(MotorStatsViewMode.current);
  ValueNotifier<MotorsViewMode> _mode = ValueNotifier(MotorsViewMode.relays);

  ValueNotifier<DateTimeRange> _dateRange = ValueNotifier(DateTimeRange(start: DateTime.now(), end: DateTime.now()));

  final _dateFormatter = DateFormat('dd.MM.yyyy');

  @override
  void initState() {
    var now = DateTime.now();

    _dateRange.value = DateTimeRange(
      start: DateTime(now.year, now.month, 1),
      end: DateTime(now.year, now.month, now.day).add(Duration(days: 1, microseconds: -1)),
    );

    super.initState();
  }

  Map<int, StationStats?> _stationStats = Map();

  Future<List<StationStats>> _loadAllStationsStats(Repository repository, BuildContext context) async {
    List<StationStats> res = [];

    var startTime = DateTime.now();

    res = await repository.getAllStationStatsCurrent(context: context);

    var timeTotal = DateTime.now().difference(startTime);
    ScaffoldMessenger.of(context).showSnackBar(SnackBars.getInfoSnackBar(message: "${context.tr('statistics_uploaded_in')} ${timeTotal.inSeconds}.${timeTotal.inMilliseconds % 1000} ${context.tr('seconds')}"));
    return res;
  }

  Future<List<StationStats>> _loadAllStationsStatsByDates(Repository repository, DateTimeRange range, BuildContext context) async {
    List<StationStats> res = [];

    var startTime = DateTime.now();

    res = await repository.getAllStationStatsByDates(range.start, range.end, context: context);

    var timeTotal = DateTime.now().difference(startTime);
    ScaffoldMessenger.of(context).showSnackBar(SnackBars.getInfoSnackBar(message: "${context.tr('statistics_uploaded_in')} ${timeTotal.inSeconds}.${timeTotal.inMilliseconds % 1000} ${context.tr('seconds')}"));
    return res;
  }

  @override
  void dispose() {
    _mode.dispose();
    _showMode.dispose();
    _dateRange.dispose();
    _statsMode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final Repository repository = args[PageArgCode.repository];

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('motor_life')),
        actions: [
          TextButton.icon(
            onPressed: () async {
              await showGeneralDialog(
                context: context,
                pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                  return ResetMotorsStatsDialog(repository: repository);
                },
              );
              setState(() {});
            },
            icon: Icon(
              Icons.clear_all,
              color: theme.colorScheme.onPrimary,
            ),
            label: Text(
              context.tr('reset'),
              style: theme.textTheme.titleMedium!.copyWith(color: theme.colorScheme.onPrimary),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
              });
            },
            icon: Icon(Icons.refresh)
          ),
        ],
      ),
      drawer: WashNavigationDrawer(
        selected: SelectedPage.Motors,
        repository: repository,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ValueListenableBuilder(
                  valueListenable: _statsMode,
                  builder: (BuildContext context, MotorStatsViewMode value, Widget? child) {
                    return SegmentedButton<MotorStatsViewMode>(
                      segments: [
                        ButtonSegment(
                          value: MotorStatsViewMode.current,
                          label: Text(context.tr('current')),
                        ),
                        ButtonSegment(
                          value: MotorStatsViewMode.dates,
                          label: Text(context.tr('by_dates')),
                        ),
                      ],
                      selected: {value},
                      onSelectionChanged: (val) {
                        _statsMode.value = val.single;
                      },
                    );
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: _statsMode,
                  builder: (BuildContext context, MotorStatsViewMode value, Widget? child) {
                    bool canSelectDates = value == MotorStatsViewMode.dates;

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
                          onPressed: canSelectDates
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
                        ),
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
                valueListenable: _statsMode,
                builder: (BuildContext context, MotorStatsViewMode mode, Widget? child) {
                  switch (mode) {
                    case MotorStatsViewMode.current:
                      return FutureBuilder(
                        future: _loadAllStationsStats(repository, context),
                        builder: (BuildContext context, AsyncSnapshot<List<StationStats>> snapshot) {
                          if (snapshot.connectionState != ConnectionState.done) {
                            return Column(
                              children: [
                                LinearProgressIndicator(),
                                Expanded(
                                  child: MotorsView(
                                    stationsStats: [],
                                    mode: _mode,
                                  ),
                                ),
                              ],
                            );
                          }
                          return MotorsView(stationsStats: snapshot.data ?? [], mode: _mode);
                        },
                      );

                    case MotorStatsViewMode.dates:
                      return ValueListenableBuilder(
                        valueListenable: _dateRange,
                        builder: (BuildContext context, DateTimeRange dateRange, Widget? child) {
                          return FutureBuilder(
                            future: _loadAllStationsStatsByDates(repository, dateRange, context),
                            builder: (BuildContext context, AsyncSnapshot<List<StationStats>> snapshot) {
                              if (snapshot.connectionState != ConnectionState.done) {
                                return Column(
                                  children: [
                                    LinearProgressIndicator(),
                                    Expanded(
                                      child: MotorsView(
                                        stationsStats: [],
                                        mode: _mode,
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return MotorsView(stationsStats: snapshot.data ?? [], mode: _mode,);
                            },
                          );
                        },
                      );
                  }
                },
              ),
            ),
          ),
          // Expanded(
          //   child: StatefulBuilder(
          //     builder: (context, setState) {
          //       return Padding(
          //         padding: EdgeInsets.all(8),
          //         child: RefreshIndicator(
          //           onRefresh: () async {
          //             setState(() {});
          //           },
          //           child: ValueListenableBuilder(
          //             valueListenable: _showMode,
          //             builder: (BuildContext context, bool byDates, Widget? child) {
          //               return ValueListenableBuilder(
          //                 valueListenable: _dateRange,
          //                 builder: (BuildContext context, DateTimeRange dateRange, Widget? child) {
          //                   return FutureBuilder(
          //                     future: _loadStationsStats(repository, context, byDates, dateRange),
          //                     builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          //                       if (snapshot.connectionState != ConnectionState.done) {
          //                         return Center(
          //                           child: CircularProgressIndicator(),
          //                         );
          //                       }
          //
          //                       return ListView.builder(
          //                         itemCount: 12,
          //                         itemBuilder: (context, index) {
          //                           return ValueListenableBuilder(
          //                             valueListenable: _showRelays,
          //                             builder: (BuildContext context, bool showRelayStats, Widget? child) {
          //                               if (showRelayStats) {
          //                                 return RelayStatsListTile(
          //                                   id: index + 1,
          //                                   stats: _stationStats[index + 1],
          //                                 );
          //                               }
          //                               return MotorStatsListTile(
          //                                 id: index + 1,
          //                                 stats: _stationStats[index + 1],
          //                               );
          //                             },
          //                           );
          //                         },
          //                       );
          //                     },
          //                   );
          //                 },
          //               );
          //             },
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
