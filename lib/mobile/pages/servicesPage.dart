import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart' as entity;
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/common/ProgressButton.dart';
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
  ValueNotifier<entity.WashServer> _server = ValueNotifier(entity.WashServer());

  late TextEditingController _serverNameController;
  late TextEditingController _serverDescriptionController;

  Future<void> _RegisterWash(Repository repository) async {
    if (_serverNameController.text.isNotEmpty) {
      var arg = WashServerAdd(name: _serverNameController.text, description: _serverDescriptionController.text);

      try {
        final res = await Common.washServersApi!.add(body: arg);
        _server.value = _server.value.copyWith(
          id: res!.id,
          name: res!.name,
          serviceKey: res!.serviceKey,
        );
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
    if (_server.value.id?.isNotEmpty == true && _server.value.serviceKey?.isNotEmpty == true) {
      try {
        await repository.setConfigVarString("server_id", _server.value.id!);
        await repository.setConfigVarString("server_key", _server.value.serviceKey!);
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
      if (kDebugMode) print("OtherException: $e");
    }
  }

  Future<void> _getWashServer() async {
    try {
      var washServer = await Common.washServersApi!.getWashServer(_server.value.id!);

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
      if (kDebugMode) print("OtherException: $e");
    }
  }

  Future<void> _updateWashServer() async {
    try {
      var res = await Common.washServersApi!.update(body: WashServerUpdate(id: _server.value.id!, name: _serverNameController.text, description: _serverDescriptionController.text));
    } on ApiException catch (e) {
      if (kDebugMode) print("WashAdminApiException: $e");
    } catch (e) {
      if (kDebugMode) print("OtherException: $e");
    }
  }

  User? user = FirebaseAuth.instanceFor(app: Firebase.app("openwashing")).currentUser;

  @override
  void initState() {
    _serverNameController = TextEditingController();
    _serverDescriptionController = TextEditingController();
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
                    children: [
                      ValueListenableBuilder(
                        valueListenable: _server,
                        builder: (BuildContext context, entity.WashServer server, Widget? child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Параметры мойки",
                                    style: theme.textTheme.titleLarge,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        _loadWashServer(repository);
                                      },
                                      icon: Icon(Icons.refresh)),
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
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("ID"),
                                          Text(
                                            "ID на сервере",
                                            style: theme.textTheme.bodySmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextButton(
                                        onPressed: null,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              server.id ?? "Не зарегистрирована",
                                              style: theme.textTheme.labelMedium,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            FutureBuilder(
                                              future: repository.getConfigVarString("server_id"),
                                              builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                                                return Text(
                                                  snapshot.data ?? "",
                                                  style: theme.textTheme.bodySmall,
                                                  overflow: TextOverflow.ellipsis,
                                                );
                                              },
                                            ),
                                          ],
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
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "SERVICE_KEY",
                                            style: theme.textTheme.labelMedium,
                                          ),
                                          Text(
                                            "SERVICE_KEY на сервере",
                                            style: theme.textTheme.bodySmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextButton(
                                        onPressed: null,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              server.serviceKey ?? "Не зарегистрирована",
                                              style: theme.textTheme.labelMedium,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            FutureBuilder(
                                              future: repository.getConfigVarString("server_key"),
                                              builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                                                return Text(
                                                  snapshot.data ?? "",
                                                  style: theme.textTheme.bodySmall,
                                                  overflow: TextOverflow.ellipsis,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: ProgressButton(
                                      onPressed: (server.id ?? "").isEmpty
                                          ? () async {
                                              await _RegisterWash(repository);
                                            }
                                          : null,
                                      child: Text(
                                        "Зарегистрировать мойку",
                                        maxLines: 2,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: ProgressButton(
                                      onPressed: () async {
                                        if (_serverNameController.text.isNotEmpty) {
                                          await _updateWashServer();
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
                                    child: ProgressButton(
                                      onPressed: (_server.value.id ?? "").isNotEmpty
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
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
