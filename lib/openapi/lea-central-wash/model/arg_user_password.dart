//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgUserPassword {
  /// Returns a new [ArgUserPassword] instance.
  ArgUserPassword({
    required this.login,
    required this.oldPassword,
    required this.newPassword,
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
    // ignore: unnecessary_parenthesis
    (login.hashCode) +
    (oldPassword.hashCode) +
    (newPassword.hashCode);

  @override
  String toString() => 'ArgUserPassword[login=$login, oldPassword=$oldPassword, newPassword=$newPassword]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'login'] = this.login;
      json[r'oldPassword'] = this.oldPassword;
      json[r'newPassword'] = this.newPassword;
    return json;
  }

  /// Returns a new [ArgUserPassword] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ArgUserPassword? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ArgUserPassword[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ArgUserPassword[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ArgUserPassword(
        login: mapValueOfType<String>(json, r'login')!,
        oldPassword: mapValueOfType<String>(json, r'oldPassword')!,
        newPassword: mapValueOfType<String>(json, r'newPassword')!,
      );
    }
    return null;
  }

  static List<ArgUserPassword>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ArgUserPassword>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ArgUserPassword.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ArgUserPassword> mapFromJson(dynamic json) {
    final map = <String, ArgUserPassword>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgUserPassword.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ArgUserPassword-objects as value to a dart map
  static Map<String, List<ArgUserPassword>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ArgUserPassword>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgUserPassword.listFromJson(entry.value, growable: growable,);
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
    'oldPassword',
    'newPassword',
  };
}

