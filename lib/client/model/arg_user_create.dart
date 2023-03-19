//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgUserCreate {
  /// Returns a new [ArgUserCreate] instance.
  ArgUserCreate({
    @required this.login,
    this.firstName,
    this.middleName,
    this.lastName,
    this.isAdmin,
    this.isOperator,
    this.isEngineer,
    @required this.password,
  });

  String login;

  String firstName;

  String middleName;

  String lastName;

  bool isAdmin;

  bool isOperator;

  bool isEngineer;

  String password;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgUserCreate &&
     other.login == login &&
     other.firstName == firstName &&
     other.middleName == middleName &&
     other.lastName == lastName &&
     other.isAdmin == isAdmin &&
     other.isOperator == isOperator &&
     other.isEngineer == isEngineer &&
     other.password == password;

  @override
  int get hashCode =>
    (login == null ? 0 : login.hashCode) +
    (firstName == null ? 0 : firstName.hashCode) +
    (middleName == null ? 0 : middleName.hashCode) +
    (lastName == null ? 0 : lastName.hashCode) +
    (isAdmin == null ? 0 : isAdmin.hashCode) +
    (isOperator == null ? 0 : isOperator.hashCode) +
    (isEngineer == null ? 0 : isEngineer.hashCode) +
    (password == null ? 0 : password.hashCode);

  @override
  String toString() => 'ArgUserCreate[login=$login, firstName=$firstName, middleName=$middleName, lastName=$lastName, isAdmin=$isAdmin, isOperator=$isOperator, isEngineer=$isEngineer, password=$password]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'login'] = login;
    if (firstName != null) {
      json[r'firstName'] = firstName;
    }
    if (middleName != null) {
      json[r'middleName'] = middleName;
    }
    if (lastName != null) {
      json[r'lastName'] = lastName;
    }
    if (isAdmin != null) {
      json[r'isAdmin'] = isAdmin;
    }
    if (isOperator != null) {
      json[r'isOperator'] = isOperator;
    }
    if (isEngineer != null) {
      json[r'isEngineer'] = isEngineer;
    }
      json[r'password'] = password;
    return json;
  }

  /// Returns a new [ArgUserCreate] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgUserCreate fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ArgUserCreate(
        login: json[r'login'],
        firstName: json[r'firstName'],
        middleName: json[r'middleName'],
        lastName: json[r'lastName'],
        isAdmin: json[r'isAdmin'],
        isOperator: json[r'isOperator'],
        isEngineer: json[r'isEngineer'],
        password: json[r'password'],
    );

  static List<ArgUserCreate> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ArgUserCreate>[]
      : json.map((dynamic value) => ArgUserCreate.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgUserCreate> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgUserCreate>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgUserCreate.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgUserCreate-objects as value to a dart map
  static Map<String, List<ArgUserCreate>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ArgUserCreate>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgUserCreate.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

