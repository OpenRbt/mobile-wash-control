//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgCardReaderConfig {
  /// Returns a new [ArgCardReaderConfig] instance.
  ArgCardReaderConfig({
    @required this.stationID,
  });

  // minimum: 1
  int stationID;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgCardReaderConfig &&
     other.stationID == stationID;

  @override
  int get hashCode =>
    (stationID == null ? 0 : stationID.hashCode);

  @override
  String toString() => 'ArgCardReaderConfig[stationID=$stationID]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'stationID'] = stationID;
    return json;
  }

  /// Returns a new [ArgCardReaderConfig] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgCardReaderConfig fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ArgCardReaderConfig(
        stationID: json[r'stationID'],
    );

  static List<ArgCardReaderConfig> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ArgCardReaderConfig>[]
      : json.map((dynamic value) => ArgCardReaderConfig.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgCardReaderConfig> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgCardReaderConfig>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgCardReaderConfig.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgCardReaderConfig-objects as value to a dart map
  static Map<String, List<ArgCardReaderConfig>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ArgCardReaderConfig>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgCardReaderConfig.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

