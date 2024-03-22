import 'package:mobile_wash_control/domain/entities/services_entities.dart';
import 'package:mobile_wash_control/domain/entities/user_entity.dart';

class ServicesBonusProgramEntity {

  final ServiceUser? serviceUser;
  final WashServer? bonusWashServer;
  final List<Organization> organizations;
  final Organization? currentOrganization;
  final List<ServerGroup> serverGroups;
  final ServerGroup? currentServerGroup;
  final bool interactionBlocked;

  const ServicesBonusProgramEntity({
    required this.interactionBlocked,
    required this.serviceUser,
    required this.bonusWashServer,
    required this.organizations,
    required this.currentOrganization,
    required this.serverGroups,
    required this.currentServerGroup,
  });

  ServicesBonusProgramEntity copyWith({
    ServiceUser? serviceUser,
    WashServer? bonusWashServer,
    List<Organization>? organizations,
    Organization? currentOrganization,
    List<ServerGroup>? serverGroups,
    ServerGroup? currentServerGroup,
    bool? interactionBlocked,
  }) {
    return ServicesBonusProgramEntity(
      serviceUser: serviceUser ?? this.serviceUser,
      bonusWashServer: bonusWashServer ?? this.bonusWashServer,
      organizations: organizations ?? this.organizations,
      currentOrganization: currentOrganization ?? this.currentOrganization,
      serverGroups: serverGroups ?? this.serverGroups,
      currentServerGroup: currentServerGroup ?? this.currentServerGroup,
      interactionBlocked: interactionBlocked ?? this.interactionBlocked,
    );
  }

  @override
  String toString() {
    return 'ServicesBonusProgramEntity{serviceUser: $serviceUser, bonusWashServer: $bonusWashServer, organizations: $organizations, currentOrganization: $currentOrganization, serverGroups: $serverGroups, currentServerGroup: $currentServerGroup, interactionBlocked: $interactionBlocked}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServicesBonusProgramEntity &&
          runtimeType == other.runtimeType &&
          serviceUser == other.serviceUser &&
          bonusWashServer == other.bonusWashServer &&
          organizations == other.organizations &&
          currentOrganization == other.currentOrganization &&
          serverGroups == other.serverGroups &&
          currentServerGroup == other.currentServerGroup &&
          interactionBlocked == other.interactionBlocked;

  @override
  int get hashCode =>
      serviceUser.hashCode ^
      bonusWashServer.hashCode ^
      organizations.hashCode ^
      currentOrganization.hashCode ^
      serverGroups.hashCode ^
      currentServerGroup.hashCode ^
      interactionBlocked.hashCode;
}

class ServicesSbpEntity {
  final ServiceUser? serviceUser;
  final WashServer? sbpWashServer;
  final List<Organization> organizations;
  final Organization? currentOrganization;
  final List<ServerGroup> serverGroups;
  final ServerGroup? currentServerGroup;
  final String terminalKey;
  final String terminalPassword;
  final bool interactionBlocked;

  const ServicesSbpEntity({
    this.serviceUser,
    this.sbpWashServer,
    required this.organizations,
    this.currentOrganization,
    required this.serverGroups,
    this.currentServerGroup,
    required this.terminalKey,
    required this.terminalPassword,
    required this.interactionBlocked,
  });

  ServicesSbpEntity copyWith({
    ServiceUser? serviceUser,
    WashServer? sbpWashServer,
    List<Organization>? organizations,
    Organization? currentOrganization,
    List<ServerGroup>? serverGroups,
    ServerGroup? currentServerGroup,
    String? terminalKey,
    String? terminalPassword,
    bool? interactionBlocked,
  }) {
    return ServicesSbpEntity(
      serviceUser: serviceUser ?? this.serviceUser,
      sbpWashServer: sbpWashServer ?? this.sbpWashServer,
      organizations: organizations ?? this.organizations,
      currentOrganization: currentOrganization ?? this.currentOrganization,
      serverGroups: serverGroups ?? this.serverGroups,
      currentServerGroup: currentServerGroup ?? this.currentServerGroup,
      terminalKey: terminalKey ?? this.terminalKey,
      terminalPassword: terminalPassword ?? this.terminalPassword,
      interactionBlocked: interactionBlocked ?? this.interactionBlocked,
    );
  }

