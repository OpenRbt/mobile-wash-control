//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgUserDelete {
  /// Returns a new [ArgUserDelete] instance.
  ArgUserDelete({
    @required this.login,
  });

  String login;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgUserDelete &&
     other.login == login;

  @override
  int get hashCode =>
    (login == null ? 0 : login.hashCode);

  @override
  String toString() => 'ArgUserDelete[login=$login]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'login'] = login;
    return json;
  }

  /// Returns a new [ArgUserDelete] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgUserDelete fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ArgUserDelete(
        login: json[r'login'],
    );

  static List<ArgUserDelete> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ArgUserDelete>[]
      : json.map((dynamic value) => ArgUserDelete.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgUserDelete> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgUserDelete>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgUserDelete.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgUserDelete-objects as value to a dart map
  static Map<String, List<ArgUserDelete>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ArgUserDelete>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgUserDelete.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

