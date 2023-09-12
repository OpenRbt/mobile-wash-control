//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class WashServerCreate {
  /// Returns a new [WashServerCreate] instance.
  WashServerCreate({
    required this.name,
    this.description,
    this.terminalKey,
    this.terminalPassword,
  });

  String name;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? description;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? terminalKey;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? terminalPassword;

  @override
  bool operator ==(Object other) => identical(this, other) || other is WashServerCreate &&
     other.name == name &&
     other.description == description &&
     other.terminalKey == terminalKey &&
     other.terminalPassword == terminalPassword;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (description == null ? 0 : description!.hashCode) +
    (terminalKey == null ? 0 : terminalKey!.hashCode) +
    (terminalPassword == null ? 0 : terminalPassword!.hashCode);

  @override
  String toString() => 'WashServerCreate[name=$name, description=$description, terminalKey=$terminalKey, terminalPassword=$terminalPassword]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
    if (this.terminalKey != null) {
      json[r'terminal_key'] = this.terminalKey;
    } else {
      json[r'terminal_key'] = null;
    }
    if (this.terminalPassword != null) {
      json[r'terminal_password'] = this.terminalPassword;
    } else {
      json[r'terminal_password'] = null;
    }
    return json;
  }

  /// Returns a new [WashServerCreate] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static WashServerCreate? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "WashServerCreate[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "WashServerCreate[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return WashServerCreate(
        name: mapValueOfType<String>(json, r'name')!,
        description: mapValueOfType<String>(json, r'description'),
        terminalKey: mapValueOfType<String>(json, r'terminal_key'),
        terminalPassword: mapValueOfType<String>(json, r'terminal_password'),
      );
    }
    return null;
  }

  static List<WashServerCreate>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <WashServerCreate>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WashServerCreate.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, WashServerCreate> mapFromJson(dynamic json) {
    final map = <String, WashServerCreate>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = WashServerCreate.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of WashServerCreate-objects as value to a dart map
  static Map<String, List<WashServerCreate>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<WashServerCreate>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = WashServerCreate.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
  };
}

