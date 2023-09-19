import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart' as entity;
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/common/ProgressButton.dart';
import 'package:mobile_wash_control/mobile/widgets/common/washNavigationDrawer.dart';
import 'package:mobile_wash_control/openapi/sbp-client/api.dart' as sbp;
import 'package:mobile_wash_control/openapi/wash-admin-client/api.dart';
import 'package:mobile_wash_control/repository/repository.dart';
import 'package:mobile_wash_control/utils/common.dart';
import '../../repository/wash_admin_repo/repository.dart';
import '../../utils/sbp_common.dart';
import '../widgets/common/snackBars.dart';

class SettingsServicesPage extends StatefulWidget {
  const SettingsServicesPage({
    super.key,
  });

  @override
  State<SettingsServicesPage> createState() => _SettingsServicesPageState();
}

class _SettingsServicesPageState extends State<SettingsServicesPage> {
  ValueNotifier<entity.WashServer> _server = ValueNotifier(entity.WashServer());
  ValueNotifier<entity.SbpWashServer> _sbpServer = ValueNotifier(entity.SbpWashServer());

  ValueNotifier<List<entity.Organization>> organizations = ValueNotifier([]);
  ValueNotifier<List<entity.ServerGroup>> serverGroups = ValueNotifier([]);
  ValueNotifier<entity.Organization> currentOrganization = ValueNotifier(entity.Organization(id: "", name: "", description: ""));
  ValueNotifier<entity.ServerGroup> currentServerGroup = ValueNotifier(entity.ServerGroup(id: "", name: "", description: "", organizationId: ""));

  ValueNotifier<bool> block = ValueNotifier(false);

  String newGroupId = "";

  AdminUser? adminUser = null;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _sbpFormKey = GlobalKey<FormState>();

  late TextEditingController _serverNameController;
  late TextEditingController _serverDescriptionController;

  late TextEditingController _sbpServerNameController;
  late TextEditingController _sbpServerDescriptionController;

  late TextEditingController _sbpTerminalKeyController;
  late TextEditingController _sbpTerminalPasswordController;

  late String sbpServerId;

