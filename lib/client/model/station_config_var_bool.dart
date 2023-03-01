//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StationConfigVarBool {
  /// Returns a new [StationConfigVarBool] instance.
  StationConfigVarBool({
    required this.name,
    required this.value,
    this.description,
    this.note,
    required this.stationID,
  });

  String name;

  bool value;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? description;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? note;

  int stationID;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StationConfigVarBool &&
     other.name == name &&
     other.value == value &&
     other.description == description &&
     other.note == note &&
     other.stationID == stationID;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (value.hashCode) +
    (description == null ? 0 : description!.hashCode) +
    (note == null ? 0 : note!.hashCode) +
    (stationID.hashCode);

  @override
  String toString() => 'StationConfigVarBool[name=$name, value=$value, description=$description, note=$note, stationID=$stationID]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
      json[r'value'] = this.value;
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
    if (this.note != null) {
      json[r'note'] = this.note;
    } else {
      json[r'note'] = null;
    }
      json[r'stationID'] = this.stationID;
    return json;
  }

  /// Returns a new [StationConfigVarBool] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StationConfigVarBool? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "StationConfigVarBool[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "StationConfigVarBool[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return StationConfigVarBool(
        name: mapValueOfType<String>(json, r'name')!,
        value: mapValueOfType<bool>(json, r'value')!,
        description: mapValueOfType<String>(json, r'description'),
        note: mapValueOfType<String>(json, r'note'),
        stationID: mapValueOfType<int>(json, r'stationID')!,
      );
    }
    return null;
  }

  static List<StationConfigVarBool>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StationConfigVarBool>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StationConfigVarBool.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StationConfigVarBool> mapFromJson(dynamic json) {
    final map = <String, StationConfigVarBool>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StationConfigVarBool.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StationConfigVarBool-objects as value to a dart map
  static Map<String, List<StationConfigVarBool>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StationConfigVarBool>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StationConfigVarBool.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
    'value',
    'stationID',
  };
}

