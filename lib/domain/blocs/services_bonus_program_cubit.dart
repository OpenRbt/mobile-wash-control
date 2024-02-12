import 'package:bloc/bloc.dart';
import 'package:mobile_wash_control/domain/data_providers/lcw_transport.dart';
import 'package:mobile_wash_control/domain/entities/services_entities.dart';

import '../data_providers/bonus_transport.dart';
import '../data_providers/wash_admin_transport.dart';
import '../entities/segments_entities.dart';
import '../entities/user_entity.dart';

class ServicesBonusProgramSegmentState {
  final ServicesBonusProgramEntity servicesBonusProgramEntity;

  const ServicesBonusProgramSegmentState({
    required this.servicesBonusProgramEntity,
  });

  ServicesBonusProgramSegmentState copyWith({
    ServicesBonusProgramEntity? servicesBonusProgramEntity,
  }) {
    return ServicesBonusProgramSegmentState(
      servicesBonusProgramEntity:
          servicesBonusProgramEntity ?? this.servicesBonusProgramEntity,
    );
  }

  @override
  String toString() {
    return 'ServicesBonusProgramSegmentState{servicesBonusProgramEntity: $servicesBonusProgramEntity}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServicesBonusProgramSegmentState &&
          runtimeType == other.runtimeType &&
          servicesBonusProgramEntity == other.servicesBonusProgramEntity;

  @override
  int get hashCode => servicesBonusProgramEntity.hashCode;
}

class ServicesBonusProgramSegmentCubit extends Cubit<ServicesBonusProgramSegmentState> {

  ServicesBonusProgramSegmentCubit(ServiceUser serviceUser) : super(
      ServicesBonusProgramSegmentState(
          servicesBonusProgramEntity: ServicesBonusProgramEntity(
              serviceUser: serviceUser,
              bonusWashServer: null,
              organizations: [],
              currentOrganization: null,
              serverGroups: [],
              currentServerGroup: null,
            interactionBlocked: true
          )
      )
  ) {
    _initialize(serviceUser);
  }

