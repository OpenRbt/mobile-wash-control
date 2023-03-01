//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RelayConfig {
  /// Returns a new [RelayConfig] instance.
  RelayConfig({
    this.id,
    this.timeon,
    this.timeoff,
  });

  /// Minimum value: 1
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? id;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? timeon;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? timeoff;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RelayConfig &&
     other.id == id &&
     other.timeon == timeon &&
     other.timeoff == timeoff;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (timeon == null ? 0 : timeon!.hashCode) +
    (timeoff == null ? 0 : timeoff!.hashCode);

  @override
  String toString() => 'RelayConfig[id=$id, timeon=$timeon, timeoff=$timeoff]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.timeon != null) {
      json[r'timeon'] = this.timeon;
    } else {
      json[r'timeon'] = null;
    }
    if (this.timeoff != null) {
      json[r'timeoff'] = this.timeoff;
    } else {
      json[r'timeoff'] = null;
    }
    return json;
  }

  /// Returns a new [RelayConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RelayConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "RelayConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "RelayConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return RelayConfig(
        id: mapValueOfType<int>(json, r'id'),
        timeon: mapValueOfType<int>(json, r'timeon'),
        timeoff: mapValueOfType<int>(json, r'timeoff'),
      );
    }
    return null;
  }

  static List<RelayConfig>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <RelayConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RelayConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RelayConfig> mapFromJson(dynamic json) {
    final map = <String, RelayConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RelayConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RelayConfig-objects as value to a dart map
  static Map<String, List<RelayConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<RelayConfig>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RelayConfig.listFromJson(entry.value, growable: growable,);
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

