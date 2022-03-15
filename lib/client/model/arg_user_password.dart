//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgUserPassword {
  /// Returns a new [ArgUserPassword] instance.
  ArgUserPassword({
    @required this.login,
    @required this.oldPassword,
    @required this.newPassword,
  });

  String login;

  String oldPassword;

  String newPassword;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgUserPassword &&
     other.login == login &&
     other.oldPassword == oldPassword &&
     other.newPassword == newPassword;

  @override
  int get hashCode =>
    (login == null ? 0 : login.hashCode) +
    (oldPassword == null ? 0 : oldPassword.hashCode) +
    (newPassword == null ? 0 : newPassword.hashCode);

  @override
  String toString() => 'ArgUserPassword[login=$login, oldPassword=$oldPassword, newPassword=$newPassword]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'login'] = login;
      json[r'oldPassword'] = oldPassword;
      json[r'newPassword'] = newPassword;
    return json;
  }

  /// Returns a new [ArgUserPassword] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgUserPassword fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ArgUserPassword(
        login: json[r'login'],
        oldPassword: json[r'oldPassword'],
        newPassword: json[r'newPassword'],
    );

  static List<ArgUserPassword> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ArgUserPassword>[]
      : json.map((dynamic value) => ArgUserPassword.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgUserPassword> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgUserPassword>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgUserPassword.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgUserPassword-objects as value to a dart map
  static Map<String, List<ArgUserPassword>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ArgUserPassword>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgUserPassword.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

