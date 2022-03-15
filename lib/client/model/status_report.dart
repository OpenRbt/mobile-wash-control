//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
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

  String lcwInfo;

  Status kasseStatus;

  String kasseInfo;

  List<StationStatus> stations;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StatusReport &&
     other.lcwInfo == lcwInfo &&
     other.kasseStatus == kasseStatus &&
     other.kasseInfo == kasseInfo &&
     other.stations == stations;

  @override
  int get hashCode =>
    (lcwInfo == null ? 0 : lcwInfo.hashCode) +
    (kasseStatus == null ? 0 : kasseStatus.hashCode) +
    (kasseInfo == null ? 0 : kasseInfo.hashCode) +
    (stations == null ? 0 : stations.hashCode);

  @override
  String toString() => 'StatusReport[lcwInfo=$lcwInfo, kasseStatus=$kasseStatus, kasseInfo=$kasseInfo, stations=$stations]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (lcwInfo != null) {
      json[r'lcw_info'] = lcwInfo;
    }
    if (kasseStatus != null) {
      json[r'kasse_status'] = kasseStatus;
    }
    if (kasseInfo != null) {
      json[r'kasse_info'] = kasseInfo;
    }
    if (stations != null) {
      json[r'stations'] = stations;
    }
    return json;
  }

  /// Returns a new [StatusReport] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static StatusReport fromJson(Map<String, dynamic> json) => json == null
    ? null
    : StatusReport(
        lcwInfo: json[r'lcw_info'],
        kasseStatus: Status.fromJson(json[r'kasse_status']),
        kasseInfo: json[r'kasse_info'],
        stations: StationStatus.listFromJson(json[r'stations']),
    );

  static List<StatusReport> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <StatusReport>[]
      : json.map((dynamic value) => StatusReport.fromJson(value)).toList(growable: true == growable);

  static Map<String, StatusReport> mapFromJson(Map<String, dynamic> json) {
    final map = <String, StatusReport>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = StatusReport.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of StatusReport-objects as value to a dart map
  static Map<String, List<StatusReport>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<StatusReport>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = StatusReport.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

