//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
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
    (collectionReports == null ? 0 : collectionReports.hashCode);

  @override
  String toString() => 'ResponseStationCollectionReportDates[collectionReports=$collectionReports]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'collectionReports'] = collectionReports;
    return json;
  }

  /// Returns a new [ResponseStationCollectionReportDates] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ResponseStationCollectionReportDates fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ResponseStationCollectionReportDates(
        collectionReports: CollectionReportWithUser.listFromJson(json[r'collectionReports']),
    );

  static List<ResponseStationCollectionReportDates> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ResponseStationCollectionReportDates>[]
      : json.map((dynamic value) => ResponseStationCollectionReportDates.fromJson(value)).toList(growable: true == growable);

  static Map<String, ResponseStationCollectionReportDates> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ResponseStationCollectionReportDates>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ResponseStationCollectionReportDates.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ResponseStationCollectionReportDates-objects as value to a dart map
  static Map<String, List<ResponseStationCollectionReportDates>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ResponseStationCollectionReportDates>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ResponseStationCollectionReportDates.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

