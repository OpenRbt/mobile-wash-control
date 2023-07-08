//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgUserUpdate {
  /// Returns a new [ArgUserUpdate] instance.
  ArgUserUpdate({
    required this.login,
    this.firstName,
    this.middleName,
    this.lastName,
    this.isAdmin,
    this.isOperator,
    this.isEngineer,
  });

  String login;

  String? firstName;

  String? middleName;

  String? lastName;

  bool? isAdmin;

  bool? isOperator;

  bool? isEngineer;

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
    // ignore: unnecessary_parenthesis
    (login.hashCode) +
    (firstName == null ? 0 : firstName!.hashCode) +
    (middleName == null ? 0 : middleName!.hashCode) +
    (lastName == null ? 0 : lastName!.hashCode) +
    (isAdmin == null ? 0 : isAdmin!.hashCode) +
    (isOperator == null ? 0 : isOperator!.hashCode) +
    (isEngineer == null ? 0 : isEngineer!.hashCode);

  @override
  String toString() => 'ArgUserUpdate[login=$login, firstName=$firstName, middleName=$middleName, lastName=$lastName, isAdmin=$isAdmin, isOperator=$isOperator, isEngineer=$isEngineer]';

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
    return json;
  }

  /// Returns a new [ArgUserUpdate] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ArgUserUpdate? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ArgUserUpdate[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ArgUserUpdate[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ArgUserUpdate(
        login: mapValueOfType<String>(json, r'login')!,
        firstName: mapValueOfType<String>(json, r'firstName'),
        middleName: mapValueOfType<String>(json, r'middleName'),
        lastName: mapValueOfType<String>(json, r'lastName'),
        isAdmin: mapValueOfType<bool>(json, r'isAdmin'),
        isOperator: mapValueOfType<bool>(json, r'isOperator'),
        isEngineer: mapValueOfType<bool>(json, r'isEngineer'),
      );
    }
    return null;
  }

  static List<ArgUserUpdate>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ArgUserUpdate>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ArgUserUpdate.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ArgUserUpdate> mapFromJson(dynamic json) {
    final map = <String, ArgUserUpdate>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgUserUpdate.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ArgUserUpdate-objects as value to a dart map
  static Map<String, List<ArgUserUpdate>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ArgUserUpdate>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgUserUpdate.listFromJson(entry.value, growable: growable,);
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
  };
}

