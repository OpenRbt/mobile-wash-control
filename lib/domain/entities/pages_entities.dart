import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:mobile_wash_control/domain/entities/user_entity.dart';

import 'lcw_enteties.dart';

class ServicesPageEntity {

  final auth.User? firebaseUser;
  final ServiceUser? serviceUser;
  final bool sendApplicationButtonPressed;
  final bool applicationDelivered;

  ServicesPageEntity({
    required this.serviceUser,
    this.firebaseUser,
    required this.sendApplicationButtonPressed,
    required this.applicationDelivered,
  });

  ServicesPageEntity copyWith({
    auth.User? firebaseUser,
    ServiceUser? serviceUser,
    bool? sendApplicationButtonPressed,
    bool? applicationDelivered,
  }) {
    return ServicesPageEntity(
      firebaseUser: firebaseUser ?? this.firebaseUser,
      serviceUser: serviceUser ?? this.serviceUser,
      sendApplicationButtonPressed:
          sendApplicationButtonPressed ?? this.sendApplicationButtonPressed,
      applicationDelivered: applicationDelivered ?? this.applicationDelivered,
    );
  }

  @override
  String toString() {
    return 'ServicesPageEntity{firebaseUser: $firebaseUser, serviceUser: $serviceUser, sendApplicationButtonPressed: $sendApplicationButtonPressed, applicationDelivered: $applicationDelivered}';
  }
}

class TasksPageEntity {

  TasksPagination tasksPagination;
  Map<TaskType, bool> typeFilter;
  Map<TaskStatus, bool> statusFilter;
  List<int> stationFilter;
  bool sorted;

  TasksPageEntity({
    required this.tasksPagination,
    required this.typeFilter,
    required this.statusFilter,
    required this.stationFilter,
    required this.sorted,
  });

  TasksPageEntity copyWith({
    TasksPagination? tasksPagination,
    Map<TaskType, bool>? typeFilter,
    Map<TaskStatus, bool>? statusFilter,
    List<int>? stationFilter,
    bool? sorted,
  }) {
    return TasksPageEntity(
      tasksPagination: tasksPagination ?? this.tasksPagination,
      typeFilter: typeFilter ?? this.typeFilter,
      statusFilter: statusFilter ?? this.statusFilter,
      stationFilter: stationFilter ?? this.stationFilter,
      sorted: sorted ?? this.sorted,
    );
  }

  @override
  String toString() {
    return 'TasksPageEntity{tasksPagination: $tasksPagination, typeFilter: $typeFilter, statusFilter: $statusFilter, stationFilter: $stationFilter, sorted: $sorted}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TasksPageEntity &&
          runtimeType == other.runtimeType &&
          tasksPagination == other.tasksPagination &&
          typeFilter == other.typeFilter &&
          statusFilter == other.statusFilter &&
          stationFilter == other.stationFilter &&
          sorted == other.sorted;

  @override
  int get hashCode =>
      tasksPagination.hashCode ^
      typeFilter.hashCode ^
      statusFilter.hashCode ^
      stationFilter.hashCode ^
      sorted.hashCode;
}

class UpdatesStationPageEntity {
  int stationId;
  FirmwareVersion currentVersionOnServer;
  List<FirmwareVersion> availableVersions;

  UpdatesStationPageEntity({
    required this.stationId,
    required this.currentVersionOnServer,
    required this.availableVersions,
  });

  UpdatesStationPageEntity copyWith({
    int? stationId,
    FirmwareVersion? currentVersion,
    List<FirmwareVersion>? avaliableVersions,
  }) {
    return UpdatesStationPageEntity(
      stationId: stationId ?? this.stationId,
      currentVersionOnServer: currentVersion ?? this.currentVersionOnServer,
      availableVersions: avaliableVersions ?? this.availableVersions,
    );
  }

  @override
  String toString() {
    return 'UpdatesStationPageEntity{stationId: $stationId, currentVersion: $currentVersionOnServer, avaliableVersions: $availableVersions}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdatesStationPageEntity &&
          runtimeType == other.runtimeType &&
          stationId == other.stationId &&
          currentVersionOnServer == other.currentVersionOnServer &&
          availableVersions == other.availableVersions;

  @override
  int get hashCode =>
      stationId.hashCode ^ currentVersionOnServer.hashCode ^ availableVersions.hashCode;
}