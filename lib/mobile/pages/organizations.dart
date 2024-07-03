import 'package:flutter/material.dart';

import 'package:mobile_wash_control/mobile/widgets/overview/organization_card.dart';
import 'package:mobile_wash_control/entity/entity.dart' as entity;
import 'package:mobile_wash_control/mobile/widgets/common/ProgressButton.dart';
import 'package:mobile_wash_control/mobile/dialogs/standardDialog/two_field_dialog.dart';
import 'package:mobile_wash_control/repository/wash_admin_repo/repository.dart';

import '../../entity/vo/page_args_codes.dart';

class OrganizationsView extends StatefulWidget {
  const OrganizationsView({Key? key}) : super(key: key);

  @override
  State<OrganizationsView> createState() => _OrganizationsViewState();
}

class _OrganizationsViewState extends State<OrganizationsView> {

  final GlobalKey<FormState> addOrganizationKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, -1);
        //await routeMaster.pop();
        return false;
      },
      child: Scaffold(
          appBar: AppBar(title: const Text(context.tr('organizations'))),
          body: FutureBuilder<List<entity.Organization>?>(
              future: WashAdminRepository.getOrganizations(),
              builder: (BuildContext context, AsyncSnapshot<List<entity.Organization>?> snapshot) {
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
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: (snapshot.data?.length ?? 0),
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (BuildContext context,
                                  int index) {
                                var data = snapshot.data?[index];
                                return OrganizationCard(
                                  data: (data ?? entity.Organization()),
                                  onPressed: () {
                                    var args = Map<PageArgCode, dynamic>();
                                    args[PageArgCode.currentOrganizationID] = data?.id;
                                    Navigator.pushNamed(context, "/mobile/services/current-organization", arguments: args);
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
                                      validateKey: addOrganizationKey,
                                      actions:[
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(context.tr('cancel')),
                                        ),
                                        ProgressButton(
                                          onPressed: () async {
                                            if (addOrganizationKey.currentState!.validate()) {
                                              await WashAdminRepository.createOrganization(entity.Organization(
                                                name: firstController.text,
                                                description: secondController.text,
                                              ));
                                              print(firstController.text);
                                              print(secondController.text);
                                            }
                                          },
                                          child: const Text("${context.tr('add')}"),
                                        )
                                      ],
                                    )
                                );

                              },
                              child: const Text("${context.tr('add')}"),
                            ),
                          )
                        ]
                    )

                );
              }
          )
      ),
    );
  }
}
