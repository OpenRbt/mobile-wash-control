//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgGetLevel {
  /// Returns a new [ArgGetLevel] instance.
  ArgGetLevel({
    required this.hash,
  });

  String hash;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgGetLevel &&
     other.hash == hash;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (hash.hashCode);

  @override
  String toString() => 'ArgGetLevel[hash=$hash]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'hash'] = this.hash;
    return json;
  }

  /// Returns a new [ArgGetLevel] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ArgGetLevel? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ArgGetLevel[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ArgGetLevel[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ArgGetLevel(
        hash: mapValueOfType<String>(json, r'hash')!,
      );
    }
    return null;
  }

  static List<ArgGetLevel>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ArgGetLevel>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ArgGetLevel.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ArgGetLevel> mapFromJson(dynamic json) {
    final map = <String, ArgGetLevel>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgGetLevel.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ArgGetLevel-objects as value to a dart map
  static Map<String, List<ArgGetLevel>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ArgGetLevel>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgGetLevel.listFromJson(entry.value, growable: growable,);
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
  };
}

