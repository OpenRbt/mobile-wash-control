import 'package:mobile_wash_control/domain/entities/services_entities.dart';
import 'package:mobile_wash_control/openapi/lea-central-wash/api.dart';

import '../../Common/lcw_common.dart';
import '../entities/lcw_enteties.dart' as lcw;
import '../entities/pages_entities.dart';

class LcwTransport {
  static Future<void> setConfigVarString(String key, String value) async {

    try {
      final response = await LcwCommon.defaultApi?.setConfigVarString(
          ConfigVarString(
              name: key,
              value: value
          )
      );
    }
    on ApiException catch (e) {
      throw FormatException("${e.code}: ${e.message}");
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> getConfigVarString(String key) async {

    String configVarStringValue = '';

    try {
      final response = await LcwCommon.defaultApi?.getConfigVarString(
          ArgGetConfigVar(
              name: key,
          )
      );
      configVarStringValue = response?.value ?? '';
    }
    on ApiException catch (e) {
      if(e.code == 404) {
        return '';
      }
      throw FormatException("${e.code}: ${e.message}");
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
    return configVarStringValue;
  }

  static Future<lcw.TasksPagination> getTasksPage(TasksPageEntity tasksPageEntity) async {

    late lcw.TasksPagination tasksPagination;
    List<String> statuses = [];
    List<String> types = [];

    tasksPageEntity.statusFilter.forEach((taskStatus, selected) {
      if(selected) {
        statuses.add(taskStatus.name);
      }
    });

    tasksPageEntity.typeFilter.forEach((taskType, selected) {
      if(selected) {
        types.add(taskType.name);
      }
    });

    try {
      final response = await LcwCommon.defaultApi?.getListTasks(
        stationsID: tasksPageEntity.stationFilter.isNotEmpty ? tasksPageEntity.stationFilter : null,
        statuses: statuses.isNotEmpty ? statuses : null,
        types: types.isNotEmpty ? types : null,
        sort: tasksPageEntity.sorted ? "createdAtAsc" : "createdAtDesc",
        page: tasksPageEntity.tasksPagination.page,
        pageSize: tasksPageEntity.tasksPagination.pageSize,
      );

      tasksPagination = lcw.TasksPagination.fromMap(response?.toJson() ?? {});

      response?.items.forEach((element) {
        tasksPagination.tasks.add(lcw.Task.fromMap(element.toJson()));
      });
    }
    on ApiException catch (e) {
      throw FormatException("${e.code}: ${e.message}");
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
    return tasksPagination;
  }

  static Future<List<lcw.FirmwareVersion>> getPostVersions(int id) async {

    List<lcw.FirmwareVersion> firmwareVersions = [];

    try {

      final response = await LcwCommon.defaultApi?.getStationFirmwareVersions(id);

      response?.forEach((element) {
        firmwareVersions.add(lcw.FirmwareVersion.fromMap(element.toJson()));
      });

    } on ApiException catch (e) {
      throw FormatException("${e.code}: ${e.message}");
    } on FormatException catch (e) {
      throw e;
    } catch (e) {
      rethrow;
    }
    return firmwareVersions;
  }

  static Future<void> createTask(
      {required lcw.TaskType taskType, required int stationID, int? versionID}) async {

    try {

      final response = await LcwCommon.defaultApi?.createTask(
        CreateTask(
          stationID: stationID,
          type: TaskType.fromString(taskType.name),
          versionID: versionID
        )
      );

    } on ApiException catch (e) {
      throw FormatException("${e.code}: ${e.message}");
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> copyFromPostToPost(int originStationId, int destinationStationId) async {
    try {
      final response = await LcwCommon.defaultApi?.firmwareVersionsCopy(originStationId, destinationStationId);

    } on ApiException catch (e) {
      throw FormatException("${e.code}: ${e.message}");
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<lcw.Station>> getStations() async {

    List<lcw.Station> stations = [];

    try {
      final response = await LcwCommon.defaultApi?.status();

      response?.stations.where((element) => element.id != null).forEach((element) {
        stations.add(lcw.Station.fromMap(element.toJson()));
      });

    } on ApiException catch (e) {
      throw FormatException("${e.code}: ${e.message}");
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }

    return stations;
  }

}