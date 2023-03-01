//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgRunProgram {
  /// Returns a new [ArgRunProgram] instance.
  ArgRunProgram({
    required this.hash,
    required this.programID,
    required this.preflight,
  });

  String hash;

  int programID;

  bool preflight;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgRunProgram &&
     other.hash == hash &&
     other.programID == programID &&
     other.preflight == preflight;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (hash.hashCode) +
    (programID.hashCode) +
    (preflight.hashCode);

  @override
  String toString() => 'ArgRunProgram[hash=$hash, programID=$programID, preflight=$preflight]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'hash'] = this.hash;
      json[r'programID'] = this.programID;
      json[r'preflight'] = this.preflight;
    return json;
  }

  /// Returns a new [ArgRunProgram] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ArgRunProgram? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ArgRunProgram[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ArgRunProgram[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ArgRunProgram(
        hash: mapValueOfType<String>(json, r'hash')!,
        programID: mapValueOfType<int>(json, r'programID')!,
        preflight: mapValueOfType<bool>(json, r'preflight')!,
      );
    }
    return null;
  }

  static List<ArgRunProgram>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ArgRunProgram>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ArgRunProgram.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ArgRunProgram> mapFromJson(dynamic json) {
    final map = <String, ArgRunProgram>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgRunProgram.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ArgRunProgram-objects as value to a dart map
  static Map<String, List<ArgRunProgram>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ArgRunProgram>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgRunProgram.listFromJson(entry.value, growable: growable,);
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
    'programID',
    'preflight',
  };
}

