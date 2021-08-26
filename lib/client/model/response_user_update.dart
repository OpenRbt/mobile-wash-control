//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ResponseUserUpdate {
  /// Returns a new [ResponseUserUpdate] instance.
  ResponseUserUpdate({
    @required this.id,
  });

  int id;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ResponseUserUpdate && other.id == id;

  @override
  int get hashCode => (id == null ? 0 : id.hashCode);

  @override
  String toString() => 'ResponseUserUpdate[id=$id]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'id'] = id;
    return json;
  }

  /// Returns a new [ResponseUserUpdate] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ResponseUserUpdate fromJson(Map<String, dynamic> json) => json == null
      ? null
      : ResponseUserUpdate(
          id: json[r'id'],
        );

  static List<ResponseUserUpdate> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <ResponseUserUpdate>[]
          : json.map((dynamic value) => ResponseUserUpdate.fromJson(value)).toList(growable: true == growable);

  static Map<String, ResponseUserUpdate> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ResponseUserUpdate>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ResponseUserUpdate.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ResponseUserUpdate-objects as value to a dart map
  static Map<String, List<ResponseUserUpdate>> mapListFromJson(
    Map<String, dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<ResponseUserUpdate>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ResponseUserUpdate.listFromJson(
          value,
          emptyIsNull: emptyIsNull,
          growable: growable,
        );
      });
    }
    return map;
  }
}
