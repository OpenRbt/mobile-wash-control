//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgUserCreate {
  /// Returns a new [ArgUserCreate] instance.
  ArgUserCreate({
    required this.login,
    this.firstName,
    this.middleName,
    this.lastName,
    this.isAdmin,
    this.isOperator,
    this.isEngineer,
    required this.password,
  });

  String login;

  String? firstName;

  String? middleName;

  String? lastName;

  bool? isAdmin;

  bool? isOperator;

  bool? isEngineer;

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
    // ignore: unnecessary_parenthesis
    (login.hashCode) +
    (firstName == null ? 0 : firstName!.hashCode) +
    (middleName == null ? 0 : middleName!.hashCode) +
    (lastName == null ? 0 : lastName!.hashCode) +
    (isAdmin == null ? 0 : isAdmin!.hashCode) +
    (isOperator == null ? 0 : isOperator!.hashCode) +
    (isEngineer == null ? 0 : isEngineer!.hashCode) +
    (password.hashCode);

  @override
  String toString() => 'ArgUserCreate[login=$login, firstName=$firstName, middleName=$middleName, lastName=$lastName, isAdmin=$isAdmin, isOperator=$isOperator, isEngineer=$isEngineer, password=$password]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'login'] = this.login;
    if (this.firstName != null) {
      json[r'firstName'] = this.firstName;
    } else {
      json[r'firstName'] = null;
    }
    if (this.middleName != null) {
      json[r'middleName'] = this.middleName;
    } else {
      json[r'middleName'] = null;
    }
    if (this.lastName != null) {
      json[r'lastName'] = this.lastName;
    } else {
      json[r'lastName'] = null;
    }
    if (this.isAdmin != null) {
      json[r'isAdmin'] = this.isAdmin;
    } else {
      json[r'isAdmin'] = null;
    }
    if (this.isOperator != null) {
      json[r'isOperator'] = this.isOperator;
    } else {
      json[r'isOperator'] = null;
    }
    if (this.isEngineer != null) {
      json[r'isEngineer'] = this.isEngineer;
    } else {
      json[r'isEngineer'] = null;
    }
      json[r'password'] = this.password;
    return json;
  }

  /// Returns a new [ArgUserCreate] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ArgUserCreate? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ArgUserCreate[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ArgUserCreate[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ArgUserCreate(
        login: mapValueOfType<String>(json, r'login')!,
        firstName: mapValueOfType<String>(json, r'firstName'),
        middleName: mapValueOfType<String>(json, r'middleName'),
        lastName: mapValueOfType<String>(json, r'lastName'),
        isAdmin: mapValueOfType<bool>(json, r'isAdmin'),
        isOperator: mapValueOfType<bool>(json, r'isOperator'),
        isEngineer: mapValueOfType<bool>(json, r'isEngineer'),
        password: mapValueOfType<String>(json, r'password')!,
      );
    }
    return null;
  }

  static List<ArgUserCreate>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ArgUserCreate>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ArgUserCreate.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ArgUserCreate> mapFromJson(dynamic json) {
    final map = <String, ArgUserCreate>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgUserCreate.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ArgUserCreate-objects as value to a dart map
  static Map<String, List<ArgUserCreate>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ArgUserCreate>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgUserCreate.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'login',
    'password',
  };
}

