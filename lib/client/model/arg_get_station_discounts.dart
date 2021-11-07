//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgGetStationDiscounts {
  /// Returns a new [ArgGetStationDiscounts] instance.
  ArgGetStationDiscounts({
    this.hash,
  });

  String hash;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgGetStationDiscounts && other.hash == hash;

  @override
  int get hashCode => (hash == null ? 0 : hash.hashCode);

  @override
  String toString() => 'ArgGetStationDiscounts[hash=$hash]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (hash != null) {
      json[r'hash'] = hash;
    }
    return json;
  }

  /// Returns a new [ArgGetStationDiscounts] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgGetStationDiscounts fromJson(Map<String, dynamic> json) => json == null
      ? null
      : ArgGetStationDiscounts(
          hash: json[r'hash'],
        );

  static List<ArgGetStationDiscounts> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <ArgGetStationDiscounts>[]
          : json.map((dynamic value) => ArgGetStationDiscounts.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgGetStationDiscounts> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgGetStationDiscounts>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgGetStationDiscounts.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgGetStationDiscounts-objects as value to a dart map
  static Map<String, List<ArgGetStationDiscounts>> mapListFromJson(
    Map<String, dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<ArgGetStationDiscounts>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgGetStationDiscounts.listFromJson(
          value,
          emptyIsNull: emptyIsNull,
          growable: growable,
        );
      });
    }
    return map;
  }
}
