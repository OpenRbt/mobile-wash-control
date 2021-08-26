//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RelayReport {
  /// Returns a new [RelayReport] instance.
  RelayReport({
    @required this.hash,
    this.relayStats = const [],
  });

  String hash;

  List<RelayStat> relayStats;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RelayReport && other.hash == hash && other.relayStats == relayStats;

  @override
  int get hashCode => (hash == null ? 0 : hash.hashCode) + (relayStats == null ? 0 : relayStats.hashCode);

  @override
  String toString() => 'RelayReport[hash=$hash, relayStats=$relayStats]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'hash'] = hash;
    if (relayStats != null) {
      json[r'relayStats'] = relayStats;
    }
    return json;
  }

  /// Returns a new [RelayReport] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static RelayReport fromJson(Map<String, dynamic> json) => json == null
      ? null
      : RelayReport(
          hash: json[r'hash'],
          relayStats: RelayStat.listFromJson(json[r'relayStats']),
        );

  static List<RelayReport> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <RelayReport>[]
          : json.map((dynamic value) => RelayReport.fromJson(value)).toList(growable: true == growable);

  static Map<String, RelayReport> mapFromJson(Map<String, dynamic> json) {
    final map = <String, RelayReport>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = RelayReport.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of RelayReport-objects as value to a dart map
  static Map<String, List<RelayReport>> mapListFromJson(
    Map<String, dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<RelayReport>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = RelayReport.listFromJson(
          value,
          emptyIsNull: emptyIsNull,
          growable: growable,
        );
      });
    }
    return map;
  }
}
