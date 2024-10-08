import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/common/ProgressButton.dart';
import 'package:mobile_wash_control/mobile/widgets/home/managePost/WashPostButton.dart';
import 'package:mobile_wash_control/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class ManagePostPage extends StatefulWidget {
  const ManagePostPage({super.key});

  @override
  State<StatefulWidget> createState() => _ManagePostPageState();
}

//TODO: Cleanup and rework
class _ManagePostPageState extends State<ManagePostPage> with TickerProviderStateMixin {

  @override
  void dispose() {
    _animationController.stop();
    _animationController.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late final AnimationController _animationController;
  final ValueNotifier<int> refreshTrigger = ValueNotifier(0);
  bool _isRefreshing = false;
  int _currentProgram = -1;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2), // this will decide the speed of the rotation
      vsync: this,
    );
  }

  List<StationButton> _stationButtons = [];

  void _changeServiceValue({int value = 10}) async {
    GlobalData.AddServiceValue += value;
    if (GlobalData.AddServiceValue < 0) {
      GlobalData.AddServiceValue = 0;
    }

    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("AddServiceValue", GlobalData.AddServiceValue);
    _addAmount.value = GlobalData.AddServiceValue;
  }

  ValueNotifier<int> _addAmount = ValueNotifier(GlobalData.AddServiceValue);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    var args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final Repository repository = args[PageArgCode.repository];
    final int stationID = args[PageArgCode.stationID];
    final String? stationHash = args[PageArgCode.stationHash];

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _currentProgram);
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return FutureBuilder<StationMoneyReport?>(
                future: () async {
                  if (_isRefreshing) return null;
                  _isRefreshing = true;
                  _animationController.repeat();
                  var result = await repository.getStationMoneyReport(stationID, context: context);
                  _animationController.stop();
                  _isRefreshing = false;
                  return result;
                }(),
                builder: (BuildContext context, AsyncSnapshot<StationMoneyReport?> snapshot) {
                  var moneyReport = snapshot.data;
                  return Row(
                    children: [
                      Expanded(
                        child: (repository.currentUser()?.isAdmin ?? false)
                            ? Text(
                          "${context.tr('post')}: ${stationID} | ${context.tr('collect')}: ${(moneyReport?.banknotes ?? 0) + (moneyReport?.coins ?? 0)} ${context.tr('currency_value')}",
                        )
                            : Text(
                          "${context.tr('post')}: ${stationID}",
                        ),
                      )
                    ],
                  );
                },
              );
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: RotationTransition(
                turns: _animationController,
                child: Icon(Icons.refresh),
              ),
            ),
          ],
        ),
        body: FutureBuilder(
          future: repository.getStationButtons(stationID, context: context),
          builder: (BuildContext context, AsyncSnapshot<List<StationButton>?> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data != null) _stationButtons = snapshot.data!;

            return ListView(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          context.tr('current_balance'),
                          style: theme.textTheme.headlineSmall,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Container(),
                              ),
                              Flexible(
                                flex: 4,
                                fit: FlexFit.tight,
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  child: Center(
                                    child: ValueListenableBuilder(
                                      valueListenable: repository.getStationsNotifier(),
                                      builder: (BuildContext context, List<Station>? value, Widget? child) {
                                        final int? balance = value?.firstWhere((element) => element.id == stationID, orElse: null).currentBalance;
                                        return Text(
                                          "${balance ?? "-"}",
                                          style: theme.textTheme.bodyLarge,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Container(),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${context.tr('add')} ${context.tr('service_money')}",
                          style: theme.textTheme.titleLarge,
                        ),
                        (repository.currentUser()?.isAdmin ?? false)
                            ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.loose,
                                          child: IconButton(
                                            icon: Icon(Icons.remove_circle_outline),
                                            onPressed: () {
                                              _changeServiceValue(value: -10);
                                            },
                                          ),
                                        ),
                                        Flexible(
                                          flex: 2,
                                          fit: FlexFit.tight,
                                          child: Center(
                                            child: ValueListenableBuilder(
                                              valueListenable: _addAmount,
                                              builder: (BuildContext context, int value, Widget? child) {
                                                return Text(
                                                  "$value ${context.tr('currency_value')}",
                                                  style: theme.textTheme.titleLarge,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.loose,
                                          child: IconButton(
                                            icon: Icon(Icons.add_circle_outline),
                                            onPressed: () {
                                              _changeServiceValue(value: 10);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ProgressButton(
                                    onPressed: () async {
                                      await repository.addServiceMoney(stationID, GlobalData.AddServiceValue, context: context);
                                    },
                                    child: Text(
                                      context.tr('send'),
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              )
                            : FutureBuilder(
                                future: repository.getConfigVarInt("DEFAULT_OPERATOR_SERVICE_MONEY"),
                                builder: (BuildContext context, AsyncSnapshot<int?> snapshot) {
                                  if (snapshot.connectionState != ConnectionState.done) {
                                    return LinearProgressIndicator();
                                  }
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${snapshot.data ?? 10} ${context.tr('currency_value')}",
                                          style: theme.textTheme.titleLarge,
                                        ),
                                      ),
                                      ProgressButton(
                                        onPressed: () async {
                                          await repository.addServiceMoney(stationID, snapshot.data ?? 10, context: context);
                                        },
                                        child: Text(
                                          context.tr('send'),
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                      ],
                    ),
                  ),
                ),
                (repository.currentUser()?.isAdmin ?? false)
                    ? Card(
                        child: ExpansionTile(
                          title: Text(
                            context.tr('post_management'),
                            style: theme.textTheme.bodyLarge,
                          ),
                          children: [
                            ValueListenableBuilder(
                              valueListenable: repository.getStationsNotifier(),
                              builder: (BuildContext context, List<Station>? value, Widget? child) {
                                var ip = value?.firstWhere((element) => element.id == stationID).ip;
                                return Text(
                                  "IP: ${ip ?? "-"}",
                                  style: theme.textTheme.bodyLarge,
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: ElevatedButton(
                                child: Text(
                                  context.tr('collect'),
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(context.tr('collect'),),
                                      content: Text("${context.tr('are_you_sure')}?"),
                                      actionsPadding: EdgeInsets.all(8),
                                      actions: [
                                        ProgressButton(
                                          onPressed: () async {
                                            await repository.stationSaveCollection(stationID, context: context);
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                          child: Text(context.tr('yes')),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(context.tr('no')),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                child: Text(
                                  context.tr('open_lid'),
                                ),
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(context.tr('open_lid')),
                                      content: Text("${context.tr('are_you_sure')}?"),
                                      actionsPadding: EdgeInsets.all(8),
                                      actions: [
                                        ProgressButton(
                                          onPressed: () async {
                                            await repository.stationOpenDoor(stationID, context: context);
                                            Navigator.pop(context);
                                          },
                                          child: Text(context.tr('yes')),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(context.tr('no')),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                child: Text(
                                  context.tr('collections_history'),
                                ),
                                onPressed: () {
                                  var args = Map<PageArgCode, dynamic>();
                                  args[PageArgCode.repository] = repository;
                                  args[PageArgCode.stationID] = stationID;
                                  Navigator.pushNamed(context, "/mobile/home/incassation-history", arguments: args);
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(),
                (repository.currentUser()?.isAdmin ?? false)
                    ? Card(
                        child: ExpansionTile(
                          title: Text(
                            context.tr('post_buttons'),
                            style: theme.textTheme.bodyLarge,
                          ),
                          childrenPadding: EdgeInsets.all(8),
                          children: List.generate(
                            _stationButtons.length,
                            (index) => WashPostButton(
                              btn: _stationButtons[index],
                              stationHash: stationHash,
                              repository: repository,
                              stationID: stationID,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            );
          },
        ),
      ),
    );
  }
}
