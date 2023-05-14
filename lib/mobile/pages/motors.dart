import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/dialogs/motors/resetMotorsStatsDialog.dart';
import 'package:mobile_wash_control/mobile/widgets/common/washNavigationDrawer.dart';
import 'package:mobile_wash_control/mobile/widgets/motors/motorStatsListTile.dart';
import 'package:mobile_wash_control/mobile/widgets/motors/relayStatsListTile.dart';
import 'package:mobile_wash_control/repository/repository.dart';

class MotorPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MotorPageState();
}

class _MotorPageState extends State<MotorPage> {
  ValueNotifier<bool> _showMode = ValueNotifier(true);
  ValueNotifier<bool> _showRelays = ValueNotifier(true);

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

  Future<void> _loadStationsStats(Repository repository, BuildContext context, bool byDates, DateTimeRange range) async {
    _stationStats.clear();
    for (int i = 1; i <= 12; i++) {
      _stationStats[i] = await (byDates ? repository.getStationStatsByDates(i, range.start, range.end, context: context) : repository.getStationStatsCurrent(i, context: context));

      await Future.delayed(Duration(milliseconds: 100));
    }

    return;
  }

  @override
  void dispose() {
    _showMode.dispose();
    _dateRange.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final Repository repository = args[PageArgCode.repository];

    return Scaffold(
      appBar: AppBar(
        title: Text("Моторесурс"),
        actions: [
          TextButton.icon(
            onPressed: () async {
              await showGeneralDialog(
                context: context,
                pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                  return ResetMotorsStatsDialog(repository: repository);
                },
              );
            },
            icon: Icon(
              Icons.clear_all,
              color: theme.colorScheme.onPrimary,
            ),
            label: Text(
              "Сбросить статистику",
              style: theme.textTheme.titleMedium!.copyWith(color: theme.colorScheme.onPrimary),
            ),
          ),
        ],
      ),
      drawer: WashNavigationDrawer(
        selected: SelectedPage.Motors,
        repository: repository,
      ),
      body: Column(
        children: [
          Card(
            child: ExpansionTile(
              title: Text(
                "Параметры отображения",
                style: theme.textTheme.titleLarge,
              ),
              childrenPadding: EdgeInsets.all(8),
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "текущая статистика",
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: _showMode,
                      builder: (BuildContext context, bool value, Widget? child) {
                        return Switch(
                          value: value,
                          onChanged: (value) {
                            _showMode.value = value;
                          },
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "по датам",
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "статистика программ",
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: _showRelays,
                      builder: (BuildContext context, bool value, Widget? child) {
                        return Switch(
                          value: value,
                          onChanged: (value) {
                            _showRelays.value = value;
                          },
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "статистика реле",
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
                ValueListenableBuilder(
                  valueListenable: _showMode,
                  builder: (BuildContext context, bool value, Widget? child) {
                    if (value) {
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
                                    "Период с ",
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                  Text(
                                    _dateFormatter.format(value.start),
                                    style: theme.textTheme.bodyLarge!.copyWith(color: theme.primaryColor),
                                  ),
                                  Text(
                                    " по ",
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                  Text(
                                    _dateFormatter.format(value.end),
                                    style: theme.textTheme.bodyLarge!.copyWith(color: theme.primaryColor),
                                  ),
                                ],
                              );
                            },
                          ),
                          ElevatedButton(
                            onPressed: () async {
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
                            },
                            child: Text("Выбрать период"),
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: StatefulBuilder(
              builder: (context, setState) {
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      setState(() {});
                    },
                    child: ValueListenableBuilder(
                      valueListenable: _showMode,
                      builder: (BuildContext context, bool byDates, Widget? child) {
                        return ValueListenableBuilder(
                          valueListenable: _dateRange,
                          builder: (BuildContext context, DateTimeRange dateRange, Widget? child) {
                            return FutureBuilder(
                              future: _loadStationsStats(repository, context, byDates, dateRange),
                              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                                if (snapshot.connectionState != ConnectionState.done) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                return ListView.builder(
                                  itemCount: 12,
                                  itemBuilder: (context, index) {
                                    return ValueListenableBuilder(
                                      valueListenable: _showRelays,
                                      builder: (BuildContext context, bool showRelayStats, Widget? child) {
                                        if (showRelayStats) {
                                          return RelayStatsListTile(
                                            id: index + 1,
                                            stats: _stationStats[index + 1],
                                          );
                                        }
                                        return MotorStatsListTile(
                                          id: index + 1,
                                          stats: _stationStats[index + 1],
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
