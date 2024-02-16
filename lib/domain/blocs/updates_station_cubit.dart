import 'package:bloc/bloc.dart';
import 'package:mobile_wash_control/domain/entities/lcw_enteties.dart';

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

  UpdatesStationPageCubit(int stationId) : super(
      UpdatesStationPageState(
          updatesStationPageEntity: UpdatesStationPageEntity(
            stationId: stationId,
            currentVersionOnServer: FirmwareVersion(
                id: 0,
                isCurrent: false
            ),
            availableVersions: [],
          )
      )
  ) {
    _initialize();
  }

  Future<void> _initialize() async {
    final firmwareVersions = await LcwTransport.getPostVersions(state.updatesStationPageEntity.stationId);

    final updatesStationPageEntity = state.updatesStationPageEntity.copyWith(avaliableVersions: firmwareVersions);
    final newState = state.copyWith(updatesStationPageEntity: updatesStationPageEntity);

    emit(newState);
  }

  Future<void> setVersion(int versionId, int stationId) async {
    await LcwTransport.createTask(
        taskType: TaskType.setVersion,
        stationID: stationId,
        versionID: versionId
    );
    await reboot(stationId);
  }

  Future<void> uploadVersion(int versionId, int stationId) async {
    await LcwTransport.createTask(
        taskType: TaskType.pullFirmware,
        stationID: stationId,
        versionID: versionId
    );
  }

  Future<void> downLoadVersion(int stationId) async {
    await LcwTransport.createTask(
        taskType: TaskType.update,
        stationID: stationId,
    );

    await reboot(stationId);

  }

  Future<void> update(int stationId) async {
    await LcwTransport.createTask(
      taskType: TaskType.build,
      stationID: stationId,
    );

    await downLoadVersion(stationId);

  }

  Future<void> reboot(int stationId) async {
    await LcwTransport.createTask(
      taskType: TaskType.reboot,
      stationID: stationId,
    );
  }

  Future<void> hashVersions(int stationId) async {
    await LcwTransport.createTask(
      taskType: TaskType.getVersions,
      stationID: stationId,
    );
  }

  //Пока не использовать. Разобраться, как должно работать
  Future<void> copyVersionFromPostToPost(int originStationId, int destinationStationId, int versionId) async {
    await LcwTransport.createTask(
        taskType: TaskType.pullFirmware,
        stationID: originStationId,
        versionID: versionId
    );

    await LcwTransport.copyFromPostToPost(
        originStationId,
        destinationStationId
    );
  }

}