//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StatusCollectionReport {
  /// Returns a new [StatusCollectionReport] instance.
  StatusCollectionReport({
    this.stations = const [],
  });

  List<CollectionReport> stations;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StatusCollectionReport &&
     other.stations == stations;

  @override
  int get hashCode =>
    (stations == null ? 0 : stations.hashCode);

  @override
  String toString() => 'StatusCollectionReport[stations=$stations]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (stations != null) {
      json[r'stations'] = stations;
    }
    return json;
  }

  /// Returns a new [StatusCollectionReport] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static StatusCollectionReport fromJson(Map<String, dynamic> json) => json == null
    ? null
    : StatusCollectionReport(
        stations: CollectionReport.listFromJson(json[r'stations']),
    );

  static List<StatusCollectionReport> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <StatusCollectionReport>[]
      : json.map((dynamic value) => StatusCollectionReport.fromJson(value)).toList(growable: true == growable);

  static Map<String, StatusCollectionReport> mapFromJson(Map<String, dynamic> json) {
    final map = <String, StatusCollectionReport>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = StatusCollectionReport.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of StatusCollectionReport-objects as value to a dart map
  static Map<String, List<StatusCollectionReport>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<StatusCollectionReport>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = StatusCollectionReport.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

