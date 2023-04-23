import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
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

  var _isSnackBarActive = ValueWrapper(false);

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

  // TODO: recreate functional
  // class PostMenuArgs {
  // final int postID;
  // final String ip;
  // final String hash;
  // final int currentProgramID;
  // final SessionData sessionData;
  //
  // PostMenuArgs(this.postID, this.ip, this.hash, this.currentProgramID, this.sessionData);
  // }
  //
  // void _programButtonListener(index, PostMenuArgs postMenuArgs) async {
  //   if (index != _currentProgram) {
  //     try {
  //       var args = ArgRunProgram(
  //         hash: postMenuArgs.hash,
  //         preflight: false, programID: -1, //TODO: use preflight trigger
  //       );
  //       await postMenuArgs.sessionData.client.runProgram(args);
  //       setState(() {});
  //     } catch (e) {
  //       print("Exception when calling DefaultApi->runProgram in EditPostMenu: $e\n");
  //       showInfoSnackBar(context, _scaffoldKey, _isSnackBarActive, "Произошла ошибка при запросе к api", Colors.red);
  //     }
  //   } else {
  //     try {
  //       var args = ArgRunProgram(
  //         hash: postMenuArgs.hash,
  //         programID: -1,
  //         preflight: false, //TODO: use preflight trigger
  //       );
  //       await postMenuArgs.sessionData.client.runProgram(args);
  //       setState(() {});
  //     } catch (e) {
  //       print("Exception when calling DefaultApi->runProgram in EditPostMenu: $e\n");
  //       showInfoSnackBar(context, _scaffoldKey, _isSnackBarActive, "Произошла ошибка при запросе к api", Colors.red);
  //     }
  //   }
  // }

  ValueNotifier<int> _addAmount = ValueNotifier(GlobalData.AddServiceValue);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    var args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final Repository repository = args[PageArgCode.repository];
    final int stationID = args[PageArgCode.stationID];

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _currentProgram);
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: FutureBuilder(
            future: repository.getStationMoneyReport(stationID),
            builder: (BuildContext context, AsyncSnapshot<StationMoneyReport?> snapshot) {
              var moneyReport = snapshot.data;
              return Text("Пост: $stationID | Инкасс: ${(moneyReport?.banknotes ?? 0) + (moneyReport?.coins ?? 0)} руб");
            },
          ),
        ),
        body: FutureBuilder(
          future: repository.getStationButtons(stationID),
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
                                        final int? balance = value
                                            ?.firstWhere((element) => element.id == stationID, orElse: null)
                                            .currentBalance;

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
                        Row(
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
                        ElevatedButton(
                          child: Text(
                            "Отправить",
                            style: TextStyle(fontSize: 15),
                          ),
                          onPressed: () {
                            repository.addServiceMoney(stationID, GlobalData.AddServiceValue);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
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
                                      await repository.stationSaveCollection(stationID);
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
                                      await repository.stationOpenDoor(stationID);
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
                ),
                Card(
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
                                //_programButtonListener(index, postMenuArgs);
                                //
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
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
