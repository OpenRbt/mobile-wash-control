import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/SharedData.dart';
import 'package:mobile_wash_control/application/Application.dart';
import 'package:mobile_wash_control/mobile/PostMenuEdit.dart';
import 'package:mobile_wash_control/mobile/widgets/overview/stationCard.dart';

class OverviewPage extends StatefulWidget {
  final SessionData sessionData;

  const OverviewPage({super.key, required this.sessionData});

  @override
  State<StatefulWidget> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    SharedData.CanUpdateStatus = true;
  }

  @override
  void didPushNext() {
    SharedData.CanUpdateStatus = false;
  }

  @override
  void didPop() {
    SharedData.CanUpdateStatus = false;
  }

  @override
  void didPopNext() {
    SharedData.CanUpdateStatus = true;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SharedData.RefreshStatus();
    var theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Обзор"),
      ),
      drawer: prepareDrawer(context, Pages.Main, widget.sessionData),
      body: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: SharedData.StationsData,
            builder: (BuildContext context, List<HomePageData> values, Widget? child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Всего постов: ${values.length}",
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      "Активно: ${values.where((element) => element.status == "online").length}",
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      "Статус кассы: ${SharedData.StatusKasse.value ?? "Нет данных"}",
                      style: theme.textTheme.titleMedium,
                    )
                  ],
                ),
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: SharedData.StationsData,
            builder: (BuildContext context, List<HomePageData> values, Widget? child) {
              if (SharedData.StationsData.value.isEmpty || SharedData.StationsData.value.length == 0) {
                return child ?? Container();
              }
              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  shrinkWrap: true,
                  itemCount: SharedData.StationsData.value.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var data = SharedData.StationsData.value[index];
                    return StationCard(
                      data: data,
                      onPressed: () {
                        var args = PostMenuArgs(
                          data.id,
                          data.ip,
                          data.hash,
                          data.currentProgramID,
                          widget.sessionData,
                        );
                        Navigator.pushNamed(context, "/mobile/editPost", arguments: args);
                      },
                    );
                  },
                ),
              );
            },
            child: Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
