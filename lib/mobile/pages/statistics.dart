import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/common/washNavigationDrawer.dart';
import 'package:mobile_wash_control/mobile/widgets/statistics/statisticsListTile.dart';
import 'package:mobile_wash_control/repository/repository.dart';

class StatisticsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StatisctisPageState();
}

class _StatisctisPageState extends State<StatisticsPage> {
  Map<int, List<StationMoneyReport>> _stationReports = Map();

  ValueNotifier<bool> _showMode = ValueNotifier(true);

  ValueNotifier<DateTimeRange> _dateRange = ValueNotifier(DateTimeRange(start: DateTime.now(), end: DateTime.now()));

  final _dateFormatter = DateFormat('dd.MM.yyyy');
  final _numberFormatter = NumberFormat("#####");

  @override
  void initState() {
    var now = DateTime.now();

    _dateRange.value = DateTimeRange(
      start: DateTime(now.year, now.month, 1),
      end: DateTime(now.year, now.month, now.day).add(Duration(days: 1, microseconds: -1)),
    );

    super.initState();
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
    final args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final Repository repository = args[PageArgCode.repository];

    return Scaffold(
      appBar: AppBar(title: Text("Статистика")),
      drawer: WashNavigationDrawer(
        selected: SelectedPage.Statistics,
        repository: repository,
      ),
      body: Column(
        children: [
          Card(
            child: ExpansionTile(
              title: Text(
                "Режим отображения",
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
                        "с последней инкассации",
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
                          )
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Center(
                    child: Text(
                      "Пост",
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Center(child: Icon(Icons.circle_outlined)),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Center(child: Icon(Icons.money)),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Center(child: Icon(Icons.credit_card_outlined)),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Center(child: Icon(Icons.directions_car_outlined)),
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(child: StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setState) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
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
                          return ListView.builder(
                            itemCount: 12,
                            itemBuilder: (context, index) {
                              return FutureBuilder(
                                future: byDates ? repository.getStationMoneyReportsByDates(index + 1, dateRange.start, dateRange.end) : repository.getStationMoneyReport(index + 1),
                                builder: (BuildContext context, AsyncSnapshot<StationMoneyReport?> snapshot) {
                                  final report = snapshot.data;

                                  return StatisticsListTile(
                                    stationID: index + 1,
                                    report: report,
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
          )),
        ],
      ),
    );
  }
}
