//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StationReport {
  /// Returns a new [StationReport] instance.
  StationReport({
    this.moneyReport,
    this.relayStats = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  MoneyReport? moneyReport;

  List<RelayStat> relayStats;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StationReport &&
     other.moneyReport == moneyReport &&
     other.relayStats == relayStats;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (moneyReport == null ? 0 : moneyReport!.hashCode) +
    (relayStats.hashCode);

  @override
  String toString() => 'StationReport[moneyReport=$moneyReport, relayStats=$relayStats]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.moneyReport != null) {
      json[r'moneyReport'] = this.moneyReport;
    } else {
      json[r'moneyReport'] = null;
    }
      json[r'relayStats'] = this.relayStats;
    return json;
  }

  /// Returns a new [StationReport] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StationReport? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "StationReport[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "StationReport[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return StationReport(
        moneyReport: MoneyReport.fromJson(json[r'moneyReport']),
        relayStats: RelayStat.listFromJson(json[r'relayStats']) ?? const [],
      );
    }
    return null;
  }

  static List<StationReport>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StationReport>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StationReport.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StationReport> mapFromJson(dynamic json) {
    final map = <String, StationReport>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StationReport.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StationReport-objects as value to a dart map
  static Map<String, List<StationReport>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StationReport>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StationReport.listFromJson(entry.value, growable: growable,);
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

