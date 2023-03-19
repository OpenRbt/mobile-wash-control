//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class InlineObject {
  /// Returns a new [InlineObject] instance.
  InlineObject({
    @required this.hash,
  });

  String hash;

  @override
  bool operator ==(Object other) => identical(this, other) || other is InlineObject &&
     other.hash == hash;

  @override
  int get hashCode =>
    (hash == null ? 0 : hash.hashCode);

  @override
  String toString() => 'InlineObject[hash=$hash]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'hash'] = hash;
    return json;
  }

  /// Returns a new [InlineObject] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static InlineObject fromJson(Map<String, dynamic> json) => json == null
    ? null
    : InlineObject(
        hash: json[r'hash'],
    );

  static List<InlineObject> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <InlineObject>[]
      : json.map((dynamic value) => InlineObject.fromJson(value)).toList(growable: true == growable);

  static Map<String, InlineObject> mapFromJson(Map<String, dynamic> json) {
    final map = <String, InlineObject>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = InlineObject.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of InlineObject-objects as value to a dart map
  static Map<String, List<InlineObject>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<InlineObject>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = InlineObject.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

