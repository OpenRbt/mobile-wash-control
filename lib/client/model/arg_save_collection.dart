//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgSaveCollection {
  /// Returns a new [ArgSaveCollection] instance.
  ArgSaveCollection({
    @required this.id,
  });

  int id;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgSaveCollection &&
     other.id == id;

  @override
  int get hashCode =>
    (id == null ? 0 : id.hashCode);

  @override
  String toString() => 'ArgSaveCollection[id=$id]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = id;
    return json;
  }

  /// Returns a new [ArgSaveCollection] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgSaveCollection fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ArgSaveCollection(
        id: json[r'id'],
    );

  static List<ArgSaveCollection> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ArgSaveCollection>[]
      : json.map((dynamic value) => ArgSaveCollection.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgSaveCollection> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgSaveCollection>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgSaveCollection.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgSaveCollection-objects as value to a dart map
  static Map<String, List<ArgSaveCollection>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ArgSaveCollection>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgSaveCollection.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

