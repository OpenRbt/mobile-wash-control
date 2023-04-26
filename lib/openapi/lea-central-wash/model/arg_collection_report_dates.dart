//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgCollectionReportDates {
  /// Returns a new [ArgCollectionReportDates] instance.
  ArgCollectionReportDates({
    this.stationID,
    this.startDate,
    this.endDate,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? stationID;

  /// Unix time
  int? startDate;

  /// Unix time
  int? endDate;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgCollectionReportDates &&
     other.stationID == stationID &&
     other.startDate == startDate &&
     other.endDate == endDate;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (stationID == null ? 0 : stationID!.hashCode) +
    (startDate == null ? 0 : startDate!.hashCode) +
    (endDate == null ? 0 : endDate!.hashCode);

  @override
  String toString() => 'ArgCollectionReportDates[stationID=$stationID, startDate=$startDate, endDate=$endDate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.stationID != null) {
      json[r'stationID'] = this.stationID;
    } else {
      json[r'stationID'] = null;
    }
    if (this.startDate != null) {
      json[r'startDate'] = this.startDate;
    } else {
      json[r'startDate'] = null;
    }
    if (this.endDate != null) {
      json[r'endDate'] = this.endDate;
    } else {
      json[r'endDate'] = null;
    }
    return json;
  }

  /// Returns a new [ArgCollectionReportDates] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ArgCollectionReportDates? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ArgCollectionReportDates[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ArgCollectionReportDates[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ArgCollectionReportDates(
        stationID: mapValueOfType<int>(json, r'stationID'),
        startDate: mapValueOfType<int>(json, r'startDate'),
        endDate: mapValueOfType<int>(json, r'endDate'),
      );
    }
    return null;
  }

  static List<ArgCollectionReportDates>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ArgCollectionReportDates>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ArgCollectionReportDates.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ArgCollectionReportDates> mapFromJson(dynamic json) {
    final map = <String, ArgCollectionReportDates>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgCollectionReportDates.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ArgCollectionReportDates-objects as value to a dart map
  static Map<String, List<ArgCollectionReportDates>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ArgCollectionReportDates>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgCollectionReportDates.listFromJson(entry.value, growable: growable,);
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

