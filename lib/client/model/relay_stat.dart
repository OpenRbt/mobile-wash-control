//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RelayStat {
  /// Returns a new [RelayStat] instance.
  RelayStat({
    this.relayID,
    this.switchedCount,
    this.totalTimeOn,
  });

  /// Minimum value: 1
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? relayID;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? switchedCount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? totalTimeOn;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RelayStat &&
     other.relayID == relayID &&
     other.switchedCount == switchedCount &&
     other.totalTimeOn == totalTimeOn;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (relayID == null ? 0 : relayID!.hashCode) +
    (switchedCount == null ? 0 : switchedCount!.hashCode) +
    (totalTimeOn == null ? 0 : totalTimeOn!.hashCode);

  @override
  String toString() => 'RelayStat[relayID=$relayID, switchedCount=$switchedCount, totalTimeOn=$totalTimeOn]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.relayID != null) {
      json[r'relayID'] = this.relayID;
    } else {
      json[r'relayID'] = null;
    }
    if (this.switchedCount != null) {
      json[r'switchedCount'] = this.switchedCount;
    } else {
      json[r'switchedCount'] = null;
    }
    if (this.totalTimeOn != null) {
      json[r'totalTimeOn'] = this.totalTimeOn;
    } else {
      json[r'totalTimeOn'] = null;
    }
    return json;
  }

  /// Returns a new [RelayStat] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RelayStat? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "RelayStat[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "RelayStat[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return RelayStat(
        relayID: mapValueOfType<int>(json, r'relayID'),
        switchedCount: mapValueOfType<int>(json, r'switchedCount'),
        totalTimeOn: mapValueOfType<int>(json, r'totalTimeOn'),
      );
    }
    return null;
  }

  static List<RelayStat>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <RelayStat>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RelayStat.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RelayStat> mapFromJson(dynamic json) {
    final map = <String, RelayStat>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RelayStat.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RelayStat-objects as value to a dart map
  static Map<String, List<RelayStat>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<RelayStat>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RelayStat.listFromJson(entry.value, growable: growable,);
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

