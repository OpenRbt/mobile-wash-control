//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgStationByHash {
  /// Returns a new [ArgStationByHash] instance.
  ArgStationByHash({
    required this.hash,
  });

  String hash;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgStationByHash &&
     other.hash == hash;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (hash.hashCode);

  @override
  String toString() => 'ArgStationByHash[hash=$hash]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'hash'] = this.hash;
    return json;
  }

  /// Returns a new [ArgStationByHash] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ArgStationByHash? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ArgStationByHash[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ArgStationByHash[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ArgStationByHash(
        hash: mapValueOfType<String>(json, r'hash')!,
      );
    }
    return null;
  }

  static List<ArgStationByHash>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ArgStationByHash>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ArgStationByHash.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ArgStationByHash> mapFromJson(dynamic json) {
    final map = <String, ArgStationByHash>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgStationByHash.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ArgStationByHash-objects as value to a dart map
  static Map<String, List<ArgStationByHash>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ArgStationByHash>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgStationByHash.listFromJson(entry.value, growable: growable,);
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

