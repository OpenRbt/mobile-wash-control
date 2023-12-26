//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CreateTask {
  /// Returns a new [CreateTask] instance.
  CreateTask({
    required this.stationID,
    required this.type,
  });

  int stationID;

  CreateTaskTypeEnum type;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CreateTask &&
     other.stationID == stationID &&
     other.type == type;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (stationID.hashCode) +
    (type.hashCode);

  @override
  String toString() => 'CreateTask[stationID=$stationID, type=$type]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'stationID'] = this.stationID;
      json[r'type'] = this.type;
    return json;
  }

  /// Returns a new [CreateTask] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CreateTask? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CreateTask[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CreateTask[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CreateTask(
        stationID: mapValueOfType<int>(json, r'stationID')!,
        type: CreateTaskTypeEnum.fromJson(json[r'type'])!,
      );
    }
    return null;
  }

  static List<CreateTask>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CreateTask>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CreateTask.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CreateTask> mapFromJson(dynamic json) {
    final map = <String, CreateTask>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CreateTask.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CreateTask-objects as value to a dart map
  static Map<String, List<CreateTask>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CreateTask>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CreateTask.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'stationID',
    'type',
  };
}


class CreateTaskTypeEnum {
  /// Instantiate a new enum with the provided [value].
  const CreateTaskTypeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const build = CreateTaskTypeEnum._(r'build');
  static const update = CreateTaskTypeEnum._(r'update');

  /// List of all possible values in this [enum][CreateTaskTypeEnum].
  static const values = <CreateTaskTypeEnum>[
    build,
    update,
  ];

  static CreateTaskTypeEnum? fromJson(dynamic value) => CreateTaskTypeEnumTypeTransformer().decode(value);

  static List<CreateTaskTypeEnum>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CreateTaskTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CreateTaskTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CreateTaskTypeEnum] to String,
/// and [decode] dynamic data back to [CreateTaskTypeEnum].
class CreateTaskTypeEnumTypeTransformer {
  factory CreateTaskTypeEnumTypeTransformer() => _instance ??= const CreateTaskTypeEnumTypeTransformer._();

  const CreateTaskTypeEnumTypeTransformer._();

  String encode(CreateTaskTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a CreateTaskTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CreateTaskTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'build': return CreateTaskTypeEnum.build;
        case r'update': return CreateTaskTypeEnum.update;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [CreateTaskTypeEnumTypeTransformer] instance.
  static CreateTaskTypeEnumTypeTransformer? _instance;
}


