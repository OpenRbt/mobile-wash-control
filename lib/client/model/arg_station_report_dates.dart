//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgStationReportDates {
  /// Returns a new [ArgStationReportDates] instance.
  ArgStationReportDates({
    @required this.id,
    @required this.startDate,
    @required this.endDate,
  });

  int id;

  /// Unix time
  int startDate;

  /// Unix time
  int endDate;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgStationReportDates && other.id == id && other.startDate == startDate && other.endDate == endDate;

  @override
  int get hashCode => (id == null ? 0 : id.hashCode) + (startDate == null ? 0 : startDate.hashCode) + (endDate == null ? 0 : endDate.hashCode);

  @override
  String toString() => 'ArgStationReportDates[id=$id, startDate=$startDate, endDate=$endDate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'id'] = id;
    json[r'startDate'] = startDate;
    json[r'endDate'] = endDate;
    return json;
  }

  /// Returns a new [ArgStationReportDates] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgStationReportDates fromJson(Map<String, dynamic> json) => json == null
      ? null
      : ArgStationReportDates(
          id: json[r'id'],
          startDate: json[r'startDate'],
          endDate: json[r'endDate'],
        );

  static List<ArgStationReportDates> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <ArgStationReportDates>[]
          : json.map((dynamic value) => ArgStationReportDates.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgStationReportDates> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgStationReportDates>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgStationReportDates.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgStationReportDates-objects as value to a dart map
  static Map<String, List<ArgStationReportDates>> mapListFromJson(
    Map<String, dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<ArgStationReportDates>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgStationReportDates.listFromJson(
          value,
          emptyIsNull: emptyIsNull,
          growable: growable,
        );
      });
    }
    return map;
  }
}
