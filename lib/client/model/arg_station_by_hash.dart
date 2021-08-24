//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgStationByHash {
  /// Returns a new [ArgStationByHash] instance.
  ArgStationByHash({
    @required this.hash,
  });

  String hash;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgStationByHash && other.hash == hash;

  @override
  int get hashCode => (hash == null ? 0 : hash.hashCode);

  @override
  String toString() => 'ArgStationByHash[hash=$hash]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'hash'] = hash;
    return json;
  }

  /// Returns a new [ArgStationByHash] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgStationByHash fromJson(Map<String, dynamic> json) => json == null
      ? null
      : ArgStationByHash(
          hash: json[r'hash'],
        );

  static List<ArgStationByHash> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <ArgStationByHash>[]
          : json.map((dynamic value) => ArgStationByHash.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgStationByHash> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgStationByHash>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgStationByHash.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgStationByHash-objects as value to a dart map
  static Map<String, List<ArgStationByHash>> mapListFromJson(
    Map<String, dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<ArgStationByHash>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgStationByHash.listFromJson(
          value,
          emptyIsNull: emptyIsNull,
          growable: growable,
        );
      });
    }
    return map;
  }
}
