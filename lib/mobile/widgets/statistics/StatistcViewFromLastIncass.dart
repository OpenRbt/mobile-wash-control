import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/mobile/widgets/common/snackBars.dart';
import 'package:mobile_wash_control/mobile/widgets/statistics/statisticsListTile.dart';
import 'package:mobile_wash_control/repository/repository.dart';

class StatisticsViewFromLastIncass extends StatelessWidget {
  final Repository repository;

  Map<int, StationMoneyReport?> _moneyReports = Map();

  StatisticsViewFromLastIncass({super.key, required this.repository});

  Future<void> _loadMoneyReports(BuildContext context) async {
    var startTime = DateTime.now();
    var total = StationMoneyReport(banknotes: 0, electronical: 0, carsTotal: 0, coins: 0, service: 0);

    List<Future> futures = List.generate(12, (index) async {
      final res = await repository.getStationMoneyReport(index + 1, context: context);
      _moneyReports[index + 1] = res;
    });
    await Future.wait(futures);

    for (int i = 1; i <= 12; i++) {
      var res = _moneyReports[i];
      if (res != null) {
        total.banknotes = (total.banknotes ?? 0) + (res.banknotes ?? 0);
        total.electronical = (total.electronical ?? 0) + (res.electronical ?? 0);
        total.carsTotal = (total.carsTotal ?? 0) + (res.carsTotal ?? 0);
        total.coins = (total.coins ?? 0) + (res.coins ?? 0);
        total.service = (total.service ?? 0) + (res.service ?? 0);
      }
    }
    // for (int i = 1; i <= 12; i++) {
    //   final res = await repository.getStationMoneyReport(i, context: context);
    //   _moneyReports[i] = res;
    //
    //   if (res != null) {
    //     total.banknotes = (total.banknotes ?? 0) + (res.banknotes ?? 0);
    //     total.electronical = (total.electronical ?? 0) + (res.electronical ?? 0);
    //     total.carsTotal = (total.carsTotal ?? 0) + (res.carsTotal ?? 0);
    //     total.coins = (total.coins ?? 0) + (res.coins ?? 0);
    //     total.service = (total.service ?? 0) + (res.service ?? 0);
    //   }
    // }
    _moneyReports[0] = total;
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
          itemCount: 13,
          itemBuilder: (context, index) {
            if (index < 12) {
              return StatisticsListTile(
                title: "Пост ${index + 1}",
                report: _moneyReports[index + 1],
              );
            } else {
              return StatisticsListTile(
                title: "Итого",
                report: _moneyReports[0],
              );
            }
          },
        );
      },
    );
  }
}
