//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgLoadRelay {
  /// Returns a new [ArgLoadRelay] instance.
  ArgLoadRelay({
    @required this.hash,
  });

  String hash;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgLoadRelay && other.hash == hash;

  @override
  int get hashCode => (hash == null ? 0 : hash.hashCode);

  @override
  String toString() => 'ArgLoadRelay[hash=$hash]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'hash'] = hash;
    return json;
  }

  /// Returns a new [ArgLoadRelay] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgLoadRelay fromJson(Map<String, dynamic> json) => json == null
      ? null
      : ArgLoadRelay(
          hash: json[r'hash'],
        );

  static List<ArgLoadRelay> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <ArgLoadRelay>[]
          : json.map((dynamic value) => ArgLoadRelay.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgLoadRelay> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgLoadRelay>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgLoadRelay.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgLoadRelay-objects as value to a dart map
  static Map<String, List<ArgLoadRelay>> mapListFromJson(
    Map<String, dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<ArgLoadRelay>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgLoadRelay.listFromJson(
          value,
          emptyIsNull: emptyIsNull,
          growable: growable,
        );
      });
    }
    return map;
  }
}
