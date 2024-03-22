//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class WashCreation {
  /// Returns a new [WashCreation] instance.
  WashCreation({
    required this.name,
    required this.description,
    required this.terminalKey,
    required this.terminalPassword,
    required this.groupId,
  });

  String name;

  String description;

  String terminalKey;

  String terminalPassword;

  String groupId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is WashCreation &&
     other.name == name &&
     other.description == description &&
     other.terminalKey == terminalKey &&
     other.terminalPassword == terminalPassword &&
     other.groupId == groupId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (description.hashCode) +
    (terminalKey.hashCode) +
    (terminalPassword.hashCode) +
    (groupId.hashCode);

  @override
  String toString() => 'WashCreation[name=$name, description=$description, terminalKey=$terminalKey, terminalPassword=$terminalPassword, groupId=$groupId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
      json[r'description'] = this.description;
      json[r'terminalKey'] = this.terminalKey;
      json[r'terminalPassword'] = this.terminalPassword;
      json[r'groupId'] = this.groupId;
    return json;
  }

  /// Returns a new [WashCreation] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static WashCreation? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "WashCreation[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "WashCreation[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return WashCreation(
        name: mapValueOfType<String>(json, r'name')!,
        description: mapValueOfType<String>(json, r'description')!,
        terminalKey: mapValueOfType<String>(json, r'terminalKey')!,
        terminalPassword: mapValueOfType<String>(json, r'terminalPassword')!,
        groupId: mapValueOfType<String>(json, r'groupId')!,
      );
    }
    return null;
  }

  static List<WashCreation>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <WashCreation>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WashCreation.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, WashCreation> mapFromJson(dynamic json) {
    final map = <String, WashCreation>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = WashCreation.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of WashCreation-objects as value to a dart map
  static Map<String, List<WashCreation>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<WashCreation>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = WashCreation.listFromJson(entry.value, growable: growable,);
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
    'description',
    'terminalKey',
    'terminalPassword',
    'groupId',
  };
}

