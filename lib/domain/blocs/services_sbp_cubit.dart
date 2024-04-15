import 'package:bloc/bloc.dart';
import 'package:mobile_wash_control/domain/data_providers/lcw_transport.dart';
import 'package:mobile_wash_control/domain/entities/services_entities.dart';

import '../data_providers/sbp_transport.dart';
import '../data_providers/wash_admin_transport.dart';
import '../entities/segments_entities.dart';
import '../entities/user_entity.dart';

class ServicesSbpSegmentState {
  final ServicesSbpEntity servicesSbpEntity;

  const ServicesSbpSegmentState({
    required this.servicesSbpEntity,
  });

  ServicesSbpSegmentState copyWith({
    ServicesSbpEntity? servicesSbpEntity,
  }) {
    return ServicesSbpSegmentState(
      servicesSbpEntity: servicesSbpEntity ?? this.servicesSbpEntity,
    );
  }

  @override
  String toString() {
    return 'ServicesSbpSegmentState{servicesSbpEntity: $servicesSbpEntity}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServicesSbpSegmentState &&
          runtimeType == other.runtimeType &&
          servicesSbpEntity == other.servicesSbpEntity;

  @override
  int get hashCode => servicesSbpEntity.hashCode;
}

class ServicesSbpSegmentCubit extends Cubit<ServicesSbpSegmentState> {

  ServicesSbpSegmentCubit(ServiceUser serviceUser) : super(
      ServicesSbpSegmentState(
          servicesSbpEntity: ServicesSbpEntity(
              serviceUser: serviceUser,
              sbpWashServer: null,
              organizations: [],
              currentOrganization: null,
              serverGroups: [],
              currentServerGroup: null,
              interactionBlocked: true,
              terminalKey: '',
              terminalPassword: ''
          )
      )
  ) {
    _initialize(serviceUser);
  }

  Future<void> _initialize(ServiceUser serviceUser) async {

    String washId = '';

    SbpWashServer? sbpWashServer;
    ServerGroup? currentServerGroup;
    Organization? currentOrganization;

    List<ServerGroup> serverGroups = [];
    List<Organization> organizations = [];

    try {
      washId = await LcwTransport.getConfigVarString("sbp_server_id");
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }

    if (washId.isNotEmpty) {
      sbpWashServer = await SbpTransport.getSbpWashServer(washId);
    }

    if(serviceUser.role == ServiceUserRole.admin) {
      currentOrganization = await WashAdminTransport.getOrganization(serviceUser.organizationId);
      serverGroups = List.from(await WashAdminTransport.getServerGroups(null));
      currentServerGroup = sbpWashServer != null ? serverGroups.where((element) => element.id == sbpWashServer?.groupId).first : serverGroups.first;
    } else {
      organizations = List.from(await WashAdminTransport.getOrganizations());

      if(sbpWashServer != null) {
        currentServerGroup = await WashAdminTransport.getServerGroup(sbpWashServer.groupId);
        currentOrganization = organizations.where((element) => element.id == currentServerGroup?.organizationId ).first;
        serverGroups = List.from(await WashAdminTransport.getServerGroups(currentOrganization.id ?? ""));
        serverGroups = serverGroups.where((element) => element.organizationId == currentOrganization?.id).toList();
        currentServerGroup = serverGroups.where((element) => element.id == currentServerGroup?.id).first;
      } else {
        currentOrganization = organizations.first;
        serverGroups = List.from(await WashAdminTransport.getServerGroups(currentOrganization.id));
        serverGroups = serverGroups.where((element) => element.organizationId == currentOrganization?.id).toList();
        currentServerGroup = serverGroups.first;
      }
    }

    final servicesSbpEntity = ServicesSbpEntity(
        serviceUser: serviceUser,
        sbpWashServer: sbpWashServer ?? SbpWashServer(id: '', name: '', description: '', servicePassword: '', isTwoStagePayment: false, groupId: currentServerGroup.id, organizationId: currentOrganization?.id ?? '', ),
        organizations: organizations,
        currentOrganization: currentOrganization,
        serverGroups: serverGroups,
        currentServerGroup: currentServerGroup,
        interactionBlocked: false,
        terminalKey: '',
        terminalPassword: ''
    );

    final newState = state.copyWith(servicesSbpEntity: servicesSbpEntity);

    emit(newState);

  }

