//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgCardReaderConfigByCash {
  /// Returns a new [ArgCardReaderConfigByCash] instance.
  ArgCardReaderConfigByCash({
    @required this.hash,
  });

  String hash;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgCardReaderConfigByCash &&
     other.hash == hash;

  @override
  int get hashCode =>
    (hash == null ? 0 : hash.hashCode);

  @override
  String toString() => 'ArgCardReaderConfigByCash[hash=$hash]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'hash'] = hash;
    return json;
  }

  /// Returns a new [ArgCardReaderConfigByCash] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgCardReaderConfigByCash fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ArgCardReaderConfigByCash(
        hash: json[r'hash'],
    );

  static List<ArgCardReaderConfigByCash> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ArgCardReaderConfigByCash>[]
      : json.map((dynamic value) => ArgCardReaderConfigByCash.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgCardReaderConfigByCash> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgCardReaderConfigByCash>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgCardReaderConfigByCash.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgCardReaderConfigByCash-objects as value to a dart map
  static Map<String, List<ArgCardReaderConfigByCash>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ArgCardReaderConfigByCash>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgCardReaderConfigByCash.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

