//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class OrganizationCreation {
  /// Returns a new [OrganizationCreation] instance.
  OrganizationCreation({
    required this.name,
    required this.description,
    this.displayName,
    this.reportsProcessingDelayMinutes,
    this.bonusPercentage,
  });

  String name;

  String description;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? displayName;

  /// Minimum value: 0
  int? reportsProcessingDelayMinutes;

  /// Minimum value: 0
  /// Maximum value: 100
  int? bonusPercentage;

  @override
  bool operator ==(Object other) => identical(this, other) || other is OrganizationCreation &&
     other.name == name &&
     other.description == description &&
     other.displayName == displayName &&
     other.reportsProcessingDelayMinutes == reportsProcessingDelayMinutes &&
     other.bonusPercentage == bonusPercentage;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (description.hashCode) +
    (displayName == null ? 0 : displayName!.hashCode) +
    (reportsProcessingDelayMinutes == null ? 0 : reportsProcessingDelayMinutes!.hashCode) +
    (bonusPercentage == null ? 0 : bonusPercentage!.hashCode);

  @override
  String toString() => 'OrganizationCreation[name=$name, description=$description, displayName=$displayName, reportsProcessingDelayMinutes=$reportsProcessingDelayMinutes, bonusPercentage=$bonusPercentage]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
      json[r'description'] = this.description;
    if (this.displayName != null) {
      json[r'displayName'] = this.displayName;
    } else {
      json[r'displayName'] = null;
    }
    if (this.reportsProcessingDelayMinutes != null) {
      json[r'reportsProcessingDelayMinutes'] = this.reportsProcessingDelayMinutes;
    } else {
      json[r'reportsProcessingDelayMinutes'] = null;
    }
    if (this.bonusPercentage != null) {
      json[r'bonusPercentage'] = this.bonusPercentage;
    } else {
      json[r'bonusPercentage'] = null;
    }
    return json;
  }

  /// Returns a new [OrganizationCreation] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static OrganizationCreation? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "OrganizationCreation[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "OrganizationCreation[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return OrganizationCreation(
        name: mapValueOfType<String>(json, r'name')!,
        description: mapValueOfType<String>(json, r'description')!,
        displayName: mapValueOfType<String>(json, r'displayName'),
        reportsProcessingDelayMinutes: mapValueOfType<int>(json, r'reportsProcessingDelayMinutes'),
        bonusPercentage: mapValueOfType<int>(json, r'bonusPercentage'),
      );
    }
    return null;
  }

  static List<OrganizationCreation>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <OrganizationCreation>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = OrganizationCreation.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, OrganizationCreation> mapFromJson(dynamic json) {
    final map = <String, OrganizationCreation>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = OrganizationCreation.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of OrganizationCreation-objects as value to a dart map
  static Map<String, List<OrganizationCreation>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<OrganizationCreation>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = OrganizationCreation.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
    'description',
  };
}

