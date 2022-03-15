//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgCollectionReportDates {
  /// Returns a new [ArgCollectionReportDates] instance.
  ArgCollectionReportDates({
    this.stationID,
    this.startDate,
    this.endDate,
  });

  int stationID;

  /// Unix time
  int startDate;

  /// Unix time
  int endDate;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgCollectionReportDates &&
     other.stationID == stationID &&
     other.startDate == startDate &&
     other.endDate == endDate;

  @override
  int get hashCode =>
    (stationID == null ? 0 : stationID.hashCode) +
    (startDate == null ? 0 : startDate.hashCode) +
    (endDate == null ? 0 : endDate.hashCode);

  @override
  String toString() => 'ArgCollectionReportDates[stationID=$stationID, startDate=$startDate, endDate=$endDate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (stationID != null) {
      json[r'stationID'] = stationID;
    }
    if (startDate != null) {
      json[r'startDate'] = startDate;
    }
    if (endDate != null) {
      json[r'endDate'] = endDate;
    }
    return json;
  }

  /// Returns a new [ArgCollectionReportDates] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgCollectionReportDates fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ArgCollectionReportDates(
        stationID: json[r'stationID'],
        startDate: json[r'startDate'],
        endDate: json[r'endDate'],
    );

  static List<ArgCollectionReportDates> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ArgCollectionReportDates>[]
      : json.map((dynamic value) => ArgCollectionReportDates.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgCollectionReportDates> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgCollectionReportDates>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgCollectionReportDates.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgCollectionReportDates-objects as value to a dart map
  static Map<String, List<ArgCollectionReportDates>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ArgCollectionReportDates>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgCollectionReportDates.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

