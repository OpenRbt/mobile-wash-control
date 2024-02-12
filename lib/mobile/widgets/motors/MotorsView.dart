import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';

class MotorsView extends StatefulWidget {
  final List<StationStats> stationsStats;
  final ValueNotifier<MotorsViewMode> mode;

  const MotorsView({super.key, required this.stationsStats, required this.mode});

  @override
  State<StatefulWidget> createState() => _MotorsViewState();
}

enum MotorsViewMode { relays, programs }

class _MotorsViewState extends State<MotorsView> {

  @override
  void dispose() {
    super.dispose();
  }

  Widget relaysTable(ThemeData theme) {
    final header = TableRow(
      children: [
        Text(
          "Пост",
          style: theme.textTheme.titleLarge,
        ),
        Row(
          children: [
            Container(
              width: 75,
              child: Text(
                "Реле",
                style: theme.textTheme.titleLarge,
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Text(
                "Включений",
                style: theme.textTheme.titleLarge,
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Text(
                "Время работы",
                style: theme.textTheme.titleLarge,
              ),
            ),
          ],
        ),
      ],
    );

    var content = List.generate(
      widget.stationsStats.length,
      (index) {
        final stats = widget.stationsStats[index];
        final haveRelayStats = (stats.relayStats?.length ?? 0) > 0;

        return TableRow(
          decoration: BoxDecoration(color: index % 2 == 1 ? null : Colors.black12),
          children: [
            Text(
              stats.id?.toString() ?? "",
              style: theme.textTheme.titleLarge,
            ),
            haveRelayStats
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      children: List.generate(
                        stats.relayStats?.length ?? 0,
                        (index) {
                          final relayStat = stats.relayStats![index];
                          final relayTimeOn = Duration(seconds: relayStat.totalTimeOn ?? 0);
                          return TableRow(
                            children: [
                              Text(
                                relayStat.relayID?.toString() ?? "",
                                style: theme.textTheme.titleMedium,
                              ),
                              Text(
                                relayStat.switchedCount?.toString() ?? "",
                                style: theme.textTheme.titleMedium,
                              ),
                              Text(
                                _durationFormat(relayTimeOn),
                                style: theme.textTheme.titleMedium!.copyWith(fontFamily: "RobotoMono"),
                              ),
                            ],
                          );
                        },
                      ),
                      columnWidths: {0: FixedColumnWidth(75)},
                    ),
                  )
                : Container(),
          ],
        );
      },
    );

    return Table(
      children: [header]..addAll(content),
      columnWidths: {
        0: FixedColumnWidth(75),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    );
  }

  Widget programsTable(ThemeData theme) {
    final header = TableRow(
      children: [
        Text(
          "Пост",
          style: theme.textTheme.titleLarge,
        ),
        Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: Text(
                "Программа",
                style: theme.textTheme.titleLarge,
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Text(
                "Время работы",
                style: theme.textTheme.titleLarge,
              ),
            ),
          ],
        ),
      ],
    );

    var content = List.generate(
      widget.stationsStats.length,
      (index) {
        final stats = widget.stationsStats[index];
        final haveProgramStats = (stats.programStats?.length ?? 0) > 0;
        return TableRow(
          decoration: BoxDecoration(color: index % 2 == 1 ? null : Colors.black12),
          children: [
            Text(
              stats.id?.toString() ?? "",
              style: theme.textTheme.titleLarge,
            ),
            haveProgramStats
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      children: List.generate(stats.programStats?.length ?? 0, (index) {
                        final programStat = stats.programStats![index];
                        final programTimeOn = Duration(seconds: programStat.timeOn ?? 0);

                        return TableRow(children: [
                          Text(
                            programStat.programName ?? "Программа ${programStat.programID ?? "_"}",
                            style: theme.textTheme.titleMedium,
                          ),
                          Text(
                            _durationFormat(programTimeOn),
                            style: theme.textTheme.titleMedium,
                          ),
                        ]);
                      }),
                    ),
                  )
                : Container(),
          ],
        );
      },
    );

    return Table(
      children: [header]..addAll(content),
      columnWidths: {
        0: FixedColumnWidth(75),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ValueListenableBuilder<MotorsViewMode>(
            valueListenable: widget.mode,
            builder: (BuildContext context, MotorsViewMode value, Widget? child) {
              return SegmentedButton<MotorsViewMode>(
                segments: [
                  ButtonSegment(
                    value: MotorsViewMode.relays,
                    label: Text("Статистика реле"),
                  ),
                  ButtonSegment(
                    value: MotorsViewMode.programs,
                    label: Text("Статистика программ"),
                  ),
                ],
                selected: {value},
                multiSelectionEnabled: false,
                onSelectionChanged: (val) {
                  widget.mode.value = val.single;
                },
              );
            },
          ),
        ),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: ValueListenableBuilder(
                  valueListenable: widget.mode,
                  builder: (BuildContext context, MotorsViewMode value, Widget? child) {
                    switch (value) {
                      case MotorsViewMode.relays:
                        return relaysTable(theme);
                      case MotorsViewMode.programs:
                        return programsTable(theme);
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _durationFormat(Duration d) {
    return "${d.inHours.toString()} ч ${d.inMinutes.remainder(60).toString()} мин ${d.inSeconds.remainder(60).toString()} сек";
  }
}
