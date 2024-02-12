//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgRun2Program {
  /// Returns a new [ArgRun2Program] instance.
  ArgRun2Program({
    required this.hash,
    required this.programID,
    required this.programID2,
    required this.preflight,
  });

  String hash;

  int programID;

  int programID2;

  bool preflight;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgRun2Program &&
     other.hash == hash &&
     other.programID == programID &&
     other.programID2 == programID2 &&
     other.preflight == preflight;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (hash.hashCode) +
    (programID.hashCode) +
    (programID2.hashCode) +
    (preflight.hashCode);

  @override
  String toString() => 'ArgRun2Program[hash=$hash, programID=$programID, programID2=$programID2, preflight=$preflight]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'hash'] = this.hash;
      json[r'programID'] = this.programID;
      json[r'programID2'] = this.programID2;
      json[r'preflight'] = this.preflight;
    return json;
  }

  /// Returns a new [ArgRun2Program] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ArgRun2Program? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ArgRun2Program[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ArgRun2Program[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ArgRun2Program(
        hash: mapValueOfType<String>(json, r'hash')!,
        programID: mapValueOfType<int>(json, r'programID')!,
        programID2: mapValueOfType<int>(json, r'programID2')!,
        preflight: mapValueOfType<bool>(json, r'preflight')!,
      );
    }
    return null;
  }

  static List<ArgRun2Program>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ArgRun2Program>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ArgRun2Program.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ArgRun2Program> mapFromJson(dynamic json) {
    final map = <String, ArgRun2Program>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgRun2Program.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ArgRun2Program-objects as value to a dart map
  static Map<String, List<ArgRun2Program>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ArgRun2Program>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgRun2Program.listFromJson(entry.value, growable: growable,);
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
    'programID2',
    'preflight',
  };
}

