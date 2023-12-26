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
    required this.type,
    required this.status,
    this.error,
    required this.createdAt,
    this.startedAt,
    this.stoppedAt,
  });

  int id;

  int stationID;

  TaskTypeEnum type;

  TaskStatusEnum status;

  String? error;

  DateTime createdAt;

  DateTime? startedAt;

  DateTime? stoppedAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Task &&
     other.id == id &&
     other.stationID == stationID &&
     other.type == type &&
     other.status == status &&
     other.error == error &&
     other.createdAt == createdAt &&
     other.startedAt == startedAt &&
     other.stoppedAt == stoppedAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (stationID.hashCode) +
    (type.hashCode) +
    (status.hashCode) +
    (error == null ? 0 : error!.hashCode) +
    (createdAt.hashCode) +
    (startedAt == null ? 0 : startedAt!.hashCode) +
    (stoppedAt == null ? 0 : stoppedAt!.hashCode);

  @override
  String toString() => 'Task[id=$id, stationID=$stationID, type=$type, status=$status, error=$error, createdAt=$createdAt, startedAt=$startedAt, stoppedAt=$stoppedAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'stationID'] = this.stationID;
      json[r'type'] = this.type;
      json[r'status'] = this.status;
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
        type: TaskTypeEnum.fromJson(json[r'type'])!,
        status: TaskStatusEnum.fromJson(json[r'status'])!,
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
    'createdAt',
  };
}


class TaskTypeEnum {
  /// Instantiate a new enum with the provided [value].
  const TaskTypeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const build = TaskTypeEnum._(r'build');
  static const update = TaskTypeEnum._(r'update');

  /// List of all possible values in this [enum][TaskTypeEnum].
  static const values = <TaskTypeEnum>[
    build,
    update,
  ];

  static TaskTypeEnum? fromJson(dynamic value) => TaskTypeEnumTypeTransformer().decode(value);

  static List<TaskTypeEnum>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TaskTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TaskTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [TaskTypeEnum] to String,
/// and [decode] dynamic data back to [TaskTypeEnum].
class TaskTypeEnumTypeTransformer {
  factory TaskTypeEnumTypeTransformer() => _instance ??= const TaskTypeEnumTypeTransformer._();

  const TaskTypeEnumTypeTransformer._();

  String encode(TaskTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a TaskTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  TaskTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'build': return TaskTypeEnum.build;
        case r'update': return TaskTypeEnum.update;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [TaskTypeEnumTypeTransformer] instance.
  static TaskTypeEnumTypeTransformer? _instance;
}



class TaskStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const TaskStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const queue = TaskStatusEnum._(r'queue');
  static const started = TaskStatusEnum._(r'started');
  static const completed = TaskStatusEnum._(r'completed');
  static const error = TaskStatusEnum._(r'error');

  /// List of all possible values in this [enum][TaskStatusEnum].
  static const values = <TaskStatusEnum>[
    queue,
    started,
    completed,
    error,
  ];

  static TaskStatusEnum? fromJson(dynamic value) => TaskStatusEnumTypeTransformer().decode(value);

  static List<TaskStatusEnum>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TaskStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TaskStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [TaskStatusEnum] to String,
/// and [decode] dynamic data back to [TaskStatusEnum].
class TaskStatusEnumTypeTransformer {
  factory TaskStatusEnumTypeTransformer() => _instance ??= const TaskStatusEnumTypeTransformer._();

  const TaskStatusEnumTypeTransformer._();

  String encode(TaskStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a TaskStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  TaskStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'queue': return TaskStatusEnum.queue;
        case r'started': return TaskStatusEnum.started;
        case r'completed': return TaskStatusEnum.completed;
        case r'error': return TaskStatusEnum.error;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [TaskStatusEnumTypeTransformer] instance.
  static TaskStatusEnumTypeTransformer? _instance;
}


