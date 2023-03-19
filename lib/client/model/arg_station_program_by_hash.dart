//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgStationProgramByHash {
  /// Returns a new [ArgStationProgramByHash] instance.
  ArgStationProgramByHash({
    @required this.hash,
  });

  String hash;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgStationProgramByHash &&
     other.hash == hash;

  @override
  int get hashCode =>
    (hash == null ? 0 : hash.hashCode);

  @override
  String toString() => 'ArgStationProgramByHash[hash=$hash]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'hash'] = hash;
    return json;
  }

  /// Returns a new [ArgStationProgramByHash] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgStationProgramByHash fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ArgStationProgramByHash(
        hash: json[r'hash'],
    );

  static List<ArgStationProgramByHash> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ArgStationProgramByHash>[]
      : json.map((dynamic value) => ArgStationProgramByHash.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgStationProgramByHash> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgStationProgramByHash>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgStationProgramByHash.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgStationProgramByHash-objects as value to a dart map
  static Map<String, List<ArgStationProgramByHash>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ArgStationProgramByHash>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgStationProgramByHash.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

