//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class WashServerCreation {
  /// Returns a new [WashServerCreation] instance.
  WashServerCreation({
    required this.title,
    required this.description,
    required this.groupId,
  });

  String title;

  String description;

  String groupId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is WashServerCreation &&
     other.title == title &&
     other.description == description &&
     other.groupId == groupId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (title.hashCode) +
    (description.hashCode) +
    (groupId.hashCode);

  @override
  String toString() => 'WashServerCreation[title=$title, description=$description, groupId=$groupId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'title'] = this.title;
      json[r'description'] = this.description;
      json[r'groupId'] = this.groupId;
    return json;
  }

  /// Returns a new [WashServerCreation] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static WashServerCreation? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "WashServerCreation[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "WashServerCreation[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return WashServerCreation(
        title: mapValueOfType<String>(json, r'title')!,
        description: mapValueOfType<String>(json, r'description')!,
        groupId: mapValueOfType<String>(json, r'groupId')!,
      );
    }
    return null;
  }

  static List<WashServerCreation>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <WashServerCreation>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WashServerCreation.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, WashServerCreation> mapFromJson(dynamic json) {
    final map = <String, WashServerCreation>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = WashServerCreation.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of WashServerCreation-objects as value to a dart map
  static Map<String, List<WashServerCreation>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<WashServerCreation>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = WashServerCreation.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'title',
    'description',
    'groupId',
  };
}

