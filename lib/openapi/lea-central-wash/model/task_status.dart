//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class TaskStatus {
  /// Instantiate a new enum with the provided [value].
  const TaskStatus._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const queue = TaskStatus._(r'queue');
  static const started = TaskStatus._(r'started');
  static const completed = TaskStatus._(r'completed');
  static const error = TaskStatus._(r'error');
  static const canceled = TaskStatus._(r'canceled');

  /// List of all possible values in this [enum][TaskStatus].
  static const values = <TaskStatus>[
    queue,
    started,
    completed,
    error,
    canceled,
  ];

  static TaskStatus? fromJson(dynamic value) => TaskStatusTypeTransformer().decode(value);

  static List<TaskStatus>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TaskStatus>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TaskStatus.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [TaskStatus] to String,
/// and [decode] dynamic data back to [TaskStatus].
class TaskStatusTypeTransformer {
  factory TaskStatusTypeTransformer() => _instance ??= const TaskStatusTypeTransformer._();

  const TaskStatusTypeTransformer._();

  String encode(TaskStatus data) => data.value;

  /// Decodes a [dynamic value][data] to a TaskStatus.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  TaskStatus? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'queue': return TaskStatus.queue;
        case r'started': return TaskStatus.started;
        case r'completed': return TaskStatus.completed;
        case r'error': return TaskStatus.error;
        case r'canceled': return TaskStatus.canceled;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [TaskStatusTypeTransformer] instance.
  static TaskStatusTypeTransformer? _instance;
}

