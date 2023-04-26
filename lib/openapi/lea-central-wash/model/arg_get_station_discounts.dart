//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgGetStationDiscounts {
  /// Returns a new [ArgGetStationDiscounts] instance.
  ArgGetStationDiscounts({
    this.hash,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? hash;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgGetStationDiscounts &&
     other.hash == hash;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (hash == null ? 0 : hash!.hashCode);

  @override
  String toString() => 'ArgGetStationDiscounts[hash=$hash]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.hash != null) {
      json[r'hash'] = this.hash;
    } else {
      json[r'hash'] = null;
    }
    return json;
  }

  /// Returns a new [ArgGetStationDiscounts] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ArgGetStationDiscounts? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ArgGetStationDiscounts[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ArgGetStationDiscounts[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ArgGetStationDiscounts(
        hash: mapValueOfType<String>(json, r'hash'),
      );
    }
    return null;
  }

  static List<ArgGetStationDiscounts>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ArgGetStationDiscounts>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ArgGetStationDiscounts.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ArgGetStationDiscounts> mapFromJson(dynamic json) {
    final map = <String, ArgGetStationDiscounts>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgGetStationDiscounts.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ArgGetStationDiscounts-objects as value to a dart map
  static Map<String, List<ArgGetStationDiscounts>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ArgGetStationDiscounts>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgGetStationDiscounts.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

