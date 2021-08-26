//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ResponseUserCreate {
  /// Returns a new [ResponseUserCreate] instance.
  ResponseUserCreate({
    @required this.id,
  });

  int id;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ResponseUserCreate && other.id == id;

  @override
  int get hashCode => (id == null ? 0 : id.hashCode);

  @override
  String toString() => 'ResponseUserCreate[id=$id]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'id'] = id;
    return json;
  }

  /// Returns a new [ResponseUserCreate] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ResponseUserCreate fromJson(Map<String, dynamic> json) => json == null
      ? null
      : ResponseUserCreate(
          id: json[r'id'],
        );

  static List<ResponseUserCreate> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <ResponseUserCreate>[]
          : json.map((dynamic value) => ResponseUserCreate.fromJson(value)).toList(growable: true == growable);

  static Map<String, ResponseUserCreate> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ResponseUserCreate>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ResponseUserCreate.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ResponseUserCreate-objects as value to a dart map
  static Map<String, List<ResponseUserCreate>> mapListFromJson(
    Map<String, dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<ResponseUserCreate>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ResponseUserCreate.listFromJson(
          value,
          emptyIsNull: emptyIsNull,
          growable: growable,
        );
      });
    }
    return map;
  }
}
