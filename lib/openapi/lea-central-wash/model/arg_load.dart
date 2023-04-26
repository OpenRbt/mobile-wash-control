//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgLoad {
  /// Returns a new [ArgLoad] instance.
  ArgLoad({
    required this.hash,
    required this.key,
  });

  String hash;

  String key;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgLoad &&
     other.hash == hash &&
     other.key == key;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (hash.hashCode) +
    (key.hashCode);

  @override
  String toString() => 'ArgLoad[hash=$hash, key=$key]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'hash'] = this.hash;
      json[r'key'] = this.key;
    return json;
  }

  /// Returns a new [ArgLoad] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ArgLoad? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ArgLoad[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ArgLoad[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ArgLoad(
        hash: mapValueOfType<String>(json, r'hash')!,
        key: mapValueOfType<String>(json, r'key')!,
      );
    }
    return null;
  }

  static List<ArgLoad>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ArgLoad>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ArgLoad.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ArgLoad> mapFromJson(dynamic json) {
    final map = <String, ArgLoad>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgLoad.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ArgLoad-objects as value to a dart map
  static Map<String, List<ArgLoad>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ArgLoad>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgLoad.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'hash',
    'key',
  };
}

