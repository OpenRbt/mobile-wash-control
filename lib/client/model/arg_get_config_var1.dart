//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgGetConfigVar1 {
  /// Returns a new [ArgGetConfigVar1] instance.
  ArgGetConfigVar1({
    this.name,
  });

  String name;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgGetConfigVar1 &&
     other.name == name;

  @override
  int get hashCode =>
    (name == null ? 0 : name.hashCode);

  @override
  String toString() => 'ArgGetConfigVar1[name=$name]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (name != null) {
      json[r'name'] = name;
    }
    return json;
  }

  /// Returns a new [ArgGetConfigVar1] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgGetConfigVar1 fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ArgGetConfigVar1(
        name: json[r'name'],
    );

  static List<ArgGetConfigVar1> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ArgGetConfigVar1>[]
      : json.map((dynamic value) => ArgGetConfigVar1.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgGetConfigVar1> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgGetConfigVar1>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgGetConfigVar1.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgGetConfigVar1-objects as value to a dart map
  static Map<String, List<ArgGetConfigVar1>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ArgGetConfigVar1>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgGetConfigVar1.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}
