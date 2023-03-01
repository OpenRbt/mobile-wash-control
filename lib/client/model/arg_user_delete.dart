//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgUserDelete {
  /// Returns a new [ArgUserDelete] instance.
  ArgUserDelete({
    required this.login,
  });

  String login;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgUserDelete &&
     other.login == login;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (login.hashCode);

  @override
  String toString() => 'ArgUserDelete[login=$login]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'login'] = this.login;
    return json;
  }

  /// Returns a new [ArgUserDelete] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ArgUserDelete? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ArgUserDelete[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ArgUserDelete[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ArgUserDelete(
        login: mapValueOfType<String>(json, r'login')!,
      );
    }
    return null;
  }

  static List<ArgUserDelete>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ArgUserDelete>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ArgUserDelete.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ArgUserDelete> mapFromJson(dynamic json) {
    final map = <String, ArgUserDelete>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgUserDelete.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ArgUserDelete-objects as value to a dart map
  static Map<String, List<ArgUserDelete>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ArgUserDelete>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgUserDelete.listFromJson(entry.value, growable: growable,);
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

