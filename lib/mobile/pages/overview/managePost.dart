import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/dialogs/overview/ConfirmRunProgram.dart';
import 'package:mobile_wash_control/mobile/widgets/common/snackBars.dart';
import 'package:mobile_wash_control/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManagePostPage extends StatefulWidget {
  const ManagePostPage({super.key});

  @override
  State<StatefulWidget> createState() => _ManagePostPageState();
}

//TODO: Cleanup and rework
class _ManagePostPageState extends State<ManagePostPage> {
  @override
  void dispose() {
    _addAmount.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _currentProgram = -1;

  @override
  void initState() {
    super.initState();
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
          title: FutureBuilder(
            future: repository.getStationMoneyReport(stationID, context: context),
            builder: (BuildContext context, AsyncSnapshot<StationMoneyReport?> snapshot) {
              var moneyReport = snapshot.data;
              return (repository.currentUser()?.isAdmin ?? false)
                  ? Text(
                      "Пост: $stationID | Инкасс: ${(moneyReport?.banknotes ?? 0) + (moneyReport?.coins ?? 0)} руб",
                    )
                  : Text(
                      "Пост: $stationID",
                    );
            },
          ),
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
                          "Текущий Баланс",
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
                          "Добавить сервисные",
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
                                                  "$value руб",
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
                                  ElevatedButton(
                                    child: Text(
                                      "Отправить",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    onPressed: () {
                                      repository.addServiceMoney(stationID, GlobalData.AddServiceValue, context: context);
                                    },
                                  )
                                ],
                              )
                            : FutureBuilder(
                                future: repository.getConfigVarInt("DEFAULT_OPERATOR_SERVICE_MONEY", context: context),
                                builder: (BuildContext context, AsyncSnapshot<int?> snapshot) {
                                  if (snapshot.connectionState != ConnectionState.done) {
                                    return LinearProgressIndicator();
                                  }
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${snapshot.data ?? 10} руб",
                                          style: theme.textTheme.titleLarge,
                                        ),
                                      ),
                                      ElevatedButton(
                                        child: Text(
                                          "Отправить",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        onPressed: () {
                                          repository.addServiceMoney(stationID, snapshot.data ?? 10, context: context);
                                        },
                                      )
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
                            "Управление постом",
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
                                  "Инкассировать",
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text("Инкассировать"),
                                      content: Text("Вы уверены?"),
                                      actionsPadding: EdgeInsets.all(8),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            await repository.stationSaveCollection(stationID, context: context);
                                            Navigator.pop(context);
                                          },
                                          child: Text("Да"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Нет"),
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
                                  "Открыть дверь",
                                ),
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text("Открыть дверь"),
                                      content: Text("Вы уверены?"),
                                      actionsPadding: EdgeInsets.all(8),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            await repository.stationOpenDoor(stationID, context: context);
                                            Navigator.pop(context);
                                          },
                                          child: Text("Да"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Нет"),
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
                                  "История инкассаций",
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
                            "Кнопки поста",
                            style: theme.textTheme.bodyLarge,
                          ),
                          childrenPadding: EdgeInsets.all(8),
                          children: List.generate(_stationButtons.length, (index) {
                            var btn = _stationButtons[index];
                            return Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (stationHash != null) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ConfirmRunProgramDialog(config: RunProgramConfig(stationHash: stationHash, programID: btn.programID!, programName: btn.programName, stationID: stationID), repository: repository);
                                          },
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBars.getErrorSnackBar(
                                            message: "Не удалось вызвать запуск программы, так как нет данных о хэше станции",
                                          ),
                                        );
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "${btn.buttonID} : ",
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${btn.programName ?? "-"}",
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: ValueListenableBuilder(
                                    valueListenable: repository.getStationsNotifier(),
                                    builder: (BuildContext context, List<Station>? value, Widget? child) {
                                      var program = repository.getCurrentProgram(stationID);

                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Активна",
                                            style: theme.textTheme.bodyLarge,
                                          ),
                                          Checkbox(value: btn.programID == program?.id, onChanged: null)
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          }),
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
