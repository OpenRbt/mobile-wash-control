import 'package:flutter/material.dart';

import 'package:mobile_wash_control/mobile/dialogs/standardDialog/two_field_dialog.dart';
import 'package:mobile_wash_control/mobile/widgets/overview/server_group_card.dart';
import 'package:mobile_wash_control/entity/entity.dart' as entity;
import 'package:mobile_wash_control/mobile/widgets/common/ProgressButton.dart';
import 'package:mobile_wash_control/mobile/widgets/common/ProgressTextButton.dart';
import 'package:mobile_wash_control/repository/wash_admin_repo/repository.dart';

import '../../entity/vo/page_args_codes.dart';

class CurrentOrganizationView extends StatefulWidget {

  const CurrentOrganizationView({Key? key}) : super(key: key);

  @override
  State<CurrentOrganizationView> createState() => _CurrentOrganizationViewState();
}

class _CurrentOrganizationViewState extends State<CurrentOrganizationView> {

  late entity.Organization? currentOrganization;
  late List<entity.ServerGroup>? serverGroups;

  final GlobalKey<FormState> editOrganizationKey = GlobalKey<FormState>();
  final GlobalKey<FormState> addGroupKey = GlobalKey<FormState>();

  Map<String, TextEditingController> _controllers = Map();

  @override
  void initState() {
    super.initState();
    _controllers["organizationName"] = TextEditingController();
    _controllers["organizationDescription"] = TextEditingController();
  }

  @override
  void dispose() {
    for (var element in _controllers.values) {
        element.dispose();
      }

    super.dispose();
  }

  Future<void> getPageData(String currentOrganizationID) async {
    currentOrganization = await WashAdminRepository.getOrganization((currentOrganizationID));
    serverGroups = await WashAdminRepository.getServerGroups((currentOrganizationID));

    _controllers["organizationName"]!.text = currentOrganization?.name ?? "";
    _controllers["organizationDescription"]!.text = currentOrganization?.description ?? "";
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    var args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final String currentOrganizationID = args[PageArgCode.currentOrganizationID];

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, -1);
        //await routeMaster.pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Организация ${currentOrganizationID}"),
          actions: [
            IconButton(
              onPressed: () async {
                await WashAdminRepository.deleteOrganization((currentOrganizationID));
                //Navigator.pop(context, -1);
              },
              icon: const Icon(Icons.delete_forever_outlined),
            ),
          ],
        ),
        body: FutureBuilder<void>(
            future: getPageData(currentOrganizationID),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Card(
                child: Column(
                children: [
                  Form(
                  key: editOrganizationKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Text(
                              "Название организации",
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: TextFormField(
                              controller: _controllers["organizationName"],
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
                              "Описание организации",
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: TextFormField(
                              maxLines: null,
                              controller: _controllers["organizationDescription"],
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
                              if (editOrganizationKey.currentState!.validate()){
                                await WashAdminRepository.updateOrganization(
                                    entity.Organization(
                                      id: currentOrganizationID,
                                      name: _controllers["organizationName"]!.text,
                                      description: _controllers["organizationDescription"]!.text,
                                    )
                                );
                              }
                            },
                            child: const Text("Сохранить"),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 1,
                            child: ProgressTextButton(
                              onPressed: () async {
                                await getPageData(currentOrganizationID);
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
                          itemCount: (serverGroups?.length ?? 0),
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (BuildContext context,
                              int index) {
                            var data = serverGroups?[index];
                            return ServerGroupCard(
                              data: (data ?? entity.ServerGroup()),
                              onPressed: () {
                                print(index);
                                var args = Map<PageArgCode, dynamic>();
                                args[PageArgCode.currentOrganizationID] = currentOrganizationID;
                                args[PageArgCode.currentGroupID] = data?.id;
                                Navigator.pushNamed(context, "/mobile/services/current-organization/current-group", arguments: args);
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
                                title: "Добавить группу",
                                firstFieldName: 'Название',
                                seconFieldName: 'Описание',
                                firstController: firstController,
                                secondController: secondController,
                                validateKey: addGroupKey,
                                actions:[
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Отмена"),
                                  ),
                                  ProgressButton(
                                    onPressed: () async {
                                      if (addGroupKey.currentState!.validate()){
                                        WashAdminRepository.createServerGroup(
                                          currentOrganizationID ?? "",
                                            entity.ServerGroup(
                                                name: firstController.text,
                                                description: secondController.text,
                                            ),
                                        );
                                        print(firstController.text);
                                        print(secondController.text);
                                      }
                                    },
                                    child: const Text("Добавить"),
                                  )
                                ],
                              )
                          );
                        },
                        child: const Text("Добавить группу"),
                      ),
                    )
                  ],
                ),
              );
            }
        )
      ),
    );
  }
}
