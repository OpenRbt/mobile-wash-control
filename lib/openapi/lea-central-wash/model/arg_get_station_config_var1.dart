//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgGetStationConfigVar1 {
  /// Returns a new [ArgGetStationConfigVar1] instance.
  ArgGetStationConfigVar1({
    required this.name,
    required this.stationID,
  });

  String name;

  int stationID;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgGetStationConfigVar1 &&
     other.name == name &&
     other.stationID == stationID;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (stationID.hashCode);

  @override
  String toString() => 'ArgGetStationConfigVar1[name=$name, stationID=$stationID]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
      json[r'stationID'] = this.stationID;
    return json;
  }

  /// Returns a new [ArgGetStationConfigVar1] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ArgGetStationConfigVar1? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ArgGetStationConfigVar1[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ArgGetStationConfigVar1[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ArgGetStationConfigVar1(
        name: mapValueOfType<String>(json, r'name')!,
        stationID: mapValueOfType<int>(json, r'stationID')!,
      );
    }
    return null;
  }

  static List<ArgGetStationConfigVar1>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ArgGetStationConfigVar1>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ArgGetStationConfigVar1.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ArgGetStationConfigVar1> mapFromJson(dynamic json) {
    final map = <String, ArgGetStationConfigVar1>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgGetStationConfigVar1.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ArgGetStationConfigVar1-objects as value to a dart map
  static Map<String, List<ArgGetStationConfigVar1>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ArgGetStationConfigVar1>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgGetStationConfigVar1.listFromJson(entry.value, growable: growable,);
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
    'stationID',
  };
}

