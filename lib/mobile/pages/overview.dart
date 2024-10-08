import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/common/washNavigationDrawer.dart';
import 'package:mobile_wash_control/mobile/widgets/overview/stationCard.dart';
import 'package:mobile_wash_control/repository/lea_central_wash_repo/repository.dart';
import 'package:easy_localization/easy_localization.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<StatefulWidget> createState() => _OverviewPageState();
}

enum PostsViewMode { hashes, active }

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

  Widget buildServiceStatusIcon(IconData mainIcon, bool serviceAvailable, Function onPressed) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          icon: Icon(mainIcon, color: Colors.white),
          iconSize:  30.0,
          splashRadius: 30,
          onPressed: () {
            onPressed();
          },
        ),
        if (!serviceAvailable)
          Positioned(
            top: 10,
            right: 10,
            child: Opacity(
              opacity: 1,
              child: CustomPaint(
                painter: CrossPainter(color: Color.fromRGBO(73, 61, 71, 1)),
                size: Size(10, 10),
              ),
            ),
          )
      ],
    );
  }
  ValueNotifier<PostsViewMode> _postsMode = ValueNotifier(PostsViewMode.hashes);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final repository = args[PageArgCode.repository] as LeaCentralRepository;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(context.tr('overview')),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("${context.tr('cash_desk')}: "),
                ValueListenableBuilder(
                  valueListenable: repository.getKasseStatusNotifier(),
                  builder: (BuildContext context, KasseStatus? value, Widget? child) {
                    return Text(
                      "${value?.status ?? context.tr('no_data')}",
                    );
                  },
                ),
                SizedBox(width: 20.0),

                ValueListenableBuilder(
                  valueListenable: repository.getBonusStatusNotifier(),
                  builder: (BuildContext context, ServiceStatus? srvStat, Widget? child) {
                    if (srvStat?.isConnected != true){
                      return Container();
                    }
                    return buildServiceStatusIcon(Icons.monetization_on, srvStat?.available == true, () {
                      var args = Map<PageArgCode, dynamic>();
                      args[PageArgCode.repository] = repository;
                      Navigator.pushNamed(context, "/mobile/home/bonus-status", arguments: args);
                    });
                  },
                ),
                SizedBox(width: 20.0),

                ValueListenableBuilder(
                  valueListenable: repository.getSbpStatusNotifier(),
                  builder: (BuildContext context, ServiceStatus? sbpStat, Widget? child) {
                    if (sbpStat?.isConnected != true){
                      return Container();
                    }
                    return buildServiceStatusIcon(Icons.qr_code_2, sbpStat?.available == true, () {
                      var args = Map<PageArgCode, dynamic>();
                      args[PageArgCode.repository] = repository;
                      Navigator.pushNamed(context, "/mobile/home/sbp-status", arguments: args);
                    });
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
                                value: PostsViewMode.hashes,
                                label: Text(context.tr('all')),
                              ),
                              ButtonSegment(
                                value: PostsViewMode.active,
                                label: Text(context.tr('active')),
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
                                } else if(postViewMode == PostsViewMode.hashes) {
                                  filteredStations = stations.where((station) => (station.hash?.isNotEmpty ?? false)).toList();
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

class CrossPainter extends CustomPainter {
  final Color color;

  CrossPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 4.0;

    canvas.drawLine(Offset(0, 0), Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
  }

  @override
  bool shouldRepaint(CrossPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
