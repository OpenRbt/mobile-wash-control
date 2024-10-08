import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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

  final GlobalKey<FormState> editGroupKey = GlobalKey<FormState>();
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
        Navigator.pop(context, true);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.tr('group_management')),
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
                  Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Text(
                              "${context.tr('name')}",
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: TextFormField(
                              controller: _controllers["organizationName"],
                              enabled: false,
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
                              "${context.tr('description')}",
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: TextFormField(
                              maxLines: null,
                              controller: _controllers["organizationDescription"],
                              enabled: false,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
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
                                TextEditingController firstController = TextEditingController(text: data?.name);
                                TextEditingController secondController = TextEditingController(text: data?.description);
                                showDialog(
                                    context: context,
                                    builder: (context) =>  TwoFieldDialog(
                                      title: "${context.tr('edit')}",
                                      firstFieldName: '${context.tr('name')}',
                                      seconFieldName: '${context.tr('description')}',
                                      firstController: firstController,
                                      secondController: secondController,
                                      validateKey: editGroupKey,
                                      actions:[
                                        Center(
                                          child: Column(
                                            children: [
                                              ProgressButton(
                                                onPressed: () async {
                                                  if (editGroupKey.currentState!.validate()){
                                                    WashAdminRepository.updateServerGroup(
                                                        entity.ServerGroup(
                                                          id: data?.id ?? "",
                                                          name: firstController.text,
                                                          description: secondController.text,
                                                          organizationId: currentOrganizationID,
                                                        )
                                                    );
                                                    Navigator.pop(context);
                                                    setState(() {});
                                                  }
                                                },
                                                child: Text("${context.tr('save')}"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(context.tr('cancel')),
                                              ),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  await WashAdminRepository.deleteServerGroup(data?.id ?? "");;
                                                  Navigator.pop(context);
                                                  setState(() {});
                                                },
                                                child: Text("${context.tr('delete')}"),
                                              ),

                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                );
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
                                title: "${context.tr('add')}",
                                firstFieldName: '${context.tr('name')}',
                                seconFieldName: '${context.tr('description')}',
                                firstController: firstController,
                                secondController: secondController,
                                validateKey: addGroupKey,
                                actions:[
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(context.tr('cancel')),
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
                                    child: Text("${context.tr('add')}"),
                                  )
                                ],
                              )
                          );
                        },
                        child: Text("${context.tr('add')}"),
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
