//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SetBuildScript {
  /// Returns a new [SetBuildScript] instance.
  SetBuildScript({
    required this.stationID,
    required this.name,
    this.commangs = const [],
  });

  int stationID;

  String name;

  List<String> commangs;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SetBuildScript &&
     other.stationID == stationID &&
     other.name == name &&
     other.commangs == commangs;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (stationID.hashCode) +
    (name.hashCode) +
    (commangs.hashCode);

  @override
  String toString() => 'SetBuildScript[stationID=$stationID, name=$name, commangs=$commangs]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'stationID'] = this.stationID;
      json[r'name'] = this.name;
      json[r'commangs'] = this.commangs;
    return json;
  }

  /// Returns a new [SetBuildScript] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SetBuildScript? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SetBuildScript[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SetBuildScript[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SetBuildScript(
        stationID: mapValueOfType<int>(json, r'stationID')!,
        name: mapValueOfType<String>(json, r'name')!,
        commangs: json[r'commangs'] is List
            ? (json[r'commangs'] as List).cast<String>()
            : const [],
      );
    }
    return null;
  }

  static List<SetBuildScript>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SetBuildScript>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SetBuildScript.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SetBuildScript> mapFromJson(dynamic json) {
    final map = <String, SetBuildScript>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SetBuildScript.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SetBuildScript-objects as value to a dart map
  static Map<String, List<SetBuildScript>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SetBuildScript>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SetBuildScript.listFromJson(entry.value, growable: growable,);
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
    'name',
    'commangs',
  };
}