  Future<void> _initialize(ServiceUser serviceUser) async {

    String washId = '';
    String washKey = '';

    WashServer? bonusWashServer;
    ServerGroup? currentServerGroup;
    Organization? currentOrganization;

    List<ServerGroup> serverGroups = [];
    List<Organization> organizations = [];

    try {
      washId = await LcwTransport.getConfigVarString("server_id");
      washKey = await LcwTransport.getConfigVarString("server_key");
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }

    if (washId.isNotEmpty && washKey.isNotEmpty) {
      bonusWashServer = await BonusTransport.getBonusWashServer(washId);
    }

    if(serviceUser.role == ServiceUserRole.admin) {
      currentOrganization = await WashAdminTransport.getOrganization(serviceUser.organizationId);
      serverGroups = List.from(await WashAdminTransport.getServerGroups(null));
      currentServerGroup = bonusWashServer != null ? serverGroups.where((element) => element.id == bonusWashServer?.groupId).first : serverGroups.first;
    } else {
      organizations = List.from(await WashAdminTransport.getOrganizations());

      if(bonusWashServer != null) {
        currentServerGroup = await WashAdminTransport.getServerGroup(bonusWashServer.groupId);
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

    final servicesBonusProgramEntity = ServicesBonusProgramEntity(
        serviceUser: serviceUser,
        bonusWashServer: bonusWashServer ?? WashServer(id: '', name: '', description: '', serviceKey: '', createdBy: '', groupId: currentServerGroup.id, organizationId: currentOrganization?.id ?? ''),
        organizations: organizations,
        currentOrganization: currentOrganization,
        serverGroups: serverGroups,
        currentServerGroup: currentServerGroup,
        interactionBlocked: false
    );

    final newState = state.copyWith(servicesBonusProgramEntity: servicesBonusProgramEntity);

    emit(newState);
  }

  void onNameChanged (String newName) {
    var servicesBonusProgramEntity = state.servicesBonusProgramEntity;
    var currentWash = servicesBonusProgramEntity.bonusWashServer;

    currentWash = currentWash?.copyWith(name: newName);
    servicesBonusProgramEntity = servicesBonusProgramEntity.copyWith(bonusWashServer: currentWash);

    emit(state.copyWith(servicesBonusProgramEntity: servicesBonusProgramEntity));
  }

  void onDescriptionChanged (String newDescription) {
    var servicesBonusProgramEntity = state.servicesBonusProgramEntity;
    var currentWash = servicesBonusProgramEntity.bonusWashServer;

    currentWash = currentWash?.copyWith(description: newDescription);
    servicesBonusProgramEntity = servicesBonusProgramEntity.copyWith(bonusWashServer: currentWash);

    emit(state.copyWith(servicesBonusProgramEntity: servicesBonusProgramEntity));
  }

  Future<void> onChangeOrganization (Organization value) async {
    var servicesBonusProgramEntity = state.servicesBonusProgramEntity;
    servicesBonusProgramEntity = servicesBonusProgramEntity.copyWith(interactionBlocked: true);
    emit(state.copyWith(servicesBonusProgramEntity: servicesBonusProgramEntity));

    var currentOrganization = state.servicesBonusProgramEntity.organizations.where((element) => element.id == value.id).first;
    List<ServerGroup> serverGroups = List.from(await WashAdminTransport.getServerGroups(currentOrganization.id));
    serverGroups = serverGroups.where((element) => element.organizationId == currentOrganization.id).toList();
    ServerGroup currentServerGroup = serverGroups.first;
    WashServer? bonusWashServer = servicesBonusProgramEntity.bonusWashServer?.copyWith(groupId: currentServerGroup.id, organizationId: currentOrganization.id);

    servicesBonusProgramEntity = state.servicesBonusProgramEntity;
    servicesBonusProgramEntity = servicesBonusProgramEntity.copyWith(currentOrganization: currentOrganization, serverGroups: serverGroups, currentServerGroup: currentServerGroup, interactionBlocked: false, bonusWashServer: bonusWashServer);
    emit(state.copyWith(servicesBonusProgramEntity: servicesBonusProgramEntity));
  }

  Future<void> onChangeServerGroup (ServerGroup value) async {
    var servicesBonusProgramEntity = state.servicesBonusProgramEntity;
    WashServer? bonusWashServer = servicesBonusProgramEntity.bonusWashServer?.copyWith(groupId: value.id);

    servicesBonusProgramEntity = servicesBonusProgramEntity.copyWith(currentServerGroup: value, bonusWashServer: bonusWashServer);
    emit(state.copyWith(servicesBonusProgramEntity: servicesBonusProgramEntity));
  }

  Future<void> registerBonusWashServer () async {
    var servicesBonusProgramEntity = state.servicesBonusProgramEntity;
    servicesBonusProgramEntity = servicesBonusProgramEntity.copyWith(interactionBlocked: true);
    emit(state.copyWith(servicesBonusProgramEntity: servicesBonusProgramEntity));

    var bonusWashServer = await BonusTransport.registerBonusWashServer(servicesBonusProgramEntity.bonusWashServer!);
    await LcwTransport.setConfigVarString("server_id", bonusWashServer.id);
    await LcwTransport.setConfigVarString("server_key", bonusWashServer.serviceKey);

    servicesBonusProgramEntity = state.servicesBonusProgramEntity;
    servicesBonusProgramEntity = servicesBonusProgramEntity.copyWith(interactionBlocked: false, bonusWashServer: bonusWashServer);
    emit(state.copyWith(servicesBonusProgramEntity: servicesBonusProgramEntity));
  }

  Future<void> updateBonusWashServer () async {
    var servicesBonusProgramEntity = state.servicesBonusProgramEntity;
    await BonusTransport.updateBonusWashServer(servicesBonusProgramEntity.bonusWashServer!);
  }

}