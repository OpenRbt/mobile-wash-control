//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StationReport {
  /// Returns a new [StationReport] instance.
  StationReport({
    this.moneyReport,
    this.relayStats = const [],
  });

  MoneyReport moneyReport;

  List<RelayStat> relayStats;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StationReport && other.moneyReport == moneyReport && other.relayStats == relayStats;

  @override
  int get hashCode => (moneyReport == null ? 0 : moneyReport.hashCode) + (relayStats == null ? 0 : relayStats.hashCode);

  @override
  String toString() => 'StationReport[moneyReport=$moneyReport, relayStats=$relayStats]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (moneyReport != null) {
      json[r'moneyReport'] = moneyReport;
    }
    if (relayStats != null) {
      json[r'relayStats'] = relayStats;
    }
    return json;
  }

  /// Returns a new [StationReport] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static StationReport fromJson(Map<String, dynamic> json) => json == null
      ? null
      : StationReport(
          moneyReport: MoneyReport.fromJson(json[r'moneyReport']),
          relayStats: RelayStat.listFromJson(json[r'relayStats']),
        );

  static List<StationReport> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <StationReport>[]
          : json.map((dynamic value) => StationReport.fromJson(value)).toList(growable: true == growable);

  static Map<String, StationReport> mapFromJson(Map<String, dynamic> json) {
    final map = <String, StationReport>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = StationReport.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of StationReport-objects as value to a dart map
  static Map<String, List<StationReport>> mapListFromJson(
    Map<String, dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<StationReport>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = StationReport.listFromJson(
          value,
          emptyIsNull: emptyIsNull,
          growable: growable,
        );
      });
    }
    return map;
  }
}
