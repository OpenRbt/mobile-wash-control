//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgResetStationStat {
  /// Returns a new [ArgResetStationStat] instance.
  ArgResetStationStat({
    @required this.stationID,
  });

  int stationID;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgResetStationStat &&
     other.stationID == stationID;

  @override
  int get hashCode =>
    (stationID == null ? 0 : stationID.hashCode);

  @override
  String toString() => 'ArgResetStationStat[stationID=$stationID]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'stationID'] = stationID;
    return json;
  }

  /// Returns a new [ArgResetStationStat] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgResetStationStat fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ArgResetStationStat(
        stationID: json[r'stationID'],
    );

  static List<ArgResetStationStat> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ArgResetStationStat>[]
      : json.map((dynamic value) => ArgResetStationStat.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgResetStationStat> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgResetStationStat>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgResetStationStat.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgResetStationStat-objects as value to a dart map
  static Map<String, List<ArgResetStationStat>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ArgResetStationStat>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgResetStationStat.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

