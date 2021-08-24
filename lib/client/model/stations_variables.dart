//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StationsVariables {
  /// Returns a new [StationsVariables] instance.
  StationsVariables({
    this.id,
    this.name,
    this.hash,
    this.keyPairs = const [],
  });

  int id;

  String name;

  String hash;

  List<KeyPair> keyPairs;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StationsVariables && other.id == id && other.name == name && other.hash == hash && other.keyPairs == keyPairs;

  @override
  int get hashCode => (id == null ? 0 : id.hashCode) + (name == null ? 0 : name.hashCode) + (hash == null ? 0 : hash.hashCode) + (keyPairs == null ? 0 : keyPairs.hashCode);

  @override
  String toString() => 'StationsVariables[id=$id, name=$name, hash=$hash, keyPairs=$keyPairs]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (id != null) {
      json[r'id'] = id;
    }
    if (name != null) {
      json[r'name'] = name;
    }
    if (hash != null) {
      json[r'hash'] = hash;
    }
    if (keyPairs != null) {
      json[r'keyPairs'] = keyPairs;
    }
    return json;
  }

  /// Returns a new [StationsVariables] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static StationsVariables fromJson(Map<String, dynamic> json) => json == null
      ? null
      : StationsVariables(
          id: json[r'id'],
          name: json[r'name'],
          hash: json[r'hash'],
          keyPairs: KeyPair.listFromJson(json[r'keyPairs']),
        );

  static List<StationsVariables> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <StationsVariables>[]
          : json.map((dynamic value) => StationsVariables.fromJson(value)).toList(growable: true == growable);

  static Map<String, StationsVariables> mapFromJson(Map<String, dynamic> json) {
    final map = <String, StationsVariables>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = StationsVariables.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of StationsVariables-objects as value to a dart map
  static Map<String, List<StationsVariables>> mapListFromJson(
    Map<String, dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<StationsVariables>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = StationsVariables.listFromJson(
          value,
          emptyIsNull: emptyIsNull,
          growable: growable,
        );
      });
    }
    return map;
  }
}
