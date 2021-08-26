//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StationPrograms {
  /// Returns a new [StationPrograms] instance.
  StationPrograms({
    this.stationID,
    this.name,
    this.preflightSec,
    this.lastUpdate,
    this.relayBoard,
    this.programs = const [],
  });

  int stationID;

  String name;

  int preflightSec;

  int lastUpdate;

  RelayBoard relayBoard;

  List<StationProgramsPrograms> programs;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is StationPrograms && other.stationID == stationID && other.name == name && other.preflightSec == preflightSec && other.lastUpdate == lastUpdate && other.relayBoard == relayBoard && other.programs == programs;

  @override
  int get hashCode =>
      (stationID == null ? 0 : stationID.hashCode) +
      (name == null ? 0 : name.hashCode) +
      (preflightSec == null ? 0 : preflightSec.hashCode) +
      (lastUpdate == null ? 0 : lastUpdate.hashCode) +
      (relayBoard == null ? 0 : relayBoard.hashCode) +
      (programs == null ? 0 : programs.hashCode);

  @override
  String toString() => 'StationPrograms[stationID=$stationID, name=$name, preflightSec=$preflightSec, lastUpdate=$lastUpdate, relayBoard=$relayBoard, programs=$programs]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (stationID != null) {
      json[r'stationID'] = stationID;
    }
    if (name != null) {
      json[r'name'] = name;
    }
    if (preflightSec != null) {
      json[r'preflightSec'] = preflightSec;
    }
    if (lastUpdate != null) {
      json[r'lastUpdate'] = lastUpdate;
    }
    if (relayBoard != null) {
      json[r'relayBoard'] = relayBoard;
    }
    if (programs != null) {
      json[r'programs'] = programs;
    }
    return json;
  }

  /// Returns a new [StationPrograms] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static StationPrograms fromJson(Map<String, dynamic> json) => json == null
      ? null
      : StationPrograms(
          stationID: json[r'stationID'],
          name: json[r'name'],
          preflightSec: json[r'preflightSec'],
          lastUpdate: json[r'lastUpdate'],
          relayBoard: RelayBoard.fromJson(json[r'relayBoard']),
          programs: StationProgramsPrograms.listFromJson(json[r'programs']),
        );

  static List<StationPrograms> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <StationPrograms>[]
          : json.map((dynamic value) => StationPrograms.fromJson(value)).toList(growable: true == growable);

  static Map<String, StationPrograms> mapFromJson(Map<String, dynamic> json) {
    final map = <String, StationPrograms>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = StationPrograms.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of StationPrograms-objects as value to a dart map
  static Map<String, List<StationPrograms>> mapListFromJson(
    Map<String, dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<StationPrograms>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = StationPrograms.listFromJson(
          value,
          emptyIsNull: emptyIsNull,
          growable: growable,
        );
      });
    }
    return map;
  }
}
