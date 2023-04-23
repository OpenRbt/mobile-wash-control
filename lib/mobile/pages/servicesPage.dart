import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart' as entity;
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/common/washNavigationDrawer.dart';
import 'package:mobile_wash_control/openapi/wash-admin-client/api.dart';
import 'package:mobile_wash_control/repository/repository.dart';
import 'package:mobile_wash_control/utils/common.dart';

class SettingsServicesPage extends StatefulWidget {
  const SettingsServicesPage({
    super.key,
  });

  @override
  State<SettingsServicesPage> createState() => _SettingsServicesPageState();
}

class _SettingsServicesPageState extends State<SettingsServicesPage> {
  entity.WashServer _washServer = entity.WashServer();

  WashServer? _remoteWashServer;

  late TextEditingController _serverNameController;
  late TextEditingController _serverDescriptionController;

  Future<void> _RegisterWash() async {
    if (_serverNameController.text.isNotEmpty) {
      var arg = WashServerAdd(name: _serverNameController.text);
      WashServer? res;

      try {
        res = await Common.washServersApi!.add(body: arg);
      } on ApiException catch (e) {
        if (kDebugMode) print("WashAdminApiException: $e");
      } catch (e) {
        if (kDebugMode) print("OtherException: $e");
      }
      if (res != null) {
        setState(() {
          _washServer.id = res!.id;
          _washServer.serviceKey = res!.serviceKey;
          _washServer.description = res.description;
          _remoteWashServer = res;
        });
      }
    }
  }

  Future<void> _saveParams(Repository repository) async {
    if (_washServer.id?.isNotEmpty == true && _washServer.serviceKey?.isNotEmpty == true) {
      try {
        await repository.setConfigVarString("server_id", _washServer.id!);
        await repository.setConfigVarString("server_key", _washServer.serviceKey!);
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

      setState(() {
        _washServer.id = id;
        _washServer.serviceKey = key;
      });
      await _getWashServer();
    } catch (e) {
      if (kDebugMode) print("OtherException: $e");
    }
  }

  Future<void> _getWashServer() async {
    try {
      var washServer = await Common.washServersApi!.getWashServer(_washServer.id!);

      setState(() {
        _washServer.name = washServer?.name;
        _washServer.description = washServer?.description;
        _washServer.serviceKey = washServer?.serviceKey;

        _serverNameController.text = _washServer.name ?? "";
        _serverDescriptionController.text = _washServer.description ?? "";
      });
    } on ApiException catch (e) {
      if (kDebugMode) print("WashAdminApiException: $e");
    } catch (e) {
      if (kDebugMode) print("OtherException: $e");
    }
  }

  Future<void> _updateWashServer() async {
    try {
      var res = await Common.washServersApi!.update(body: WashServerUpdate(id: _washServer.id!, name: _serverNameController.text, description: _serverDescriptionController.text));
      await _getWashServer();
    } on ApiException catch (e) {
      if (kDebugMode) print("WashAdminApiException: $e");
    } catch (e) {
      if (kDebugMode) print("OtherException: $e");
    }
  }

  User? user = FirebaseAuth.instance.currentUser;
  var serviceIdController = TextEditingController();
  var serviceKeyController = TextEditingController();
  String sessionKey = "";
  String serviceId = "";

  @override
  void initState() {
    _serverNameController = TextEditingController();
    _serverDescriptionController = TextEditingController();
    // _loadWashServer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final Repository repository = args[PageArgCode.repository];

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Сервисы")),
        drawer: WashNavigationDrawer(selected: SelectedPage.Services, repository: repository),
        body: Center(
          child: Text("Unauthorized"),
        ),
      );
    }

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text("Сервисы")),
      drawer: WashNavigationDrawer(selected: SelectedPage.Services, repository: repository),
      body: FutureBuilder(
        future: _loadWashServer(repository),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Параметры мойки",
                            style: theme.textTheme.titleLarge,
                          ),
                          IconButton(onPressed: _getWashServer, icon: Icon(Icons.refresh)),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Имя",
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _serverNameController,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Описание",
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                maxLines: null,
                                controller: _serverDescriptionController,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("ID"),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                onPressed: null,
                                child: Text(
                                  _washServer.id ?? "Не зарегистрирована",
                                  style: theme.textTheme.bodySmall,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("SERVICE_KEY"),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                onPressed: null,
                                child: Text(
                                  _washServer.serviceKey ?? "Не зарегистрирована",
                                  style: theme.textTheme.bodySmall,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: _remoteWashServer == null && (_washServer.id ?? "").isEmpty ? _RegisterWash : null,
                      child: Text(
                        "Зарегистрировать мойку",
                        maxLines: 2,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_serverNameController.text.isNotEmpty) {
                          _updateWashServer();
                        }
                      },
                      child: Text(
                        "Сохранить изменения",
                        maxLines: 2,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: _remoteWashServer != null || (_washServer.id ?? "").isNotEmpty
                          ? () async {
                              await _saveParams(repository);
                            }
                          : null,
                      child: Text(
                        "Повторно записать ID и ключ",
                        maxLines: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
