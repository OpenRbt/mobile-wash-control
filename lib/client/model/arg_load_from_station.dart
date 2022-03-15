//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgLoadFromStation {
  /// Returns a new [ArgLoadFromStation] instance.
  ArgLoadFromStation({
    @required this.hash,
    @required this.stationID,
    @required this.key,
  });

  String hash;

  int stationID;

  String key;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgLoadFromStation &&
     other.hash == hash &&
     other.stationID == stationID &&
     other.key == key;

  @override
  int get hashCode =>
    (hash == null ? 0 : hash.hashCode) +
    (stationID == null ? 0 : stationID.hashCode) +
    (key == null ? 0 : key.hashCode);

  @override
  String toString() => 'ArgLoadFromStation[hash=$hash, stationID=$stationID, key=$key]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'hash'] = hash;
      json[r'stationID'] = stationID;
      json[r'key'] = key;
    return json;
  }

  /// Returns a new [ArgLoadFromStation] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgLoadFromStation fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ArgLoadFromStation(
        hash: json[r'hash'],
        stationID: json[r'stationID'],
        key: json[r'key'],
    );

  static List<ArgLoadFromStation> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ArgLoadFromStation>[]
      : json.map((dynamic value) => ArgLoadFromStation.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgLoadFromStation> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgLoadFromStation>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgLoadFromStation.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgLoadFromStation-objects as value to a dart map
  static Map<String, List<ArgLoadFromStation>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ArgLoadFromStation>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgLoadFromStation.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

