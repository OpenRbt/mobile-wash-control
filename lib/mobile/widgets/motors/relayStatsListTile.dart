import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_wash_control/entity/entity.dart';

class RelayStatsListTile extends StatelessWidget {
  final int id;
  final StationStats? stats;

  DateFormat _dateFormat = DateFormat("hh:mm:ss");

  RelayStatsListTile({super.key, this.stats, required this.id});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final pumpTimeOn = Duration(seconds: stats?.pumpTimeOn ?? 0);

    return Card(
      child: ExpansionTile(
        title: Text(
          "Пост: $id",
          style: theme.textTheme.titleLarge,
        ),
        childrenPadding: EdgeInsets.all(8),
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: SizedBox(),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Включений",
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Время работы",
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: List.generate(stats?.relayStats?.length ?? 0, (index) {
              final relayStat = stats!.relayStats![index];
              final relayTimeOn = Duration(seconds: relayStat.totalTimeOn ?? 0);
              return Row(
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Реле ${relayStat.relayID ?? "-"}",
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${relayStat.switchedCount ?? 0}",
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          _durationFormat(relayTimeOn),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
          Divider(),
          Row(
            children: [
              Text(
                "Общее время работы насоса: ",
                style: theme.textTheme.titleMedium,
              ),
              Text(
                _durationFormat(pumpTimeOn),
                style: theme.textTheme.titleMedium!.copyWith(color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _durationFormat(Duration d) {
    return "${d.inHours.toString().padLeft(2, "0")}:${d.inMinutes.remainder(60).toString().padLeft(2, "0")}:${d.inSeconds.remainder(60).toString().padLeft(2, "0")}";
  }
}
