//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ResponseUserPassword {
  /// Returns a new [ResponseUserPassword] instance.
  ResponseUserPassword({
    @required this.id,
  });

  int id;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ResponseUserPassword &&
     other.id == id;

  @override
  int get hashCode =>
    (id == null ? 0 : id.hashCode);

  @override
  String toString() => 'ResponseUserPassword[id=$id]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = id;
    return json;
  }

  /// Returns a new [ResponseUserPassword] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ResponseUserPassword fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ResponseUserPassword(
        id: json[r'id'],
    );

  static List<ResponseUserPassword> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ResponseUserPassword>[]
      : json.map((dynamic value) => ResponseUserPassword.fromJson(value)).toList(growable: true == growable);

  static Map<String, ResponseUserPassword> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ResponseUserPassword>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ResponseUserPassword.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ResponseUserPassword-objects as value to a dart map
  static Map<String, List<ResponseUserPassword>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ResponseUserPassword>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ResponseUserPassword.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

