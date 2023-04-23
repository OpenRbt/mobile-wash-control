//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgStationReportDates {
  /// Returns a new [ArgStationReportDates] instance.
  ArgStationReportDates({
    required this.id,
    required this.startDate,
    required this.endDate,
  });

  int id;

  /// Unix time
  int startDate;

  /// Unix time
  int endDate;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgStationReportDates &&
     other.id == id &&
     other.startDate == startDate &&
     other.endDate == endDate;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (startDate.hashCode) +
    (endDate.hashCode);

  @override
  String toString() => 'ArgStationReportDates[id=$id, startDate=$startDate, endDate=$endDate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'startDate'] = this.startDate;
      json[r'endDate'] = this.endDate;
    return json;
  }

  /// Returns a new [ArgStationReportDates] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ArgStationReportDates? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ArgStationReportDates[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ArgStationReportDates[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ArgStationReportDates(
        id: mapValueOfType<int>(json, r'id')!,
        startDate: mapValueOfType<int>(json, r'startDate')!,
        endDate: mapValueOfType<int>(json, r'endDate')!,
      );
    }
    return null;
  }

  static List<ArgStationReportDates>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ArgStationReportDates>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ArgStationReportDates.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ArgStationReportDates> mapFromJson(dynamic json) {
    final map = <String, ArgStationReportDates>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgStationReportDates.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ArgStationReportDates-objects as value to a dart map
  static Map<String, List<ArgStationReportDates>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ArgStationReportDates>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgStationReportDates.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'startDate',
    'endDate',
  };
}

