//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Organization {
  /// Returns a new [Organization] instance.
  Organization({
    this.id,
    this.name,
    this.description,
    this.utcOffset,
    this.displayName,
    this.isDefault,
    this.reportsProcessingDelayMinutes,
    this.bonusPercentage,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? id;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? description;

  /// Minimum value: -720
  /// Maximum value: 840
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? utcOffset;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? displayName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? isDefault;

  /// Minimum value: 0
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? reportsProcessingDelayMinutes;

  /// Minimum value: 0
  /// Maximum value: 100
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? bonusPercentage;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Organization &&
     other.id == id &&
     other.name == name &&
     other.description == description &&
     other.utcOffset == utcOffset &&
     other.displayName == displayName &&
     other.isDefault == isDefault &&
     other.reportsProcessingDelayMinutes == reportsProcessingDelayMinutes &&
     other.bonusPercentage == bonusPercentage;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (description == null ? 0 : description!.hashCode) +
    (utcOffset == null ? 0 : utcOffset!.hashCode) +
    (displayName == null ? 0 : displayName!.hashCode) +
    (isDefault == null ? 0 : isDefault!.hashCode) +
    (reportsProcessingDelayMinutes == null ? 0 : reportsProcessingDelayMinutes!.hashCode) +
    (bonusPercentage == null ? 0 : bonusPercentage!.hashCode);

  @override
  String toString() => 'Organization[id=$id, name=$name, description=$description, utcOffset=$utcOffset, displayName=$displayName, isDefault=$isDefault, reportsProcessingDelayMinutes=$reportsProcessingDelayMinutes, bonusPercentage=$bonusPercentage]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
    if (this.utcOffset != null) {
      json[r'utcOffset'] = this.utcOffset;
    } else {
      json[r'utcOffset'] = null;
    }
    if (this.displayName != null) {
      json[r'displayName'] = this.displayName;
    } else {
      json[r'displayName'] = null;
    }
    if (this.isDefault != null) {
      json[r'isDefault'] = this.isDefault;
    } else {
      json[r'isDefault'] = null;
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

  /// Returns a new [Organization] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Organization? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Organization[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Organization[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Organization(
        id: mapValueOfType<String>(json, r'id'),
        name: mapValueOfType<String>(json, r'name'),
        description: mapValueOfType<String>(json, r'description'),
        utcOffset: mapValueOfType<int>(json, r'utcOffset'),
        displayName: mapValueOfType<String>(json, r'displayName'),
        isDefault: mapValueOfType<bool>(json, r'isDefault'),
        reportsProcessingDelayMinutes: mapValueOfType<int>(json, r'reportsProcessingDelayMinutes'),
        bonusPercentage: mapValueOfType<int>(json, r'bonusPercentage'),
      );
    }
    return null;
  }

  static List<Organization>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Organization>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Organization.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Organization> mapFromJson(dynamic json) {
    final map = <String, Organization>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Organization.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Organization-objects as value to a dart map
  static Map<String, List<Organization>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Organization>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Organization.listFromJson(entry.value, growable: growable,);
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

