//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StationStat {
  /// Returns a new [StationStat] instance.
  StationStat({
    this.stationID,
    this.pumpTimeOn,
    this.relayStats = const [],
    this.programStats = const [],
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
  int? pumpTimeOn;

  List<RelayStat> relayStats;

  List<ProgramStat> programStats;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StationStat &&
     other.stationID == stationID &&
     other.pumpTimeOn == pumpTimeOn &&
     other.relayStats == relayStats &&
     other.programStats == programStats;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (stationID == null ? 0 : stationID!.hashCode) +
    (pumpTimeOn == null ? 0 : pumpTimeOn!.hashCode) +
    (relayStats.hashCode) +
    (programStats.hashCode);

  @override
  String toString() => 'StationStat[stationID=$stationID, pumpTimeOn=$pumpTimeOn, relayStats=$relayStats, programStats=$programStats]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.stationID != null) {
      json[r'stationID'] = this.stationID;
    } else {
      json[r'stationID'] = null;
    }
    if (this.pumpTimeOn != null) {
      json[r'pumpTimeOn'] = this.pumpTimeOn;
    } else {
      json[r'pumpTimeOn'] = null;
    }
      json[r'relayStats'] = this.relayStats;
      json[r'programStats'] = this.programStats;
    return json;
  }

  /// Returns a new [StationStat] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StationStat? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "StationStat[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "StationStat[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return StationStat(
        stationID: mapValueOfType<int>(json, r'stationID'),
        pumpTimeOn: mapValueOfType<int>(json, r'pumpTimeOn'),
        relayStats: RelayStat.listFromJson(json[r'relayStats']) ?? const [],
        programStats: ProgramStat.listFromJson(json[r'programStats']) ?? const [],
      );
    }
    return null;
  }

  static List<StationStat>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StationStat>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StationStat.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StationStat> mapFromJson(dynamic json) {
    final map = <String, StationStat>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StationStat.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StationStat-objects as value to a dart map
  static Map<String, List<StationStat>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StationStat>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StationStat.listFromJson(entry.value, growable: growable,);
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

