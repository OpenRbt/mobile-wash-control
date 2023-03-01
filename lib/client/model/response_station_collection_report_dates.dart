//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ResponseStationCollectionReportDates {
  /// Returns a new [ResponseStationCollectionReportDates] instance.
  ResponseStationCollectionReportDates({
    this.collectionReports = const [],
  });

  List<CollectionReportWithUser> collectionReports;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ResponseStationCollectionReportDates &&
     other.collectionReports == collectionReports;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (collectionReports.hashCode);

  @override
  String toString() => 'ResponseStationCollectionReportDates[collectionReports=$collectionReports]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'collectionReports'] = this.collectionReports;
    return json;
  }

  /// Returns a new [ResponseStationCollectionReportDates] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ResponseStationCollectionReportDates? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ResponseStationCollectionReportDates[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ResponseStationCollectionReportDates[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ResponseStationCollectionReportDates(
        collectionReports: CollectionReportWithUser.listFromJson(json[r'collectionReports'])!,
      );
    }
    return null;
  }

  static List<ResponseStationCollectionReportDates>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ResponseStationCollectionReportDates>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ResponseStationCollectionReportDates.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ResponseStationCollectionReportDates> mapFromJson(dynamic json) {
    final map = <String, ResponseStationCollectionReportDates>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ResponseStationCollectionReportDates.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ResponseStationCollectionReportDates-objects as value to a dart map
  static Map<String, List<ResponseStationCollectionReportDates>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ResponseStationCollectionReportDates>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ResponseStationCollectionReportDates.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'collectionReports',
  };
}

