//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StationStat {
  /// Returns a new [StationStat] instance.
  StationStat({
    this.stationID,
    this.pumpTimeOn,
    this.relayStats = const [],
    this.programStats = const [],
  });

  int stationID;

  int pumpTimeOn;

  List<RelayStat> relayStats;

  List<ProgramStat> programStats;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StationStat &&
     other.stationID == stationID &&
     other.pumpTimeOn == pumpTimeOn &&
     other.relayStats == relayStats &&
     other.programStats == programStats;

  @override
  int get hashCode =>
    (stationID == null ? 0 : stationID.hashCode) +
    (pumpTimeOn == null ? 0 : pumpTimeOn.hashCode) +
    (relayStats == null ? 0 : relayStats.hashCode) +
    (programStats == null ? 0 : programStats.hashCode);

  @override
  String toString() => 'StationStat[stationID=$stationID, pumpTimeOn=$pumpTimeOn, relayStats=$relayStats, programStats=$programStats]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (stationID != null) {
      json[r'stationID'] = stationID;
    }
    if (pumpTimeOn != null) {
      json[r'pumpTimeOn'] = pumpTimeOn;
    }
    if (relayStats != null) {
      json[r'relayStats'] = relayStats;
    }
    if (programStats != null) {
      json[r'programStats'] = programStats;
    }
    return json;
  }

  /// Returns a new [StationStat] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static StationStat fromJson(Map<String, dynamic> json) => json == null
    ? null
    : StationStat(
        stationID: json[r'stationID'],
        pumpTimeOn: json[r'pumpTimeOn'],
        relayStats: RelayStat.listFromJson(json[r'relayStats']),
        programStats: ProgramStat.listFromJson(json[r'programStats']),
    );

  static List<StationStat> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <StationStat>[]
      : json.map((dynamic value) => StationStat.fromJson(value)).toList(growable: true == growable);

  static Map<String, StationStat> mapFromJson(Map<String, dynamic> json) {
    final map = <String, StationStat>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = StationStat.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of StationStat-objects as value to a dart map
  static Map<String, List<StationStat>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<StationStat>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = StationStat.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

