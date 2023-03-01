//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgSaveIfNotExists {
  /// Returns a new [ArgSaveIfNotExists] instance.
  ArgSaveIfNotExists({
    required this.hash,
    required this.keyPair,
  });

  String hash;

  KeyPair keyPair;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgSaveIfNotExists &&
     other.hash == hash &&
     other.keyPair == keyPair;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (hash.hashCode) +
    (keyPair.hashCode);

  @override
  String toString() => 'ArgSaveIfNotExists[hash=$hash, keyPair=$keyPair]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'hash'] = this.hash;
      json[r'keyPair'] = this.keyPair;
    return json;
  }

  /// Returns a new [ArgSaveIfNotExists] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ArgSaveIfNotExists? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ArgSaveIfNotExists[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ArgSaveIfNotExists[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ArgSaveIfNotExists(
        hash: mapValueOfType<String>(json, r'hash')!,
        keyPair: KeyPair.fromJson(json[r'keyPair'])!,
      );
    }
    return null;
  }

  static List<ArgSaveIfNotExists>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ArgSaveIfNotExists>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ArgSaveIfNotExists.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ArgSaveIfNotExists> mapFromJson(dynamic json) {
    final map = <String, ArgSaveIfNotExists>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgSaveIfNotExists.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ArgSaveIfNotExists-objects as value to a dart map
  static Map<String, List<ArgSaveIfNotExists>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ArgSaveIfNotExists>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgSaveIfNotExists.listFromJson(entry.value, growable: growable,);
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
    'keyPair',
  };
}

