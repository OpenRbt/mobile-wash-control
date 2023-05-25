import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/mobile/widgets/common/snackBars.dart';
import 'package:mobile_wash_control/mobile/widgets/statistics/statisticsListTile.dart';
import 'package:mobile_wash_control/repository/repository.dart';

class StatisticsViewLastIncass extends StatelessWidget {
  final Repository repository;

  Map<int, StationMoneyReport?> _moneyReports = Map();

  StatisticsViewLastIncass({super.key, required this.repository});

  Future<void> _loadMoneyReports(BuildContext context) async {
    var startTime = DateTime.now();
    _moneyReports = await repository.lastCollectionReportsStats(context: context);
    var timeTotal = DateTime.now().difference(startTime);
    ScaffoldMessenger.of(context).showSnackBar(SnackBars.getInfoSnackBar(message: "Статистика загружена за ${timeTotal.inSeconds}.${timeTotal.inMilliseconds % 1000} секунд"));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadMoneyReports(context),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: 12,
          itemBuilder: (context, index) {
            return StatisticsListTile(
              title: "Пост ${index + 1}",
              report: _moneyReports[index + 1],
            );
          },
        );
      },
    );
  }
}
