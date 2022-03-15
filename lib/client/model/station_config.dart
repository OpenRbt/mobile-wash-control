//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StationConfig {
  /// Returns a new [StationConfig] instance.
  StationConfig({
    @required this.id,
    this.preflightSec,
    this.name,
    this.hash,
    this.relayBoard,
  });

  int id;

  int preflightSec;

  String name;

  String hash;

  RelayBoard relayBoard;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StationConfig &&
     other.id == id &&
     other.preflightSec == preflightSec &&
     other.name == name &&
     other.hash == hash &&
     other.relayBoard == relayBoard;

  @override
  int get hashCode =>
    (id == null ? 0 : id.hashCode) +
    (preflightSec == null ? 0 : preflightSec.hashCode) +
    (name == null ? 0 : name.hashCode) +
    (hash == null ? 0 : hash.hashCode) +
    (relayBoard == null ? 0 : relayBoard.hashCode);

  @override
  String toString() => 'StationConfig[id=$id, preflightSec=$preflightSec, name=$name, hash=$hash, relayBoard=$relayBoard]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = id;
    if (preflightSec != null) {
      json[r'preflightSec'] = preflightSec;
    }
    if (name != null) {
      json[r'name'] = name;
    }
    if (hash != null) {
      json[r'hash'] = hash;
    }
    if (relayBoard != null) {
      json[r'relayBoard'] = relayBoard;
    }
    return json;
  }

  /// Returns a new [StationConfig] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static StationConfig fromJson(Map<String, dynamic> json) => json == null
    ? null
    : StationConfig(
        id: json[r'id'],
        preflightSec: json[r'preflightSec'],
        name: json[r'name'],
        hash: json[r'hash'],
        relayBoard: RelayBoard.fromJson(json[r'relayBoard']),
    );

  static List<StationConfig> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <StationConfig>[]
      : json.map((dynamic value) => StationConfig.fromJson(value)).toList(growable: true == growable);

  static Map<String, StationConfig> mapFromJson(Map<String, dynamic> json) {
    final map = <String, StationConfig>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = StationConfig.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of StationConfig-objects as value to a dart map
  static Map<String, List<StationConfig>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<StationConfig>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = StationConfig.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

