import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/home/incassationHistoryListTile.dart';
import 'package:mobile_wash_control/mobile/widgets/home/incassationHistoryTotalListTile.dart';
import 'package:mobile_wash_control/repository/repository.dart';

class IncassationHistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IncassationHistoryPageState();
}

class _IncassationHistoryPageState extends State<IncassationHistoryPage> {
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
    _dateRange.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final Repository repository = args[PageArgCode.repository];
    final int id = args[PageArgCode.stationID];

    return Scaffold(
      appBar: AppBar(
        title: Text("Пост $id | История инкассаций"),
      ),
      body: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
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
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
                          ),
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
                              _dateRange.value = DateTimeRange(start: range.start, end: range.end.add(Duration(days: 1, microseconds: -1)));
                            }
                          },
                          child: Text("Выбрать период")),
                  )
                ],
              ),
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
                      valueListenable: _dateRange,
                      builder: (BuildContext context, DateTimeRange value, Widget? child) {
                        return FutureBuilder(
                          future: repository.getStationCollectionReports(id, _dateRange.value.start, _dateRange.value.end),
                          builder: (BuildContext context, AsyncSnapshot<List<StationCollectionReport>?> snapshot) {
                            StationCollectionReport total = StationCollectionReport(
                              id: 0,
                              carsTotal: 0,
                              coins: 0,
                              banknotes: 0,
                              electronical: 0,
                              service: 0,
                            );

                            if (snapshot.connectionState != ConnectionState.done) {
                              return Column(
                                children: [
                                  Expanded(child: Center(child: CircularProgressIndicator())),
                                  IncassationHistoryTotalListTile(report: total),
                                ],
                              );
                            }

                            snapshot.data?.forEach((element) {
                              total.carsTotal = (total.carsTotal ?? 0) + (element.carsTotal ?? 0);
                              total.coins = (total.coins ?? 0) + (element.coins ?? 0);
                              total.banknotes = (total.banknotes ?? 0) + (element.banknotes ?? 0);
                              total.electronical = (total.electronical ?? 0) + (element.electronical ?? 0);
                              total.service = (total.service ?? 0) + (element.service ?? 0);
                            });

                            return Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: snapshot.data?.length == null ? 1 : snapshot.data!.length + 1,
                                    itemBuilder: (BuildContext context, int index) {
                                      if (index == 0) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Row(
                                            children: [
                                              Flexible(
                                                fit: FlexFit.tight,
                                                child: Center(child: Icon(Icons.date_range_outlined)),
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
                                            ],
                                          ),
                                        );
                                      }
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4),
                                        child: IncassationHistoryListTile(report: snapshot.data![index - 1]),
                                      );
                                    },
                                  ),
                                ),
                                IncassationHistoryTotalListTile(report: total),
                              ],
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
