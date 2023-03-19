//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgStationReportCurrentMoney {
  /// Returns a new [ArgStationReportCurrentMoney] instance.
  ArgStationReportCurrentMoney({
    @required this.id,
  });

  int id;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgStationReportCurrentMoney &&
     other.id == id;

  @override
  int get hashCode =>
    (id == null ? 0 : id.hashCode);

  @override
  String toString() => 'ArgStationReportCurrentMoney[id=$id]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = id;
    return json;
  }

  /// Returns a new [ArgStationReportCurrentMoney] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgStationReportCurrentMoney fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ArgStationReportCurrentMoney(
        id: json[r'id'],
    );

  static List<ArgStationReportCurrentMoney> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ArgStationReportCurrentMoney>[]
      : json.map((dynamic value) => ArgStationReportCurrentMoney.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgStationReportCurrentMoney> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgStationReportCurrentMoney>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgStationReportCurrentMoney.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgStationReportCurrentMoney-objects as value to a dart map
  static Map<String, List<ArgStationReportCurrentMoney>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ArgStationReportCurrentMoney>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgStationReportCurrentMoney.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

