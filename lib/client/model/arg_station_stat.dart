//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgStationStat {
  /// Returns a new [ArgStationStat] instance.
  ArgStationStat({
    this.stationID,
  });

  int stationID;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgStationStat &&
     other.stationID == stationID;

  @override
  int get hashCode =>
    (stationID == null ? 0 : stationID.hashCode);

  @override
  String toString() => 'ArgStationStat[stationID=$stationID]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (stationID != null) {
      json[r'stationID'] = stationID;
    }
    return json;
  }

  /// Returns a new [ArgStationStat] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgStationStat fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ArgStationStat(
        stationID: json[r'stationID'],
    );

  static List<ArgStationStat> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ArgStationStat>[]
      : json.map((dynamic value) => ArgStationStat.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgStationStat> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgStationStat>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgStationStat.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgStationStat-objects as value to a dart map
  static Map<String, List<ArgStationStat>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ArgStationStat>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgStationStat.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

