//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class KeyPair {
  /// Returns a new [KeyPair] instance.
  KeyPair({
    @required this.key,
    @required this.value,
  });

  String key;

  String value;

  @override
  bool operator ==(Object other) => identical(this, other) || other is KeyPair &&
     other.key == key &&
     other.value == value;

  @override
  int get hashCode =>
    (key == null ? 0 : key.hashCode) +
    (value == null ? 0 : value.hashCode);

  @override
  String toString() => 'KeyPair[key=$key, value=$value]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'key'] = key;
      json[r'value'] = value;
    return json;
  }

  /// Returns a new [KeyPair] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static KeyPair fromJson(Map<String, dynamic> json) => json == null
    ? null
    : KeyPair(
        key: json[r'key'],
        value: json[r'value'],
    );

  static List<KeyPair> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <KeyPair>[]
      : json.map((dynamic value) => KeyPair.fromJson(value)).toList(growable: true == growable);

  static Map<String, KeyPair> mapFromJson(Map<String, dynamic> json) {
    final map = <String, KeyPair>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = KeyPair.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of KeyPair-objects as value to a dart map
  static Map<String, List<KeyPair>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<KeyPair>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = KeyPair.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

