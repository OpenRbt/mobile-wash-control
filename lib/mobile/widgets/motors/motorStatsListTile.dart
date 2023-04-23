import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';

class MotorStatsListTile extends StatelessWidget {
  final int id;
  final StationStats? stats;

  const MotorStatsListTile({super.key, this.stats, required this.id});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Программа",
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
            children: List.generate(stats?.programStats?.length ?? 0, (index) {
              final programStat = stats!.programStats![index];
              final programTimeOn = Duration(seconds: programStat.timeOn ?? 0);
              return Row(
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        programStat.programName ?? "Программа ${programStat.programID ?? "-"}",
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
                        _durationFormat(programTimeOn),
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ),
                ],
              );
            }),
          )
        ],
      ),
    );
  }

  String _durationFormat(Duration d) {
    return "${d.inHours.toString().padLeft(2, "0")}:${d.inMinutes.remainder(60).toString().padLeft(2, "0")}:${d.inSeconds.remainder(60).toString().padLeft(2, "0")}";
  }
}
