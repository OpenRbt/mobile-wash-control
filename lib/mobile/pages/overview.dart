import 'dart:developer';

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

enum PostsViewMode { all, active }

class _OverviewPageState extends State<OverviewPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _postsMode.dispose();
    super.dispose();
  }

  ValueNotifier<PostsViewMode> _postsMode = ValueNotifier(PostsViewMode.all);
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
                    Center(
                      heightFactor: 1.5,
                      child: ValueListenableBuilder(
                        valueListenable: _postsMode,
                        builder: (BuildContext context, PostsViewMode value, Widget? child) {
                          return SegmentedButton<PostsViewMode>(
                            segments: [
                              ButtonSegment(
                                value: PostsViewMode.all,
                                label: Text("Все"),
                              ),
                              ButtonSegment(
                                value: PostsViewMode.active,
                                label: Text("Активные"),
                              ),
                            ],
                            selected: {value},
                            onSelectionChanged: (val) {
                              _postsMode.value = val.single;
                            },
                          );
                        },
                      ),
                    ),
                    ValueListenableBuilder(
                        valueListenable: repository.getStationsNotifier(),
                        builder: (BuildContext context, List<Station>? stations, Widget? child) {
                          return ValueListenableBuilder(
                              valueListenable: _postsMode,
                              builder: (BuildContext context, PostsViewMode postViewMode, Widget? _) {
                                if (stations == null) {
                                  return Center(child: CircularProgressIndicator());
                                }

                                List<Station> filteredStations;

                                if (postViewMode == PostsViewMode.active) {
                                  filteredStations = stations.where((station) => station.status == "online").toList();
                                } else {
                                  filteredStations = stations;
                                }

                                return Expanded(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: filteredStations.length,
                                        physics: ClampingScrollPhysics(),
                                        itemBuilder: (BuildContext context, int index) {
                                          var data = filteredStations[index];
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
                                        }
                                    )
                                );
                              }
                          );
                        }
                    )
                  ],
                ),
              );
            },
          ),
    );
  }
}
