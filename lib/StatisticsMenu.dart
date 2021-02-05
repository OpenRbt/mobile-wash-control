import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';

class StatisticsMenuArgs {}

class StatisticsMenu extends StatefulWidget {
  @override
  _StatisticsMenuState createState() => _StatisticsMenuState();
}

class _StatisticsMenuState extends State<StatisticsMenu> {
  _StatisticsMenuState() : super();

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      title: Text("Статистика"),
    );

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar,
      drawer: prepareDrawer(context, Pages.Statistics),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return new SizedBox(
            height: screenH - appBar.preferredSize.height,
            width: screenW,
            child: Text("EmptySpace"),
          );
        },
      ),
    );
  }
}
