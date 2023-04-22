//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgEndSession {
  /// Returns a new [ArgEndSession] instance.
  ArgEndSession({
    required this.hash,
    required this.sessionID,
  });

  String hash;

  String sessionID;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgEndSession &&
     other.hash == hash &&
     other.sessionID == sessionID;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (hash.hashCode) +
    (sessionID.hashCode);

  @override
  String toString() => 'ArgEndSession[hash=$hash, sessionID=$sessionID]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'hash'] = this.hash;
      json[r'sessionID'] = this.sessionID;
    return json;
  }

  /// Returns a new [ArgEndSession] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ArgEndSession? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ArgEndSession[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ArgEndSession[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ArgEndSession(
        hash: mapValueOfType<String>(json, r'hash')!,
        sessionID: mapValueOfType<String>(json, r'sessionID')!,
      );
    }
    return null;
  }

  static List<ArgEndSession>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ArgEndSession>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ArgEndSession.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ArgEndSession> mapFromJson(dynamic json) {
    final map = <String, ArgEndSession>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgEndSession.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ArgEndSession-objects as value to a dart map
  static Map<String, List<ArgEndSession>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ArgEndSession>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgEndSession.listFromJson(entry.value, growable: growable,);
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
    'sessionID',
  };
}

