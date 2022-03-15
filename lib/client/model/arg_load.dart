//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgLoad {
  /// Returns a new [ArgLoad] instance.
  ArgLoad({
    @required this.hash,
    @required this.key,
  });

  String hash;

  String key;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgLoad &&
     other.hash == hash &&
     other.key == key;

  @override
  int get hashCode =>
    (hash == null ? 0 : hash.hashCode) +
    (key == null ? 0 : key.hashCode);

  @override
  String toString() => 'ArgLoad[hash=$hash, key=$key]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'hash'] = hash;
      json[r'key'] = key;
    return json;
  }

  /// Returns a new [ArgLoad] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgLoad fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ArgLoad(
        hash: json[r'hash'],
        key: json[r'key'],
    );

  static List<ArgLoad> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ArgLoad>[]
      : json.map((dynamic value) => ArgLoad.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgLoad> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgLoad>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgLoad.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgLoad-objects as value to a dart map
  static Map<String, List<ArgLoad>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ArgLoad>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgLoad.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

