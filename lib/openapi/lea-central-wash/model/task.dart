//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Task {
  /// Returns a new [Task] instance.
  Task({
    required this.id,
    required this.stationID,
    this.versionID,
    required this.type,
    required this.status,
    required this.retryCount,
    this.error,
    required this.createdAt,
    this.startedAt,
    this.stoppedAt,
  });

  int id;

  int stationID;

  int? versionID;

  TaskType type;

  TaskStatus status;

  int retryCount;

  String? error;

  DateTime createdAt;

  DateTime? startedAt;

  DateTime? stoppedAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Task &&
     other.id == id &&
     other.stationID == stationID &&
     other.versionID == versionID &&
     other.type == type &&
     other.status == status &&
     other.retryCount == retryCount &&
     other.error == error &&
     other.createdAt == createdAt &&
     other.startedAt == startedAt &&
     other.stoppedAt == stoppedAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (stationID.hashCode) +
    (versionID == null ? 0 : versionID!.hashCode) +
    (type.hashCode) +
    (status.hashCode) +
    (retryCount.hashCode) +
    (error == null ? 0 : error!.hashCode) +
    (createdAt.hashCode) +
    (startedAt == null ? 0 : startedAt!.hashCode) +
    (stoppedAt == null ? 0 : stoppedAt!.hashCode);

  @override
  String toString() => 'Task[id=$id, stationID=$stationID, versionID=$versionID, type=$type, status=$status, retryCount=$retryCount, error=$error, createdAt=$createdAt, startedAt=$startedAt, stoppedAt=$stoppedAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'stationID'] = this.stationID;
    if (this.versionID != null) {
      json[r'versionID'] = this.versionID;
    } else {
      json[r'versionID'] = null;
    }
      json[r'type'] = this.type;
      json[r'status'] = this.status;
      json[r'retryCount'] = this.retryCount;
    if (this.error != null) {
      json[r'error'] = this.error;
    } else {
      json[r'error'] = null;
    }
      json[r'createdAt'] = this.createdAt.toUtc().toIso8601String();
    if (this.startedAt != null) {
      json[r'startedAt'] = this.startedAt!.toUtc().toIso8601String();
    } else {
      json[r'startedAt'] = null;
    }
    if (this.stoppedAt != null) {
      json[r'stoppedAt'] = this.stoppedAt!.toUtc().toIso8601String();
    } else {
      json[r'stoppedAt'] = null;
    }
    return json;
  }

  /// Returns a new [Task] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Task? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Task[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Task[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Task(
        id: mapValueOfType<int>(json, r'id')!,
        stationID: mapValueOfType<int>(json, r'stationID')!,
        versionID: mapValueOfType<int>(json, r'versionID'),
        type: TaskType.fromJson(json[r'type'])!,
        status: TaskStatus.fromJson(json[r'status'])!,
        retryCount: mapValueOfType<int>(json, r'retryCount')!,
        error: mapValueOfType<String>(json, r'error'),
        createdAt: mapDateTime(json, r'createdAt', '')!,
        startedAt: mapDateTime(json, r'startedAt', ''),
        stoppedAt: mapDateTime(json, r'stoppedAt', ''),
      );
    }
    return null;
  }

  static List<Task>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Task>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Task.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Task> mapFromJson(dynamic json) {
    final map = <String, Task>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Task.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Task-objects as value to a dart map
  static Map<String, List<Task>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Task>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Task.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'stationID',
    'type',
    'status',
    'retryCount',
    'createdAt',
  };
}

