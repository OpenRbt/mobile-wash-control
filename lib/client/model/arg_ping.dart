//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgPing {
  /// Returns a new [ArgPing] instance.
  ArgPing({
    required this.hash,
    this.currentBalance,
    this.currentProgram,
  });

  String hash;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? currentBalance;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? currentProgram;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgPing &&
     other.hash == hash &&
     other.currentBalance == currentBalance &&
     other.currentProgram == currentProgram;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (hash.hashCode) +
    (currentBalance == null ? 0 : currentBalance!.hashCode) +
    (currentProgram == null ? 0 : currentProgram!.hashCode);

  @override
  String toString() => 'ArgPing[hash=$hash, currentBalance=$currentBalance, currentProgram=$currentProgram]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'hash'] = this.hash;
    if (this.currentBalance != null) {
      json[r'currentBalance'] = this.currentBalance;
    } else {
      json[r'currentBalance'] = null;
    }
    if (this.currentProgram != null) {
      json[r'currentProgram'] = this.currentProgram;
    } else {
      json[r'currentProgram'] = null;
    }
    return json;
  }

  /// Returns a new [ArgPing] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ArgPing? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ArgPing[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ArgPing[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ArgPing(
        hash: mapValueOfType<String>(json, r'hash')!,
        currentBalance: mapValueOfType<int>(json, r'currentBalance'),
        currentProgram: mapValueOfType<int>(json, r'currentProgram'),
      );
    }
    return null;
  }

  static List<ArgPing>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ArgPing>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ArgPing.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ArgPing> mapFromJson(dynamic json) {
    final map = <String, ArgPing>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgPing.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ArgPing-objects as value to a dart map
  static Map<String, List<ArgPing>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ArgPing>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgPing.listFromJson(entry.value, growable: growable,);
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

