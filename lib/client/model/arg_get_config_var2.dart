//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgGetConfigVar2 {
  /// Returns a new [ArgGetConfigVar2] instance.
  ArgGetConfigVar2({
    this.name,
  });

  String name;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgGetConfigVar2 &&
     other.name == name;

  @override
  int get hashCode =>
    (name == null ? 0 : name.hashCode);

  @override
  String toString() => 'ArgGetConfigVar2[name=$name]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (name != null) {
      json[r'name'] = name;
    }
    return json;
  }

  /// Returns a new [ArgGetConfigVar2] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgGetConfigVar2 fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ArgGetConfigVar2(
        name: json[r'name'],
    );

  static List<ArgGetConfigVar2> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ArgGetConfigVar2>[]
      : json.map((dynamic value) => ArgGetConfigVar2.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgGetConfigVar2> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgGetConfigVar2>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgGetConfigVar2.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgGetConfigVar2-objects as value to a dart map
  static Map<String, List<ArgGetConfigVar2>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ArgGetConfigVar2>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgGetConfigVar2.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