  void onNameChanged (String newName) {
    var servicesSbpEntity = state.servicesSbpEntity;
    var currentWash = servicesSbpEntity.sbpWashServer;

    currentWash = currentWash?.copyWith(name: newName);
    servicesSbpEntity = servicesSbpEntity.copyWith(sbpWashServer: currentWash);

    emit(state.copyWith(servicesSbpEntity: servicesSbpEntity));
  }

  void onDescriptionChanged (String newDescription) {
    var servicesSbpEntity = state.servicesSbpEntity;
    var currentWash = servicesSbpEntity.sbpWashServer;

    currentWash = currentWash?.copyWith(description: newDescription);
    servicesSbpEntity = servicesSbpEntity.copyWith(sbpWashServer: currentWash);

    emit(state.copyWith(servicesSbpEntity: servicesSbpEntity));
  }

  void onTerminalKeyChanged (String newTerminalKey) {
    var servicesSbpEntity = state.servicesSbpEntity;
    servicesSbpEntity = servicesSbpEntity.copyWith(terminalKey: newTerminalKey);
    emit(state.copyWith(servicesSbpEntity: servicesSbpEntity));
  }

  void onTerminalPasswordChanged (String newTerminalPassword) {
    var servicesSbpEntity = state.servicesSbpEntity;
    servicesSbpEntity = servicesSbpEntity.copyWith(terminalPassword: newTerminalPassword);
    emit(state.copyWith(servicesSbpEntity: servicesSbpEntity));
  }

  Future<void> onChangeOrganization (Organization value) async {
    var servicesSbpEntity = state.servicesSbpEntity;
    servicesSbpEntity = servicesSbpEntity.copyWith(interactionBlocked: true);
    emit(state.copyWith(servicesSbpEntity: servicesSbpEntity));

    var currentOrganization = state.servicesSbpEntity.organizations.where((element) => element.id == value.id).first;
    List<ServerGroup> serverGroups = List.from(await WashAdminTransport.getServerGroups(currentOrganization.id));
    serverGroups = serverGroups.where((element) => element.organizationId == currentOrganization.id).toList();
    ServerGroup currentServerGroup = serverGroups.first;
    SbpWashServer? sbpWashServer = servicesSbpEntity.sbpWashServer?.copyWith(groupId: currentServerGroup.id, organizationId: currentOrganization.id);

    servicesSbpEntity = state.servicesSbpEntity;
    servicesSbpEntity = servicesSbpEntity.copyWith(currentOrganization: currentOrganization, serverGroups: serverGroups, currentServerGroup: currentServerGroup, interactionBlocked: false, sbpWashServer: sbpWashServer);
    emit(state.copyWith(servicesSbpEntity: servicesSbpEntity));
  }

  Future<void> onChangeServerGroup (ServerGroup value) async {
    var servicesSbpEntity = state.servicesSbpEntity;
    SbpWashServer? sbpWashServer = servicesSbpEntity.sbpWashServer?.copyWith(groupId: value.id);

    servicesSbpEntity = servicesSbpEntity.copyWith(currentServerGroup: value, sbpWashServer: sbpWashServer);
    emit(state.copyWith(servicesSbpEntity: servicesSbpEntity));
  }

  Future<void> registerSbpWashServer () async {
    var servicesSbpEntity = state.servicesSbpEntity;
    servicesSbpEntity = servicesSbpEntity.copyWith(interactionBlocked: true);
    emit(state.copyWith(servicesSbpEntity: servicesSbpEntity));

    var sbpWashServer = await SbpTransport.registerSbpWashServer(servicesSbpEntity.sbpWashServer!, servicesSbpEntity.terminalKey, servicesSbpEntity.terminalPassword);
    await LcwTransport.setConfigVarString("sbp_server_id", sbpWashServer.id);
    await LcwTransport.setConfigVarString("sbp_server_password", sbpWashServer.servicePassword);

    servicesSbpEntity = state.servicesSbpEntity;
    servicesSbpEntity = servicesSbpEntity.copyWith(interactionBlocked: false, sbpWashServer: sbpWashServer);
    emit(state.copyWith(servicesSbpEntity: servicesSbpEntity));
  }

  Future<void> updateSbpWashServer () async {
    var servicesSbpEntity = state.servicesSbpEntity;
    await SbpTransport.updateSbpWashServer(servicesSbpEntity.sbpWashServer!);
  }

}