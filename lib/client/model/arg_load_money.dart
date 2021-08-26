//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgLoadMoney {
  /// Returns a new [ArgLoadMoney] instance.
  ArgLoadMoney({
    @required this.hash,
  });

  String hash;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgLoadMoney && other.hash == hash;

  @override
  int get hashCode => (hash == null ? 0 : hash.hashCode);

  @override
  String toString() => 'ArgLoadMoney[hash=$hash]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'hash'] = hash;
    return json;
  }

  /// Returns a new [ArgLoadMoney] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgLoadMoney fromJson(Map<String, dynamic> json) => json == null
      ? null
      : ArgLoadMoney(
          hash: json[r'hash'],
        );

  static List<ArgLoadMoney> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <ArgLoadMoney>[]
          : json.map((dynamic value) => ArgLoadMoney.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgLoadMoney> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgLoadMoney>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgLoadMoney.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgLoadMoney-objects as value to a dart map
  static Map<String, List<ArgLoadMoney>> mapListFromJson(
    Map<String, dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<ArgLoadMoney>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgLoadMoney.listFromJson(
          value,
          emptyIsNull: emptyIsNull,
          growable: growable,
        );
      });
    }
    return map;
  }
}
