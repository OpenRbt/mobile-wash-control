import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/common/washNavigationDrawer.dart';
import 'package:mobile_wash_control/mobile/widgets/overview/stationCard.dart';
import 'package:mobile_wash_control/repository/lea_central_wash_repo/repository.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<StatefulWidget> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final repository = args[PageArgCode.repository] as LeaCentralRepository;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Главная"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Касса: "),
                ValueListenableBuilder(
                  valueListenable: repository.getKasseStatusNotifier(),
                  builder: (BuildContext context, KasseStatus? value, Widget? child) {
                    return Text(
                      "${value?.status ?? "Нет данных"}",
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: WashNavigationDrawer(
        selected: SelectedPage.Main,
        repository: repository,
      ),
      body: FutureBuilder(
        future: repository.updateStatus(context: context),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ValueListenableBuilder(
                  valueListenable: repository.getStationsNotifier(),
                  builder: (BuildContext context, List<Station>? value, Widget? child) {
                    if (value == null) {
                      return child!;
                    }
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.length,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          var data = value[index];
                          return StationCard(
                            data: data,
                            onPressed: () {
                              var args = Map<PageArgCode, dynamic>();
                              args[PageArgCode.repository] = repository;
                              args[PageArgCode.stationID] = data.id;
                              args[PageArgCode.stationHash] = data.hash;
                              Navigator.pushNamed(context, "/mobile/home/managePost", arguments: args);
                            },
                          );
                        },
                      ),
                    );
                  },
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
