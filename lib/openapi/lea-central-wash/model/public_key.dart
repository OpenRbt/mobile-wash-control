//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PublicKey {
  /// Returns a new [PublicKey] instance.
  PublicKey({
    required this.publicKey,
  });

  String publicKey;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PublicKey &&
     other.publicKey == publicKey;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (publicKey.hashCode);

  @override
  String toString() => 'PublicKey[publicKey=$publicKey]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'publicKey'] = this.publicKey;
    return json;
  }

  /// Returns a new [PublicKey] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PublicKey? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PublicKey[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PublicKey[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PublicKey(
        publicKey: mapValueOfType<String>(json, r'publicKey')!,
      );
    }
    return null;
  }

  static List<PublicKey>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PublicKey>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PublicKey.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PublicKey> mapFromJson(dynamic json) {
    final map = <String, PublicKey>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PublicKey.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PublicKey-objects as value to a dart map
  static Map<String, List<PublicKey>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PublicKey>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PublicKey.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'publicKey',
  };
}

