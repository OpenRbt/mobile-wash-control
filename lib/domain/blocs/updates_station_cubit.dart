import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wash_control/domain/entities/lcw_entities.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../mobile/widgets/common/snackBars.dart';
import '../data_providers/lcw_transport.dart';
import '../entities/pages_entities.dart';

class UpdatesStationPageState {
  UpdatesStationPageEntity updatesStationPageEntity;

  UpdatesStationPageState({
    required this.updatesStationPageEntity,
  });

  UpdatesStationPageState copyWith({
    UpdatesStationPageEntity? updatesStationPageEntity,
  }) {
    return UpdatesStationPageState(
      updatesStationPageEntity:
          updatesStationPageEntity ?? this.updatesStationPageEntity,
    );
  }

  @override
  String toString() {
    return 'UpdatesStationPageState{updatesStationPageEntity: $updatesStationPageEntity}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdatesStationPageState &&
          runtimeType == other.runtimeType &&
          updatesStationPageEntity == other.updatesStationPageEntity;

  @override
  int get hashCode => updatesStationPageEntity.hashCode;
}

class UpdatesStationPageCubit extends Cubit<UpdatesStationPageState> {

  UpdatesStationPageCubit(int stationId, {required BuildContext context}) : super(
      UpdatesStationPageState(
          updatesStationPageEntity: UpdatesStationPageEntity(
            stationId: stationId,
            currentVersionOnServer: null,
            availableVersions: [],
            availableStations: [],
            copyFromStationId: null,
          )
      )
  ) {
    _initialize(context);
  }

  Future<void> _initialize(BuildContext context) async {

    int stationId = state.updatesStationPageEntity.stationId;

    try {
      final firmwareVersions = await LcwTransport.getPostVersions(stationId);

      final stations = await LcwTransport.getStations();

      final availableStations = stations.where((station) => ((station.hash?.isNotEmpty ?? false) && stationId != station.id && station.status.toString() == 'StationStatus.online')).toList();

      final copyFromStationId = availableStations.length > 0 ? availableStations[0].id : null;

      FirmwareVersion? currentVersionOnServer = null;

      if(copyFromStationId != null) {
        currentVersionOnServer = await LcwTransport.getBufferedVersion(copyFromStationId);
      }

      final updatesStationPageEntity = state.updatesStationPageEntity.copyWith(
          availableVersions: firmwareVersions,
          availableStations: availableStations,
          copyFromStationId: copyFromStationId,
          currentVersionOnServer: currentVersionOnServer
      );
      final newState = state.copyWith(updatesStationPageEntity: updatesStationPageEntity);

      emit(newState);
    } on FormatException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${'error_has_occurred'.tr()} $e"));
      rethrow;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${'unknown_error_has_occurred'.tr()} $e"));
      rethrow;
    }
  }

  Future<void> setVersion(int versionId) async {
    try {
      await LcwTransport.createTask(
          taskType: TaskType.setVersion,
          stationID: state.updatesStationPageEntity.stationId,
          versionID: versionId
      );
      await reboot();
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> uploadVersion(int versionId) async {
    try {
      await LcwTransport.createTask(
          taskType: TaskType.pullFirmware,
          stationID: state.updatesStationPageEntity.stationId,
          versionID: versionId
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> downLoadVersion() async {
    try {
      await LcwTransport.createTask(
        taskType: TaskType.update,
        stationID: state.updatesStationPageEntity.stationId,
      );

      await reboot();
    } on FormatException catch (e) {
    rethrow;
    } catch (e) {
    rethrow;
    }

  }

  Future<void> update() async {
    try {
      await LcwTransport.createTask(
        taskType: TaskType.build,
        stationID: state.updatesStationPageEntity.stationId,
      );

      await downLoadVersion();
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> reboot() async {
    try {
      await LcwTransport.createTask(
        taskType: TaskType.reboot,
        stationID: state.updatesStationPageEntity.stationId,
      );
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> hashVersions() async {
    try {
      await LcwTransport.createTask(
        taskType: TaskType.getVersions,
        stationID: state.updatesStationPageEntity.stationId,
      );
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changeCopyFromStationId(int id) async {
    try {

      print(id.toString());

      final currentVersionOnServer = await LcwTransport.getBufferedVersion(id);

      final newState = state.copyWith(updatesStationPageEntity: state.updatesStationPageEntity.copyWith(
          copyFromStationId: id,
          currentVersionOnServer: currentVersionOnServer
      ));

      emit(newState);
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> copyVersionFromPostToPost() async {
    try {
      await LcwTransport.copyFromPostToPost(
          state.updatesStationPageEntity.copyFromStationId!,
          state.updatesStationPageEntity.stationId
      );
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }



}