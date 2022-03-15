//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ResponseUserCreateConflict {
  /// Returns a new [ResponseUserCreateConflict] instance.
  ResponseUserCreateConflict({
    @required this.code,
    @required this.message,
  });

  int code;

  String message;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ResponseUserCreateConflict &&
     other.code == code &&
     other.message == message;

  @override
  int get hashCode =>
    (code == null ? 0 : code.hashCode) +
    (message == null ? 0 : message.hashCode);

  @override
  String toString() => 'ResponseUserCreateConflict[code=$code, message=$message]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'code'] = code;
      json[r'message'] = message;
    return json;
  }

  /// Returns a new [ResponseUserCreateConflict] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ResponseUserCreateConflict fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ResponseUserCreateConflict(
        code: json[r'code'],
        message: json[r'message'],
    );

  static List<ResponseUserCreateConflict> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ResponseUserCreateConflict>[]
      : json.map((dynamic value) => ResponseUserCreateConflict.fromJson(value)).toList(growable: true == growable);

  static Map<String, ResponseUserCreateConflict> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ResponseUserCreateConflict>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ResponseUserCreateConflict.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ResponseUserCreateConflict-objects as value to a dart map
  static Map<String, List<ResponseUserCreateConflict>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ResponseUserCreateConflict>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ResponseUserCreateConflict.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

