//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgUserUpdate {
  /// Returns a new [ArgUserUpdate] instance.
  ArgUserUpdate({
    @required this.login,
    this.firstName,
    this.middleName,
    this.lastName,
    this.isAdmin,
    this.isOperator,
    this.isEngineer,
  });

  String login;

  String firstName;

  String middleName;

  String lastName;

  bool isAdmin;

  bool isOperator;

  bool isEngineer;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgUserUpdate &&
     other.login == login &&
     other.firstName == firstName &&
     other.middleName == middleName &&
     other.lastName == lastName &&
     other.isAdmin == isAdmin &&
     other.isOperator == isOperator &&
     other.isEngineer == isEngineer;

  @override
  int get hashCode =>
    (login == null ? 0 : login.hashCode) +
    (firstName == null ? 0 : firstName.hashCode) +
    (middleName == null ? 0 : middleName.hashCode) +
    (lastName == null ? 0 : lastName.hashCode) +
    (isAdmin == null ? 0 : isAdmin.hashCode) +
    (isOperator == null ? 0 : isOperator.hashCode) +
    (isEngineer == null ? 0 : isEngineer.hashCode);

  @override
  String toString() => 'ArgUserUpdate[login=$login, firstName=$firstName, middleName=$middleName, lastName=$lastName, isAdmin=$isAdmin, isOperator=$isOperator, isEngineer=$isEngineer]';

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
    return json;
  }

  /// Returns a new [ArgUserUpdate] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgUserUpdate fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ArgUserUpdate(
        login: json[r'login'],
        firstName: json[r'firstName'],
        middleName: json[r'middleName'],
        lastName: json[r'lastName'],
        isAdmin: json[r'isAdmin'],
        isOperator: json[r'isOperator'],
        isEngineer: json[r'isEngineer'],
    );

  static List<ArgUserUpdate> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ArgUserUpdate>[]
      : json.map((dynamic value) => ArgUserUpdate.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgUserUpdate> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgUserUpdate>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgUserUpdate.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgUserUpdate-objects as value to a dart map
  static Map<String, List<ArgUserUpdate>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ArgUserUpdate>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgUserUpdate.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

