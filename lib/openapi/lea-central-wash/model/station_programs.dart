//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StationPrograms {
  /// Returns a new [StationPrograms] instance.
  StationPrograms({
    this.stationID,
    this.name,
    this.preflightSec,
    this.lastUpdate,
    this.relayBoard,
    this.programs = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? stationID;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? preflightSec;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? lastUpdate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  RelayBoard? relayBoard;

  List<StationProgramsProgramsInner> programs;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StationPrograms &&
     other.stationID == stationID &&
     other.name == name &&
     other.preflightSec == preflightSec &&
     other.lastUpdate == lastUpdate &&
     other.relayBoard == relayBoard &&
     other.programs == programs;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (stationID == null ? 0 : stationID!.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (preflightSec == null ? 0 : preflightSec!.hashCode) +
    (lastUpdate == null ? 0 : lastUpdate!.hashCode) +
    (relayBoard == null ? 0 : relayBoard!.hashCode) +
    (programs.hashCode);

  @override
  String toString() => 'StationPrograms[stationID=$stationID, name=$name, preflightSec=$preflightSec, lastUpdate=$lastUpdate, relayBoard=$relayBoard, programs=$programs]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.stationID != null) {
      json[r'stationID'] = this.stationID;
    } else {
      json[r'stationID'] = null;
    }
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.preflightSec != null) {
      json[r'preflightSec'] = this.preflightSec;
    } else {
      json[r'preflightSec'] = null;
    }
    if (this.lastUpdate != null) {
      json[r'lastUpdate'] = this.lastUpdate;
    } else {
      json[r'lastUpdate'] = null;
    }
    if (this.relayBoard != null) {
      json[r'relayBoard'] = this.relayBoard;
    } else {
      json[r'relayBoard'] = null;
    }
      json[r'programs'] = this.programs;
    return json;
  }

  /// Returns a new [StationPrograms] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StationPrograms? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "StationPrograms[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "StationPrograms[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return StationPrograms(
        stationID: mapValueOfType<int>(json, r'stationID'),
        name: mapValueOfType<String>(json, r'name'),
        preflightSec: mapValueOfType<int>(json, r'preflightSec'),
        lastUpdate: mapValueOfType<int>(json, r'lastUpdate'),
        relayBoard: RelayBoard.fromJson(json[r'relayBoard']),
        programs: StationProgramsProgramsInner.listFromJson(json[r'programs']) ?? const [],
      );
    }
    return null;
  }

  static List<StationPrograms>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StationPrograms>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StationPrograms.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StationPrograms> mapFromJson(dynamic json) {
    final map = <String, StationPrograms>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StationPrograms.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StationPrograms-objects as value to a dart map
  static Map<String, List<StationPrograms>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StationPrograms>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StationPrograms.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

