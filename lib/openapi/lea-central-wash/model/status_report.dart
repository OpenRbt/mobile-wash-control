//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StatusReport {
  /// Returns a new [StatusReport] instance.
  StatusReport({
    this.lcwInfo,
    this.kasseStatus,
    this.kasseInfo,
    this.stations = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? lcwInfo;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Status? kasseStatus;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? kasseInfo;

  List<StationStatus> stations;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StatusReport &&
     other.lcwInfo == lcwInfo &&
     other.kasseStatus == kasseStatus &&
     other.kasseInfo == kasseInfo &&
     other.stations == stations;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (lcwInfo == null ? 0 : lcwInfo!.hashCode) +
    (kasseStatus == null ? 0 : kasseStatus!.hashCode) +
    (kasseInfo == null ? 0 : kasseInfo!.hashCode) +
    (stations.hashCode);

  @override
  String toString() => 'StatusReport[lcwInfo=$lcwInfo, kasseStatus=$kasseStatus, kasseInfo=$kasseInfo, stations=$stations]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.lcwInfo != null) {
      json[r'lcw_info'] = this.lcwInfo;
    } else {
      json[r'lcw_info'] = null;
    }
    if (this.kasseStatus != null) {
      json[r'kasse_status'] = this.kasseStatus;
    } else {
      json[r'kasse_status'] = null;
    }
    if (this.kasseInfo != null) {
      json[r'kasse_info'] = this.kasseInfo;
    } else {
      json[r'kasse_info'] = null;
    }
      json[r'stations'] = this.stations;
    return json;
  }

  /// Returns a new [StatusReport] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StatusReport? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "StatusReport[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "StatusReport[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return StatusReport(
        lcwInfo: mapValueOfType<String>(json, r'lcw_info'),
        kasseStatus: Status.fromJson(json[r'kasse_status']),
        kasseInfo: mapValueOfType<String>(json, r'kasse_info'),
        stations: StationStatus.listFromJson(json[r'stations']) ?? const [],
      );
    }
    return null;
  }

  static List<StatusReport>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StatusReport>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StatusReport.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StatusReport> mapFromJson(dynamic json) {
    final map = <String, StatusReport>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StatusReport.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StatusReport-objects as value to a dart map
  static Map<String, List<StatusReport>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StatusReport>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StatusReport.listFromJson(entry.value, growable: growable,);
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

