import 'package:flutter/material.dart';

import 'package:mobile_wash_control/entity/entity.dart' as entity;
import 'package:mobile_wash_control/mobile/widgets/common/ProgressButton.dart';
import 'package:mobile_wash_control/mobile/widgets/common/ProgressTextButton.dart';
import 'package:mobile_wash_control/mobile/dialogs/standardDialog/two_field_dialog.dart';
import 'package:mobile_wash_control/mobile/widgets/overview/wash_server_card.dart';
import 'package:mobile_wash_control/repository/wash_admin_repo/repository.dart';

import '../../entity/vo/page_args_codes.dart';

class CurrentGroupView extends StatefulWidget {

  const CurrentGroupView({Key? key}) : super(key: key);


  @override
  State<CurrentGroupView> createState() => _CurrentGroupViewState();
}

class _CurrentGroupViewState extends State<CurrentGroupView> {

  late entity.ServerGroup? serverGroup;
  late List<entity.WashServer>? washServers;

  final GlobalKey<FormState> editGroupKey = GlobalKey<FormState>();
  final GlobalKey<FormState> addWashServerKey = GlobalKey<FormState>();
  final GlobalKey<FormState> editWashServerKey = GlobalKey<FormState>();

  Map<String, TextEditingController> _controllers = Map();

  @override
  void initState() {
    super.initState();
    _controllers["groupName"] = TextEditingController();
    _controllers["groupDescription"] = TextEditingController();
  }

  @override
  void dispose() {
    for (var element in _controllers.values) {
      element.dispose();
    }

    super.dispose();
  }

  Future<void> getPageData(String currentGroupID, String currentOrganizationID) async {
    serverGroup = await WashAdminRepository.getServerGroup(currentGroupID);
    washServers = await WashAdminRepository.getWashServers(currentOrganizationID);

    _controllers["groupName"]!.text = serverGroup?.name ?? "";
    _controllers["groupDescription"]!.text = serverGroup?.description ?? "";
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    var args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final String currentOrganizationID = args[PageArgCode.currentOrganizationID];
    final String currentGroupID = args[PageArgCode.currentGroupID];

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, -1);
        //await routeMaster.pop();
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("Организация ${currentOrganizationID}, группа ${currentGroupID}"),
            actions: [
              IconButton(
                onPressed: () async {
                  WashAdminRepository.deleteServerGroup(currentGroupID);
                },
                icon: const Icon(Icons.delete_forever_outlined),
              ),
            ],
          ),
          body: FutureBuilder<void>(
            future: getPageData(currentGroupID, currentOrganizationID),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  Card(
                    child: Column(
                      children: [
                        Form(
                          key: editGroupKey,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      "Название группы",
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: TextFormField(
                                      controller: _controllers["groupName"],
                                      onChanged: (val) {
                                        //_config.value = _config.value.copyWith(name: val);
                                      },
                                      validator: (val) {
                                        if ((val ?? "").trim().isEmpty) {
                                          return "Поле не может быть пустым";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      "Описание группы",
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: TextFormField(
                                      maxLines: null,
                                      controller: _controllers["groupDescription"],
                                      onChanged: (val) {},
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ProgressTextButton(
                                    onPressed: () async {
                                      if (editGroupKey.currentState!.validate()){
                                        WashAdminRepository.updateServerGroup(
                                            entity.ServerGroup(
                                              id: currentGroupID,
                                              name: _controllers["groupName"]!.text,
                                              description:_controllers["groupDescription"]!.text,
                                            )
                                        );
                                      }
                                    },
                                    child: const Text("${context.tr('save')}"),
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    flex: 1,
                                    child: ProgressTextButton(
                                      onPressed: () async {
                                        await getPageData(currentGroupID, currentOrganizationID);
                                      },
                                      child: const Text(
                                        "Получить текущую конфигурацию",
                                        softWrap: true,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: (washServers?.length ?? 0),
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (BuildContext context,
                          int index) {
                        var data = washServers?[index];
                        return WashServerCard(
                          data: (data ?? entity.WashServer()),
                          onPressed: () {
                            TextEditingController firstController = TextEditingController(text: washServers?[index].name);
                            TextEditingController secondController = TextEditingController(text: washServers?[index].description);
                            showDialog(
                                context: context,
                                builder: (context) =>  TwoFieldDialog(
                                  title: "Редактировать сервер",
                                  firstFieldName: 'Название',
                                  seconFieldName: 'Описание',
                                  firstController: firstController,
                                  secondController: secondController,
                                  validateKey: editWashServerKey,
                                  actions:[
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(context.tr('cancel')),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await WashAdminRepository.deleteWashServer((washServers?[index].id ?? ""));
                                        print(washServers?[index].id);
                                      },
                                      child: const Text("Удалить"),
                                    ),
                                    ProgressButton(
                                      onPressed: () async {
                                        if (editWashServerKey.currentState!.validate()){
                                          WashAdminRepository.updateWashServer(
                                              entity.WashServer(
                                                id: washServers?[index].id,
                                                name: firstController.text,
                                                description: secondController.text,
                                              )
                                          );
                                          print(firstController.text);
                                          print(secondController.text);
                                        }
                                      },
                                      child: const Text("${context.tr('save')}"),
                                    )
                                  ],
                                )
                            );
                            //routeMaster.push("/organizations/$index");
                          },
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        TextEditingController firstController = TextEditingController();
                        TextEditingController secondController = TextEditingController();
                        showDialog(
                            context: context,
                            builder: (context) =>  TwoFieldDialog(
                              title: "Создать сервер",
                              firstFieldName: 'Название',
                              seconFieldName: 'Описание',
                              firstController: firstController,
                              secondController: secondController,
                              validateKey: addWashServerKey,
                              actions:[
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(context.tr('cancel')),
                                ),
                                ProgressButton(
                                  onPressed: () async {
                                    if (addWashServerKey.currentState!.validate()){
                                      await WashAdminRepository.createWashServer(
                                          (currentGroupID),
                                          entity.WashServer(
                                            name: firstController.text,
                                            description: secondController.text,
                                          )
                                      );
                                      print(firstController.text);
                                      print(secondController.text);
                                    }
                                  },
                                  child: const Text("Создать"),
                                )
                              ],
                            )
                        );
                      },
                      child: const Text("Добавить сервер"),
                    ),
                  )
                ],
              );
            },
          )
      ),
    );
  }
}
