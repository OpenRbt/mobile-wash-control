import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart' as entity;
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/common/ProgressButton.dart';
import 'package:mobile_wash_control/mobile/widgets/common/washNavigationDrawer.dart';
import 'package:mobile_wash_control/mobile/widgets/overview/organizationCard.dart';
import 'package:mobile_wash_control/openapi/wash-admin-client/api.dart';
import 'package:mobile_wash_control/repository/repository.dart';
import 'package:mobile_wash_control/utils/common.dart';

import '../../entity/entity.dart';
import '../widgets/overview/stationCard.dart';
import '../widgets/servicesWashParams/servisecWashParamsView.dart';

class SettingsServicesPage extends StatefulWidget {
  const SettingsServicesPage({
    super.key,
  });

  @override
  State<SettingsServicesPage> createState() => _SettingsServicesPageState();
}

class _SettingsServicesPageState extends State<SettingsServicesPage> {
  ValueNotifier<entity.WashServer> _server = ValueNotifier(entity.WashServer());

  late TextEditingController _serverNameController;
  late TextEditingController _serverDescriptionController;

  Future<void> _RegisterWash(Repository repository) async {
    if (_serverNameController.text.isNotEmpty) {
      var arg = WashServerCreation(name: _serverNameController.text,
          description: _serverDescriptionController.text);

      try {
        final res = await Common.washServersApi!.createWashServer(body: arg);
        _server.value = _server.value.copyWith(
          id: res!.id,
          name: res!.name,
          serviceKey: res!.serviceKey,
        );
        print("pre save params");
        await _saveParams(repository);
      } on ApiException catch (e) {
        if (kDebugMode) print("WashAdminApiException: $e");
      } catch (e) {
        if (kDebugMode) print("OtherException: $e");
      }

      await _loadWashServer(repository);
    }
  }

  Future<void> _saveParams(Repository repository) async {
    if (_server.value.id?.isNotEmpty == true &&
        _server.value.serviceKey?.isNotEmpty == true) {
      try {
        await repository.setConfigVarString("server_id", _server.value.id!);
        await repository.setConfigVarString(
            "server_key", _server.value.serviceKey!);
      } catch (e) {
        if (kDebugMode) print("OtherException: $e");
      }

      return;
    }
  }

  Future<void> _loadWashServer(Repository repository) async {
    try {
      var id = await repository.getConfigVarString("server_id");
      var key = await repository.getConfigVarString("server_key");

      _server.value = _server.value.copyWith(id: id, serviceKey: key);

      await _getWashServer();
    } catch (e) {
      if (kDebugMode) print("_loadWashServer OtherException: $e");
    }
  }

  Future<void> _getWashServer() async {
    try {
      var washServer = await Common.washServersApi!.getWashServerById(
          _server.value.id!);

      _server.value = _server.value.copyWith(
        name: washServer?.name,
        serviceKey: washServer?.serviceKey,
        description: washServer?.description,
      );

      _serverNameController.text = _server.value.name ?? "";
      _serverDescriptionController.text = _server.value.description ?? "";
    } on ApiException catch (e) {
      if (kDebugMode) print("WashAdminApiException: $e");
    } catch (e) {
      if (kDebugMode) print("_getWashServer OtherException: $e");
    }
  }

  Future<void> _updateWashServer() async {
    try {
      var arg = WashServerUpdate(name: _serverNameController.text,
          description: _serverDescriptionController.text);
      var res = await Common.washServersApi!.updateWashServer(
          _server.value.id!.toString(), body: arg);
    } on ApiException catch (e) {
      if (kDebugMode) print("WashAdminApiException: $e");
    } catch (e) {
      if (kDebugMode) print("OtherException: $e");
    }
  }

  auth.User? user = auth.FirebaseAuth
      .instanceFor(app: Firebase.app("openwashing"))
      .currentUser;

  @override
  void initState() {
    _serverNameController = TextEditingController();
    _serverDescriptionController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute
        .of(context)
        ?.settings
        .arguments as Map<PageArgCode, dynamic>;
    final Repository repository = args[PageArgCode.repository];

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Сервисы")),
        drawer: WashNavigationDrawer(
            selected: SelectedPage.Services, repository: repository),
        body: Center(
          child: Text("Unauthorized"),
        ),
      );
    }

    final theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(title: Text("Сервисы")),
        drawer: WashNavigationDrawer(
            selected: SelectedPage.Services, repository: repository),
        body: FutureBuilder(
            future: repository.updateOrganizations(context: context),
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
                            valueListenable: repository.getOrganizationsNotifier(),
                            builder: (BuildContext context, List<Organization>? value, Widget? child) {
                              if (value == null) {
                                return Container();
                              }
                              return Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: value.length,
                                  physics: ClampingScrollPhysics(),
                                  itemBuilder: (BuildContext context,
                                      int index) {
                                    var data = value[index];
                                    return OrganizationCard(
                                      data: data,
                                      onPressed: () {

                                      },
                                    );
                                  },
                                ),
                              );
                            }
                        )
                      ]
                  )
              );
            }
        )
    );
  }
}