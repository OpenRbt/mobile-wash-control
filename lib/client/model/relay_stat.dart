//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RelayStat {
  /// Returns a new [RelayStat] instance.
  RelayStat({
    this.relayID,
    this.switchedCount,
    this.totalTimeOn,
  });

  // minimum: 1
  int relayID;

  int switchedCount;

  int totalTimeOn;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RelayStat && other.relayID == relayID && other.switchedCount == switchedCount && other.totalTimeOn == totalTimeOn;

  @override
  int get hashCode => (relayID == null ? 0 : relayID.hashCode) + (switchedCount == null ? 0 : switchedCount.hashCode) + (totalTimeOn == null ? 0 : totalTimeOn.hashCode);

  @override
  String toString() => 'RelayStat[relayID=$relayID, switchedCount=$switchedCount, totalTimeOn=$totalTimeOn]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (relayID != null) {
      json[r'relayID'] = relayID;
    }
    if (switchedCount != null) {
      json[r'switchedCount'] = switchedCount;
    }
    if (totalTimeOn != null) {
      json[r'totalTimeOn'] = totalTimeOn;
    }
    return json;
  }

  /// Returns a new [RelayStat] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static RelayStat fromJson(Map<String, dynamic> json) => json == null
      ? null
      : RelayStat(
          relayID: json[r'relayID'],
          switchedCount: json[r'switchedCount'],
          totalTimeOn: json[r'totalTimeOn'],
        );

  static List<RelayStat> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <RelayStat>[]
          : json.map((dynamic value) => RelayStat.fromJson(value)).toList(growable: true == growable);

  static Map<String, RelayStat> mapFromJson(Map<String, dynamic> json) {
    final map = <String, RelayStat>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = RelayStat.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of RelayStat-objects as value to a dart map
  static Map<String, List<RelayStat>> mapListFromJson(
    Map<String, dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<RelayStat>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = RelayStat.listFromJson(
          value,
          emptyIsNull: emptyIsNull,
          growable: growable,
        );
      });
    }
    return map;
  }
}
