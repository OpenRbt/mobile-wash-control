import 'package:bloc/bloc.dart';
import 'package:mobile_wash_control/domain/entities/services_entities.dart';

import '../data_providers/lcw_transport.dart';
import '../data_providers/management_transport.dart';
import '../data_providers/wash_admin_transport.dart';
import '../entities/segments_entities.dart';
import '../entities/user_entity.dart';

class ServicesServerBindingSegmentState {
  final ServicesServerBindingEntity servicesServerBindingEntity;

  const ServicesServerBindingSegmentState({
    required this.servicesServerBindingEntity,
  });

  ServicesServerBindingSegmentState copyWith({
    ServicesServerBindingEntity? servicesServerBindingEntity,
  }) {
    return ServicesServerBindingSegmentState(
      servicesServerBindingEntity:
          servicesServerBindingEntity ?? this.servicesServerBindingEntity,
    );
  }

  @override
  String toString() {
    return 'ServicesServerBindingSegmentState{servicesServerBindingEntity: $servicesServerBindingEntity}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServicesServerBindingSegmentState &&
          runtimeType == other.runtimeType &&
          servicesServerBindingEntity == other.servicesServerBindingEntity;

  @override
  int get hashCode => servicesServerBindingEntity.hashCode;
}

class ServicesServerBindingSegmentCubit extends Cubit<ServicesServerBindingSegmentState> {

  ServicesServerBindingSegmentCubit(ServiceUser serviceUser) : super(
      ServicesServerBindingSegmentState(
          servicesServerBindingEntity: ServicesServerBindingEntity(
            serviceUser: serviceUser,
              organizations: [],
              currentOrganization: null,
              serverGroups: [],
              currentServerGroup: null,
              washServers: [],
              currentWashServer: null,
              interactionBlocked : true,
              currentId: 'not_registered'.tr(),
            currentServiceKey: 'not_registered'.tr(),
          )
      )
  ) {
    _initialize(serviceUser);
  }

  Future<void> _initialize(ServiceUser serviceUser) async {

    String washId = '';
    String washKey = '';

    WashServer? currentWashServer;
    ServerGroup? currentServerGroup;
    Organization? currentOrganization;

    List<WashServer> washServers = [];
    List<ServerGroup> serverGroups = [];
    List<Organization> organizations = [];

    try {
      washId = await LcwTransport.getConfigVarString("management_server_id");
      washKey = await LcwTransport.getConfigVarString("management_service_key");
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }

    if (washId.isNotEmpty && washKey.isNotEmpty) {
      currentWashServer = await ManagementTransport.getWashServer(washId);
    } else {
      washId = 'not_registered'.tr();
      washKey = 'not_registered'.tr();
    }

    if(serviceUser.role == ServiceUserRole.admin) {
      currentOrganization = await WashAdminTransport.getOrganization(serviceUser.organizationId);
      serverGroups = List.from(await WashAdminTransport.getServerGroups(currentOrganization?.id ?? ""));
      currentServerGroup = currentWashServer != null ? serverGroups.where((element) => element.id == currentWashServer?.groupId).first : serverGroups.first;
      washServers = await ManagementTransport.getWashServers(currentServerGroup.id);
      currentWashServer = washServers.length > 0 ? washServers.first : null;
    } else {
      organizations = List.from(await WashAdminTransport.getOrganizations());

      if(currentWashServer != null) {
        currentServerGroup = await WashAdminTransport.getServerGroup(currentWashServer.groupId);
        currentOrganization = organizations.where((element) => element.id == currentServerGroup?.organizationId ).first;
        serverGroups = List.from(await WashAdminTransport.getServerGroups(currentOrganization.id ?? ""));
        serverGroups = serverGroups.where((element) => element.organizationId == currentOrganization?.id).toList();
        currentServerGroup = serverGroups.where((element) => element.id == currentServerGroup?.id).first;
        washServers = await ManagementTransport.getWashServers(currentServerGroup.id);
      } else {
        currentOrganization = organizations.first;
        serverGroups = List.from(await WashAdminTransport.getServerGroups(currentOrganization.id));
        serverGroups = serverGroups.where((element) => element.organizationId == currentOrganization?.id).toList();
        currentServerGroup = serverGroups.first;
        washServers = await ManagementTransport.getWashServers(currentServerGroup.id);
        currentWashServer = washServers.length > 0 ? washServers.first : null;
      }
    }

    final servicesServerBindingEntity = ServicesServerBindingEntity(
        serviceUser: serviceUser,
        currentWashServer: currentWashServer,
        organizations: organizations,
        currentOrganization: currentOrganization,
        serverGroups: serverGroups,
        currentServerGroup: currentServerGroup,
        interactionBlocked: false,
        washServers: washServers,
      currentId: washId,
      currentServiceKey: washKey
    );

    final newState = state.copyWith(servicesServerBindingEntity: servicesServerBindingEntity);

    emit(newState);
  }

