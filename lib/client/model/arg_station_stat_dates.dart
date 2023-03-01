//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgStationStatDates {
  /// Returns a new [ArgStationStatDates] instance.
  ArgStationStatDates({
    this.stationID,
    required this.startDate,
    required this.endDate,
  });

  int? stationID;

  /// Unix time
  int startDate;

  /// Unix time
  int endDate;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgStationStatDates &&
     other.stationID == stationID &&
     other.startDate == startDate &&
     other.endDate == endDate;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (stationID == null ? 0 : stationID!.hashCode) +
    (startDate.hashCode) +
    (endDate.hashCode);

  @override
  String toString() => 'ArgStationStatDates[stationID=$stationID, startDate=$startDate, endDate=$endDate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.stationID != null) {
      json[r'stationID'] = this.stationID;
    } else {
      json[r'stationID'] = null;
    }
      json[r'startDate'] = this.startDate;
      json[r'endDate'] = this.endDate;
    return json;
  }

  /// Returns a new [ArgStationStatDates] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ArgStationStatDates? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ArgStationStatDates[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ArgStationStatDates[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ArgStationStatDates(
        stationID: mapValueOfType<int>(json, r'stationID'),
        startDate: mapValueOfType<int>(json, r'startDate')!,
        endDate: mapValueOfType<int>(json, r'endDate')!,
      );
    }
    return null;
  }

  static List<ArgStationStatDates>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ArgStationStatDates>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ArgStationStatDates.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ArgStationStatDates> mapFromJson(dynamic json) {
    final map = <String, ArgStationStatDates>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgStationStatDates.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ArgStationStatDates-objects as value to a dart map
  static Map<String, List<ArgStationStatDates>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ArgStationStatDates>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgStationStatDates.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'startDate',
    'endDate',
  };
}

