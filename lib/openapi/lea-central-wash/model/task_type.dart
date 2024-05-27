//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class TaskType {
  /// Instantiate a new enum with the provided [value].
  const TaskType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const build = TaskType._(r'build');
  static const update = TaskType._(r'update');
  static const reboot = TaskType._(r'reboot');
  static const getVersions = TaskType._(r'getVersions');
  static const pullFirmware = TaskType._(r'pullFirmware');
  static const setVersion = TaskType._(r'setVersion');

  /// List of all possible values in this [enum][TaskType].
  static const values = <TaskType>[
    build,
    update,
    reboot,
    getVersions,
    pullFirmware,
    setVersion,
  ];

  static TaskType? fromJson(dynamic value) => TaskTypeTypeTransformer().decode(value);

  static List<TaskType>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TaskType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TaskType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static TaskType fromString(String name) {
    switch(name) {
      case 'build':
        return TaskType.build;
      case 'update':
        return TaskType.update;
      case 'reboot':
        return TaskType.reboot;
      case 'getVersions':
        return TaskType.getVersions;
      case 'pullFirmware':
        return TaskType.pullFirmware;
      case 'setVersion':
        return TaskType.setVersion;
    }
    return TaskType.getVersions;
  }
}

/// Transformation class that can [encode] an instance of [TaskType] to String,
/// and [decode] dynamic data back to [TaskType].
class TaskTypeTypeTransformer {
  factory TaskTypeTypeTransformer() => _instance ??= const TaskTypeTypeTransformer._();

  const TaskTypeTypeTransformer._();

  String encode(TaskType data) => data.value;

  /// Decodes a [dynamic value][data] to a TaskType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  TaskType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'build': return TaskType.build;
        case r'update': return TaskType.update;
        case r'reboot': return TaskType.reboot;
        case r'getVersions': return TaskType.getVersions;
        case r'pullFirmware': return TaskType.pullFirmware;
        case r'setVersion': return TaskType.setVersion;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [TaskTypeTypeTransformer] instance.
  static TaskTypeTypeTransformer? _instance;
}