  Future<void> onChangeOrganization (Organization value) async {
    var servicesServerBindingEntity = state.servicesServerBindingEntity;
    servicesServerBindingEntity = servicesServerBindingEntity.copyWith(interactionBlocked: true);
    emit(state.copyWith(servicesServerBindingEntity: servicesServerBindingEntity));

    var currentOrganization = state.servicesServerBindingEntity.organizations.where((element) => element.id == value.id).first;
    List<ServerGroup> serverGroups = List.from(await WashAdminTransport.getServerGroups(currentOrganization.id));
    serverGroups = serverGroups.where((element) => element.organizationId == currentOrganization.id).toList();
    ServerGroup currentServerGroup = serverGroups.first;

    List<WashServer> washServers = List.from(await ManagementTransport.getWashServers(currentServerGroup.id));
    washServers = washServers.where((element) => element.groupId == currentServerGroup.id).toList();
    WashServer currentWashServer = washServers.length > 0 ? washServers.first : WashServer(id: '', name: '', description: '', serviceKey: '', createdBy: '', groupId: '', organizationId: '');

    servicesServerBindingEntity = state.servicesServerBindingEntity;
    servicesServerBindingEntity = servicesServerBindingEntity.copyWith(
        currentOrganization: currentOrganization,
        serverGroups: serverGroups,
        currentServerGroup: currentServerGroup,
        interactionBlocked: false,
        washServers: washServers,
        currentWashServer: currentWashServer
    );
    emit(state.copyWith(servicesServerBindingEntity: servicesServerBindingEntity));
  }

  Future<void> onChangeServerGroup (ServerGroup value) async {
    var servicesServerBindingEntity = state.servicesServerBindingEntity;
    servicesServerBindingEntity = servicesServerBindingEntity.copyWith(interactionBlocked: true);
    emit(state.copyWith(servicesServerBindingEntity: servicesServerBindingEntity));

    var currentServerGroup = state.servicesServerBindingEntity.serverGroups.where((element) => element.id == value.id).first;
    List<WashServer> washServers = List.from(await ManagementTransport.getWashServers(currentServerGroup.id));
    washServers = washServers.where((element) => element.groupId == currentServerGroup.id).toList();
    WashServer currentWashServer = washServers.length > 0 ? washServers.first : WashServer(id: '', name: '', description: '', serviceKey: '', createdBy: '', groupId: '', organizationId: '');

    servicesServerBindingEntity = state.servicesServerBindingEntity;
    servicesServerBindingEntity = servicesServerBindingEntity.copyWith(
        currentServerGroup: currentServerGroup,
        interactionBlocked: false,
        washServers: washServers,
        currentWashServer: currentWashServer
    );
    emit(state.copyWith(servicesServerBindingEntity: servicesServerBindingEntity));
  }

  Future<void> onChangeWashServer (WashServer value) async {
    var servicesServerBindingEntity = state.servicesServerBindingEntity;
    WashServer? currentWashServer = value;

    servicesServerBindingEntity = servicesServerBindingEntity.copyWith(currentWashServer: currentWashServer);
    emit(state.copyWith(servicesServerBindingEntity: servicesServerBindingEntity));
  }

  Future<void> bindWashServer () async {
    var servicesServerBindingEntity = state.servicesServerBindingEntity;

    String currentId = servicesServerBindingEntity.currentWashServer?.id ?? "";
    String currentServiceKey = servicesServerBindingEntity.currentWashServer?.serviceKey ?? "";

    await LcwTransport.setConfigVarString("management_server_id", currentId);
    await LcwTransport.setConfigVarString("management_service_key", currentServiceKey);

    servicesServerBindingEntity = state.servicesServerBindingEntity;
    servicesServerBindingEntity = servicesServerBindingEntity.copyWith(interactionBlocked: false, currentId: currentId, currentServiceKey: currentServiceKey);
    emit(state.copyWith(servicesServerBindingEntity: servicesServerBindingEntity));
  }

}