  @override
  String toString() {
    return 'ServicesSbpEntity{serviceUser: $serviceUser, sbpWashServer: $sbpWashServer, organizations: $organizations, currentOrganization: $currentOrganization, serverGroups: $serverGroups, currentServerGroup: $currentServerGroup, terminalKey: $terminalKey, terminalPassword: $terminalPassword, interactionBlocked: $interactionBlocked}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServicesSbpEntity &&
          runtimeType == other.runtimeType &&
          serviceUser == other.serviceUser &&
          sbpWashServer == other.sbpWashServer &&
          organizations == other.organizations &&
          currentOrganization == other.currentOrganization &&
          serverGroups == other.serverGroups &&
          currentServerGroup == other.currentServerGroup &&
          terminalKey == other.terminalKey &&
          terminalPassword == other.terminalPassword &&
          interactionBlocked == other.interactionBlocked;

  @override
  int get hashCode =>
      serviceUser.hashCode ^
      sbpWashServer.hashCode ^
      organizations.hashCode ^
      currentOrganization.hashCode ^
      serverGroups.hashCode ^
      currentServerGroup.hashCode ^
      terminalKey.hashCode ^
      terminalPassword.hashCode ^
      interactionBlocked.hashCode;
}

class ServicesServerBindingEntity {

  final ServiceUser? serviceUser;
  final List<Organization> organizations;
  final Organization? currentOrganization;
  final List<ServerGroup> serverGroups;
  final ServerGroup? currentServerGroup;
  final List<WashServer> washServers;
  final WashServer? currentWashServer;
  final bool interactionBlocked;
  final String currentId;
  final String currentServiceKey;

  const ServicesServerBindingEntity({
    required this.serviceUser,
    required this.organizations,
    this.currentOrganization,
    required this.serverGroups,
    this.currentServerGroup,
    required this.washServers,
    this.currentWashServer,
    required this.interactionBlocked,
    required this.currentId,
    required this.currentServiceKey,
  });

  ServicesServerBindingEntity copyWith({
    ServiceUser? serviceUser,
    List<Organization>? organizations,
    Organization? currentOrganization,
    List<ServerGroup>? serverGroups,
    ServerGroup? currentServerGroup,
    List<WashServer>? washServers,
    WashServer? currentWashServer,
    bool? interactionBlocked,
    String? currentId,
    String? currentServiceKey,
  }) {
    return ServicesServerBindingEntity(
      serviceUser: serviceUser ?? this.serviceUser,
      organizations: organizations ?? this.organizations,
      currentOrganization: currentOrganization ?? this.currentOrganization,
      serverGroups: serverGroups ?? this.serverGroups,
      currentServerGroup: currentServerGroup ?? this.currentServerGroup,
      washServers: washServers ?? this.washServers,
      currentWashServer: currentWashServer ?? this.currentWashServer,
      interactionBlocked: interactionBlocked ?? this.interactionBlocked,
      currentId: currentId ?? this.currentId,
      currentServiceKey: currentServiceKey ?? this.currentServiceKey,
    );
  }

  @override
  String toString() {
    return 'ServicesServerBindingEntity{serviceUser: $serviceUser, organizations: $organizations, currentOrganization: $currentOrganization, serverGroups: $serverGroups, currentServerGroup: $currentServerGroup, washServers: $washServers, currentWashServer: $currentWashServer, interactionBlocked: $interactionBlocked, currentId: $currentId, currentServiceKey: $currentServiceKey}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServicesServerBindingEntity &&
          runtimeType == other.runtimeType &&
          serviceUser == other.serviceUser &&
          organizations == other.organizations &&
          currentOrganization == other.currentOrganization &&
          serverGroups == other.serverGroups &&
          currentServerGroup == other.currentServerGroup &&
          washServers == other.washServers &&
          currentWashServer == other.currentWashServer &&
          interactionBlocked == other.interactionBlocked &&
          currentId == other.currentId &&
          currentServiceKey == other.currentServiceKey;

  @override
  int get hashCode =>
      serviceUser.hashCode ^
      organizations.hashCode ^
      currentOrganization.hashCode ^
      serverGroups.hashCode ^
      currentServerGroup.hashCode ^
      washServers.hashCode ^
      currentWashServer.hashCode ^
      interactionBlocked.hashCode ^
      currentId.hashCode ^
      currentServiceKey.hashCode;
}