  Future<void> _RegisterWash(Repository repository) async {
    print("register Wash");
    if (_serverNameController.text.isNotEmpty) {
      print("RegisterWash groupId: " + newGroupId);
      print("newGroupId: " + newGroupId.toString());
      var arg = WashServerCreation(name: _serverNameController.text, description: _serverDescriptionController.text, groupId: newGroupId);

      try {
        final res = await Common.washServerApi!.createWashServer(body: arg);
        _server.value = _server.value.copyWith(
          id: res!.id,
          name: res!.name,
          organizationId: res!.organizationId,
          groupId: res!.groupId,
          description: res!.description,
          createdBy: res!.createdBy,
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
    print("_saveParams");
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
    print("_loadWashServer");
    try{
      adminUser = await _getUser(user?.uid ?? "");
      await _getOrganizations();
    } catch (e) {
      print(e);
    }
    try {
      var id = await repository.getConfigVarString("server_id");
      var key = await repository.getConfigVarString("server_key");

      _server.value = _server.value.copyWith(
          id: id,
          serviceKey: key
      );
      await _getWashServer();
      await manageOrganizations();
      if((_server.value.groupId?.isEmpty ?? true)){
        print("groupIdisEmpty");
        var res = await WashAdminRepository.getServerGroups((organizations.value.where((element) => element.isDefault ?? true).first.id ?? ""));
        newGroupId = res?.first.id ?? "";
      }
    } catch (e) {
      if (kDebugMode) print("_loadWashServer OtherException: $e");
    }
  }

  Future<AdminUser?> _getUser(String id) async {
    final res = await Common.userApi!.getAdminUserById(id);
    return res;
  }

  Future<void> _deleteWashServer(Repository repository) async {
    print("_deleteWashServer");
    if (_server.value.id?.isNotEmpty == true && _server.value.serviceKey?.isNotEmpty == true) {
      try {
        await repository.deleteConfigVarString("server_id", _server.value.id!);
        await repository.deleteConfigVarString("server_key", _server.value.serviceKey!);
      } catch (e) {
        if (kDebugMode) print("OtherException: $e");
      }
      return;
    }
  }

  Future<void> manageOrganizations() async {
    await _getOrganization();
    await _getGroups();
    await _getGroup();
    if(organizations.value.isEmpty){
      organizations.value = [currentOrganization.value];
    }
    if(serverGroups.value.isEmpty){
      serverGroups.value = [currentServerGroup.value];
    }
  }

  Future<void> _getOrganization() async {
    print("_getOrganization");
    try{
      var org;
      if(organizations.value.isEmpty){
        var currentUser = await Common.userApi!.getAdminUserById(user?.uid ?? "");
        org = await Common.organizationApi?.getOrganizationById(currentUser?.organizationId ?? "");
      } else{
        org = await Common.organizationApi?.getOrganizationById(_server.value.organizationId ?? organizations.value[0].id!);
      }
      currentOrganization.value = currentOrganization.value.copyWith(
        id: org?.id ?? "",
        name: org?.name ?? "",
        description: org?.description ?? "",
        isDefault: org?.isDefault ?? false,
      );
      print(org);
    } on ApiException catch (e) {
      print("WashAdminApiException: ${e.code}");
      print("WashAdminApiException: ${e.message}");
    } catch (e) {
      if (kDebugMode) print("_getOrganization OtherException: $e");
    }
  }

  Future<void> _getOrganizations() async {
    print("_getOrganizations");
    try{
      organizations.value = (await WashAdminRepository.getOrganizations() ?? []);
    } on ApiException catch (e) {
      if (kDebugMode) print("WashAdminApiException: $e");
    } catch (e) {
      if (kDebugMode) print("_getOrganizations OtherException: $e");
    }
  }

  Future<void> _getGroup() async {
    print("_getGroup");
    try{
      var group = await Common.serversGroupApi?.getServerGroupById(_server.value.groupId ?? "");
      print(group);
      currentServerGroup.value = currentServerGroup.value.copyWith(
        id: group?.id,
        name: group?.name,
        description: group?.description,
        organizationId: group?.organizationId,
      );
    } on ApiException catch (e) {
      if (kDebugMode) print("WashAdminApiException: $e");
      currentServerGroup.value = entity.ServerGroup();
    } catch (e) {
      if (kDebugMode) print("_getGroup OtherException: $e");
    }
  }

  Future<void> _getGroups() async {
    print("_getGroups");
    try{
      serverGroups.value = (await WashAdminRepository.getServerGroups(currentOrganization.value.id ?? "") ?? []);
    } on ApiException catch (e) {
      if (kDebugMode) print("WashAdminApiException: $e");
    } catch (e) {
      if (kDebugMode) print("_getGroups OtherException: $e");
    }
  }

  Future<void> _getWashServer() async {
    print("_getWashServer");
    try {
      var washServer = await Common.washServerApi!.getWashServerById(_server.value.id!);
      print("washServer.groupId: " + washServer!.groupId!);
      _server.value = _server.value.copyWith(
        name: washServer?.name,
        serviceKey: washServer?.serviceKey,
        description: washServer?.description,
        organizationId: washServer?.organizationId,
        groupId: washServer?.groupId,
        createdBy: washServer?.createdBy,
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
    print("_updateWashServer");
    try {
      print("_updateWashServer newGroupId: " + newGroupId);
      var arg = WashServerUpdate(name: _serverNameController.text, description: _serverDescriptionController.text);
      var res = await Common.washServerApi!.updateWashServer(_server.value.id!.toString(), body: arg);
      await Common.washServerApi?.assignServerToGroup(newGroupId, (_server.value.id ?? ""));
    } on ApiException catch (e) {
      print("WashAdminApiException: ${e.code}");
      print("WashAdminApiException: ${e.message}");
    } catch (e) {
      if (kDebugMode) print("OtherException: $e");
    }
  }

  Future<void> _registerWashForSbp(Repository repository, BuildContext context) async {
    print("register Wash for Sbp");
    try{
      var res = await SbpCommon.washApi!.create(
          body: sbp.WashCreate(
            name: _sbpServerNameController.text,
            description: _sbpServerDescriptionController.text,
            terminalKey: _sbpTerminalKeyController.text,
            terminalPassword: _sbpTerminalPasswordController.text,
          )
      );
      print("RegisterWash for sbp: ");
      print(res);
      await repository.setConfigVarString("sbp_server_id", res?.id ?? "");
      await repository.setConfigVarString("sbp_server_password", res?.password ?? "");
    } on sbp.ApiException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Ошибка: $e"));
      //print(e.code);
      //print(e.message);
    } catch (e) {
      if (kDebugMode) print("_registerWashForSbp OtherException: $e");
    }
  }

  Future<void> _updateWashForSbp(Repository repository) async {
    print("update Wash for Sbp");
    try{
      await SbpCommon.washApi!.update(
          body: sbp.WashUpdate(
            name: _sbpServerNameController.text,
            description: _sbpServerDescriptionController.text,
            terminalKey: _sbpTerminalKeyController.text,
            terminalPassword: _sbpTerminalPasswordController.text,
          )
      );
    } on sbp.ApiException catch (e) {
      print(e.code);
      print(e.message);
    } catch (e) {
      if (kDebugMode) print("_updateWashForSbp OtherException: $e");
    }
  }

  Future<void> _deleteWashForSbp(Repository repository) async {
    print("delete Wash for Sbp");
    try{
      await SbpCommon.washApi!.delete(
        body: sbp.WashDelete(id: _sbpServer.value.id!)
      );

    } on sbp.ApiException catch (e) {
      print(e.code);
      print(e.message);
    } catch (e) {
      if (kDebugMode) print("_deleteWashForSbp OtherException: $e");
    }
  }

  Future<void> _getSbpWashServer(Repository repository) async {
    print("_getSbpWashServer");
    _sbpTerminalKeyController.text = "";
    _sbpTerminalPasswordController.text = "";
    try {
      String? sbpServerId = await repository.getConfigVarString("sbp_server_id");
      String? sbpServerPassword = await repository.getConfigVarString("sbp_server_password");
      if((sbpServerId ?? "").isNotEmpty && (sbpServerPassword ?? "").isNotEmpty){
        var washServer = await SbpCommon.washApi!.getWash(sbpServerId!);

        _sbpServerNameController.text = washServer!.name!;
        _sbpServerDescriptionController.text = washServer.description!;

        _sbpServer.value.id = sbpServerId;
        _sbpServer.value.servicePassword = sbpServerPassword;
        _sbpServer.value.name = washServer.name!;
        _sbpServer.value.description = washServer.description!;
      }
      else{
        _sbpServerNameController.text = "";
        _sbpServerDescriptionController.text = "";
      }

    } on ApiException catch (e) {
      if (kDebugMode) print("WashAdminApiException: $e");
    } catch (e) {
      if (kDebugMode) print("_getWashServer OtherException: $e");
    }
  }

  auth.User? user = auth.FirebaseAuth.instanceFor(app: Firebase.app("openwashing")).currentUser;

  @override
  void initState() {
    _serverNameController = TextEditingController();
    _serverDescriptionController = TextEditingController();

    _sbpServerNameController = TextEditingController();
    _sbpServerDescriptionController = TextEditingController();

    _sbpTerminalKeyController = TextEditingController();
    _sbpTerminalPasswordController = TextEditingController();
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
          //adminUser?.role?.value;
          return ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Card(
                child: ExpansionTile(
                  title: Text("Бонуснная программа"),
                  children: adminUser == null ? [
                    Column(
                      children: [
                        Text("Вы не зарегистрированы в бонусной программе"),
                        ProgressButton(
                          onPressed: () async {
                            var res = await WashAdminRepository.sendApplication(entity.FirebaseUser(
                              id: user?.uid,
                              name: user?.displayName,
                              email: user?.email,
                            ));
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: (res?.status.value == 'pending' || res?.status.value == 'accepted') ? const Text('Заявка на рассмотрении') :  const Text('Доступ запрещён'),
                                    content:(res?.status.value == 'pending' || res?.status.value == 'accepted') ?  const Text(
                                      'Ваша заявка находится на рассмотрении',
                                    ) : const Text(
                                      'Ваша заявка была отклонена',
                                    ),
                                      actions: <Widget>[
                                        TextButton(onPressed: () {
                                          setState(() {});
                                          Navigator.pop(context);
                                        }, child: Text("Ok"))
                                      ],
                                  );
                                }
                            );
                          },
                          child: Text(
                            "Отправить заявку",
                            maxLines: 2,
                          ),
                        ),
                      ],
                    )
                  ] : [
                    Form(
                      key: _formKey,
                      child: Wrap(
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
                                          Divider(height: 10,),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                flex: 2,
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                                                  child: Text(
                                                    "Имя",
                                                    style: theme.textTheme.bodyMedium,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 3,
                                                child: Padding(
                                                  padding:const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: TextFormField(
                                                    controller: _serverNameController,
                                                    style: theme.textTheme.bodyMedium,
                                                    validator: (value) {
                                                      var trimmedValue = value!.trim();
                                                      return (trimmedValue.isEmpty ?? true) ? "Поле не должно быть пустым" : null;
                                                    },
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
                                                  padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                                                  child: Text(
                                                    "Описание",
                                                    style: theme.textTheme.bodyMedium,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 3,
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: TextFormField(
                                                    maxLines: null,
                                                    controller: _serverDescriptionController,
                                                    style: theme.textTheme.bodyMedium,
                                                    validator: (value) {
                                                      var trimmedValue = value!.trim();
                                                      return (trimmedValue.isEmpty ?? true) ? "Поле не должно быть пустым" : null;
                                                    },
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Divider(height: 10,),
                                          ValueListenableBuilder(
                                              valueListenable: _server,
                                              builder: (BuildContext context, entity.WashServer srv, Widget? child) {
                                                return Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    ValueListenableBuilder(
                                                        valueListenable: organizations,
                                                        builder: (BuildContext context, List<entity.Organization> orgs, Widget? widget){
                                                          return Row(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Flexible(
                                                                fit: FlexFit.loose,
                                                                flex: 1,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                                                                  child: Text(
                                                                    "Организация",
                                                                    style: theme.textTheme.bodyMedium,
                                                                  ),
                                                                ),
                                                              ),
                                                              ValueListenableBuilder(
                                                                  valueListenable: currentOrganization,
                                                                  builder: (BuildContext context, entity.Organization org, Widget? widget) {
                                                                    return Flexible(
                                                                        flex: 2,
                                                                        fit: FlexFit.loose,
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                                          child: DropdownButtonFormField(
                                                                            isExpanded: true,
                                                                            value: (currentOrganization.value.id?.isEmpty ?? true) ? orgs[0].id: currentOrganization.value.id,
                                                                            items: List.generate(
                                                                              orgs.length ?? 0,
                                                                                  (index) => DropdownMenuItem(
                                                                                child: Text(orgs[index].name!),
                                                                                value: orgs[index].id!,
                                                                              ),
                                                                            ),
                                                                            onChanged: (String? value) async {
                                                                              block.value = true;
                                                                              currentOrganization.value = (await WashAdminRepository.getOrganization(value!))!;
                                                                              await _getGroups();
                                                                              currentServerGroup.value = serverGroups.value[0];
                                                                              newGroupId = serverGroups.value[0].id ?? "";
                                                                              block.value = false;
                                                                            },
                                                                          ),
                                                                        )
                                                                    );
                                                                  }
                                                              )
                                                            ],
                                                          );
                                                        }
                                                    ),
                                                    ValueListenableBuilder(
                                                        valueListenable: serverGroups,
                                                        builder: (BuildContext context, List<entity.ServerGroup> grps, Widget? widget) {
                                                          return Row(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Flexible(
                                                                fit: FlexFit.loose,
                                                                flex: 1,
                                                                child: Padding(
                                                                  padding:  const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                                                                  child: Text(
                                                                    "Группа",
                                                                    style: theme.textTheme.bodyMedium,
                                                                  ),
                                                                ),
                                                              ),
                                                              ValueListenableBuilder(
                                                                  valueListenable: block,
                                                                  builder: (BuildContext context, bool blck, Widget? widget) {
                                                                    return ValueListenableBuilder(
                                                                        valueListenable: currentServerGroup,
                                                                        builder: (BuildContext context, entity.ServerGroup grp, Widget? widget){
                                                                          return Flexible(
                                                                              flex: 2,
                                                                              fit: FlexFit.loose,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                                                child: DropdownButtonFormField(
                                                                                  isExpanded: true,
                                                                                  value: (currentServerGroup.value.id?.isEmpty ?? true) ? grps[0].id: currentServerGroup.value.id,
                                                                                  items: blck ? null: List.generate(
                                                                                    grps.length,
                                                                                        (index) => DropdownMenuItem(
                                                                                      child: Text(grps[index].name ?? ""),
                                                                                      value: grps[index].id ?? "",
                                                                                    ),
                                                                                  ),
                                                                                  onChanged: (String? value) {
                                                                                    newGroupId = value!;
                                                                                  },
                                                                                ),
                                                                              )
                                                                          );
                                                                        }
                                                                    );
                                                                  }
                                                              )
                                                            ],
                                                          );
                                                        }
                                                    ),
                                                    Divider(height: 10,),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Flexible(
                                                          flex: 2,
                                                          child: Padding(
                                                            padding:  const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text("ID"),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          flex: 3,
                                                          child: Padding(
                                                            padding:  const EdgeInsets.symmetric(horizontal: 8.0),
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
                                                            padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  "SERVICE_KEY",
                                                                  style: theme.textTheme.labelMedium,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          flex: 3,
                                                          child: Padding(
                                                            padding:  const EdgeInsets.symmetric(horizontal: 8.0),
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
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              }
                                          ),
                                          Divider(height: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: ProgressButton(
                                                  onPressed: (server.id ?? "").isEmpty
                                                      ? () async {
                                                    if (_formKey.currentState!.validate()) {
                                                      await _RegisterWash(repository);
                                                    }
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
                                                    if (_formKey.currentState!.validate()) {
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
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                  child: ExpansionTile(
                      title: Text("СБП"),
                      children: [
                        ValueListenableBuilder<entity.SbpWashServer>(
                            valueListenable: _sbpServer,
                            builder: (BuildContext context, entity.SbpWashServer sbpServer, Widget? widget ) {
                              return FutureBuilder<void>(
                                future: _getSbpWashServer(repository),
                                builder: (BuildContext buildContext, AsyncSnapshot<void> snapshot) {
                                  if(snapshot.connectionState == ConnectionState.done){
                                    return Form(
                                      key: _sbpFormKey,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                flex: 2,
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                                                  child: Text(
                                                    "Имя",
                                                    style: theme.textTheme.bodyMedium,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 3,
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: TextFormField(
                                                    controller: _sbpServerNameController,
                                                    style: theme.textTheme.bodyMedium,
                                                    validator: (value) {
                                                      var trimmedValue = value!.trim();
                                                      return (trimmedValue.isEmpty ?? true) ? "Поле не должно быть пустым" : null;
                                                    },
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
                                                  padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                                                  child: Text(
                                                    "Описание",
                                                    style: theme.textTheme.bodyMedium,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 3,
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: TextFormField(
                                                    controller: _sbpServerDescriptionController,
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
                                                  padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                                                  child: Text(
                                                    "Terminal Key",
                                                    style: theme.textTheme.bodyMedium,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 3,
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: TextFormField(
                                                    controller: _sbpTerminalKeyController,
                                                    style: theme.textTheme.bodyMedium,
                                                    validator: (value) {
                                                      var trimmedValue = value!.trim();
                                                      return (trimmedValue.isEmpty ?? true) ? "Поле не должно быть пустым" : null;
                                                    },
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
                                                  padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                                                  child: Text(
                                                    "Terminal Password",
                                                    style: theme.textTheme.bodyMedium,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 3,
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: TextFormField(
                                                    controller: _sbpTerminalPasswordController,
                                                    style: theme.textTheme.bodyMedium,
                                                    validator: (value) {
                                                      var trimmedValue = value!.trim();
                                                      return (trimmedValue.isEmpty ?? true) ? "Поле не должно быть пустым" : null;
                                                    },
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Divider(height: 10,),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                flex: 2,
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "SBP_SERVER_ID",
                                                        style: theme.textTheme.labelMedium,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 3,
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: TextButton(
                                                    onPressed: null,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          sbpServer.id ?? "Не зарегистрирована",
                                                          style: theme.textTheme.labelMedium,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
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
                                                  padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "SBP_SERVER_PASSWORD",
                                                        style: theme.textTheme.labelMedium,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 3,
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: TextButton(
                                                    onPressed: null,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          sbpServer.servicePassword ?? "Не зарегистрирована",
                                                          style: theme.textTheme.labelMedium,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ],
                                                    ),
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
                                                  onPressed: (sbpServer.id ?? "").isEmpty ? () async {
                                                    if (_sbpFormKey.currentState!.validate()) {
                                                      await _registerWashForSbp(repository, context);
                                                      //setState(() {});
                                                    }
                                                  } : null,
                                                  child: Text(
                                                    "Зарегистрировать мойку для СБП",
                                                    maxLines: 2,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 2,
                                                child: ProgressButton(
                                                  onPressed: (sbpServer.id ?? "").isNotEmpty ? () async {
                                                    if (_sbpFormKey.currentState!.validate()) {
                                                      await _updateWashForSbp(repository);
                                                    }
                                                  } : null,
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
                                              Center(
                                                child: ProgressButton(
                                                  onPressed: (sbpServer.id ?? "").isNotEmpty ? () async {
                                                    if (_sbpFormKey.currentState!.validate()) {
                                                      await _deleteWashForSbp(repository);
                                                    }
                                                  } : null,
                                                  child: Text(
                                                    "Удалить мойку из СБП",
                                                    maxLines: 2,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  else{
                                    return Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              );
                            }
                        ),
                      ]
                  )
              )
            ],
          );
        },
      ),
    );
  }
}