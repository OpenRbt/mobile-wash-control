//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RelayReport {
  /// Returns a new [RelayReport] instance.
  RelayReport({
    required this.hash,
    this.relayStats = const [],
  });

  String hash;

  List<RelayStat> relayStats;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RelayReport &&
     other.hash == hash &&
     other.relayStats == relayStats;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (hash.hashCode) +
    (relayStats.hashCode);

  @override
  String toString() => 'RelayReport[hash=$hash, relayStats=$relayStats]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'hash'] = this.hash;
      json[r'relayStats'] = this.relayStats;
    return json;
  }

  /// Returns a new [RelayReport] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RelayReport? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "RelayReport[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "RelayReport[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return RelayReport(
        hash: mapValueOfType<String>(json, r'hash')!,
        relayStats: RelayStat.listFromJson(json[r'relayStats']) ?? const [],
      );
    }
    return null;
  }

  static List<RelayReport>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <RelayReport>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RelayReport.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RelayReport> mapFromJson(dynamic json) {
    final map = <String, RelayReport>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RelayReport.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RelayReport-objects as value to a dart map
  static Map<String, List<RelayReport>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<RelayReport>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RelayReport.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'hash',
  };
}

