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
    this.versionID,
    required this.type,
  });

  int stationID;

  int? versionID;

  TaskType type;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CreateTask &&
     other.stationID == stationID &&
     other.versionID == versionID &&
     other.type == type;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (stationID.hashCode) +
    (versionID == null ? 0 : versionID!.hashCode) +
    (type.hashCode);

  @override
  String toString() => 'CreateTask[stationID=$stationID, versionID=$versionID, type=$type]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'stationID'] = this.stationID;
    if (this.versionID != null) {
      json[r'versionID'] = this.versionID;
    } else {
      json[r'versionID'] = null;
    }
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
        versionID: mapValueOfType<int>(json, r'versionID'),
        type: TaskType.fromJson(json[r'type'])!,
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

