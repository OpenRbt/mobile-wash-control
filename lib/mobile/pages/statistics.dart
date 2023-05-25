import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/common/washNavigationDrawer.dart';
import 'package:mobile_wash_control/mobile/widgets/statistics/StatistcViewFromLastIncass.dart';
import 'package:mobile_wash_control/mobile/widgets/statistics/StatisticsViewDates.dart';
import 'package:mobile_wash_control/mobile/widgets/statistics/StatisticsViewLastIncass.dart';
import 'package:mobile_wash_control/repository/repository.dart';

class StatisticsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StatisticsPageState();
}

enum StatisticsShowMode { Dates, FromLastIncass, LastIncass }

class _StatisticsPageState extends State<StatisticsPage> {
  ValueNotifier<StatisticsShowMode> _mode = ValueNotifier(StatisticsShowMode.Dates);
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

  @override
  void dispose() {
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
                ValueListenableBuilder<StatisticsShowMode>(
                  valueListenable: _mode,
                  builder: (BuildContext context, StatisticsShowMode value, Widget? child) {
                    return SegmentedButton<StatisticsShowMode>(
                      segments: [
                        ButtonSegment(
                          value: StatisticsShowMode.Dates,
                          label: Text("По датам"),
                        ),
                        ButtonSegment(
                          value: StatisticsShowMode.FromLastIncass,
                          label: Text("С последней инкассации"),
                        ),
                        ButtonSegment(
                          value: StatisticsShowMode.LastIncass,
                          label: Text("Последняя инкассация"),
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
                  builder: (BuildContext context, StatisticsShowMode value, Widget? child) {
                    switch (value) {
                      case StatisticsShowMode.Dates:
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
                      case StatisticsShowMode.FromLastIncass:
                        return SizedBox();
                      case StatisticsShowMode.LastIncass:
                        return SizedBox();
                      default:
                        return SizedBox();
                    }
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
                        builder: (BuildContext context, DateTimeRange value, Widget? child) {
                          return StatisticsViewDates(dateTimeRange: value, repository: repository);
                        },
                      );
                    case StatisticsShowMode.FromLastIncass:
                      return StatisticsViewFromLastIncass(repository: repository);
                    case StatisticsShowMode.LastIncass:
                      return StatisticsViewLastIncass(repository: repository);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
