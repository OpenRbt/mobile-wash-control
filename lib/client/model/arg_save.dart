//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgSave {
  /// Returns a new [ArgSave] instance.
  ArgSave({
    @required this.hash,
    @required this.keyPair,
  });

  String hash;

  KeyPair keyPair;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgSave && other.hash == hash && other.keyPair == keyPair;

  @override
  int get hashCode => (hash == null ? 0 : hash.hashCode) + (keyPair == null ? 0 : keyPair.hashCode);

  @override
  String toString() => 'ArgSave[hash=$hash, keyPair=$keyPair]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'hash'] = hash;
    json[r'keyPair'] = keyPair;
    return json;
  }

  /// Returns a new [ArgSave] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgSave fromJson(Map<String, dynamic> json) => json == null
      ? null
      : ArgSave(
          hash: json[r'hash'],
          keyPair: KeyPair.fromJson(json[r'keyPair']),
        );

  static List<ArgSave> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <ArgSave>[]
          : json.map((dynamic value) => ArgSave.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgSave> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgSave>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgSave.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgSave-objects as value to a dart map
  static Map<String, List<ArgSave>> mapListFromJson(
    Map<String, dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<ArgSave>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgSave.listFromJson(
          value,
          emptyIsNull: emptyIsNull,
          growable: growable,
        );
      });
    }
    return map;
  }
}
