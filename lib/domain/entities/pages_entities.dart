import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:mobile_wash_control/domain/entities/user_entity.dart';
import 'package:mobile_wash_control/entity/entity.dart' as ent;

import 'lcw_entities.dart';

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

class UpdatesPageEntity {
  List<Station> stations;
  String currentApplicationVersion;
  String availableApplicationVersion;
  String downloadUrl;
  bool isDownloadBlocked;
  bool isDownloading;

  UpdatesPageEntity({
    required this.stations,
    required this.currentApplicationVersion,
    required this.availableApplicationVersion,
    required this.downloadUrl,
    required this.isDownloadBlocked,
    required this.isDownloading,
  });

  UpdatesPageEntity copyWith({
    List<Station>? stations,
    String? currentApplicationVersion,
    String? availableApplicationVersion,
    String? downloadUrl,
    bool? isDownloadBlocked,
    bool? isDownloading,
  }) {
    return UpdatesPageEntity(
      stations: stations ?? this.stations,
      currentApplicationVersion:
          currentApplicationVersion ?? this.currentApplicationVersion,
      availableApplicationVersion:
          availableApplicationVersion ?? this.availableApplicationVersion,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      isDownloadBlocked: isDownloadBlocked ?? this.isDownloadBlocked,
      isDownloading: isDownloading ?? this.isDownloading,
    );
  }

  @override
  String toString() {
    return 'UpdatesPageEntity{stations: $stations, currentApplicationVersion: $currentApplicationVersion, availableApplicationVersion: $availableApplicationVersion, downloadUrl: $downloadUrl, isDownloadBlocked: $isDownloadBlocked, isDownloading: $isDownloading}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdatesPageEntity &&
          runtimeType == other.runtimeType &&
          stations == other.stations &&
          currentApplicationVersion == other.currentApplicationVersion &&
          availableApplicationVersion == other.availableApplicationVersion &&
          downloadUrl == other.downloadUrl &&
          isDownloadBlocked == other.isDownloadBlocked &&
          isDownloading == other.isDownloading;

  @override
  int get hashCode =>
      stations.hashCode ^
      currentApplicationVersion.hashCode ^
      availableApplicationVersion.hashCode ^
      downloadUrl.hashCode ^
      isDownloadBlocked.hashCode ^
      isDownloading.hashCode;
}

class UpdatesStationPageEntity {
  int stationId;
  FirmwareVersion? currentVersionOnServer;
  List<FirmwareVersion> availableVersions;
  List<Station> availableStations;
  int? copyFromStationId;

  UpdatesStationPageEntity({
    required this.stationId,
    required this.currentVersionOnServer,
    required this.availableVersions,
    required this.availableStations,
    required this.copyFromStationId,
  });

  UpdatesStationPageEntity copyWith({
    int? stationId,
    FirmwareVersion? currentVersionOnServer,
    List<FirmwareVersion>? availableVersions,
    List<Station>? availableStations,
    int? copyFromStationId,
  }) {
    return UpdatesStationPageEntity(
      stationId: stationId ?? this.stationId,
      currentVersionOnServer:
          currentVersionOnServer ?? this.currentVersionOnServer,
      availableVersions: availableVersions ?? this.availableVersions,
      availableStations: availableStations ?? this.availableStations,
      copyFromStationId: copyFromStationId ?? this.copyFromStationId,
    );
  }

  @override
  String toString() {
    return 'UpdatesStationPageEntity{stationId: $stationId, currentVersionOnServer: $currentVersionOnServer, availableVersions: $availableVersions, availableStations: $availableStations, copyFromStationId: $copyFromStationId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdatesStationPageEntity &&
          runtimeType == other.runtimeType &&
          stationId == other.stationId &&
          currentVersionOnServer == other.currentVersionOnServer &&
          availableVersions == other.availableVersions &&
          availableStations == other.availableStations &&
          copyFromStationId == other.copyFromStationId;

  @override
  int get hashCode =>
      stationId.hashCode ^
      currentVersionOnServer.hashCode ^
      availableVersions.hashCode ^
      availableStations.hashCode ^
      copyFromStationId.hashCode;
}