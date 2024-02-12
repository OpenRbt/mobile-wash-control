//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ServerGroupCreation {
  /// Returns a new [ServerGroupCreation] instance.
  ServerGroupCreation({
    required this.organizationId,
    required this.name,
    required this.description,
    this.utcOffset,
    this.reportsProcessingDelayMinutes,
    this.bonusPercentage,
  });

  String organizationId;

  String name;

  String description;

  /// Minimum value: -720
  /// Maximum value: 840
  int? utcOffset;

  /// Minimum value: 0
  int? reportsProcessingDelayMinutes;

  /// Minimum value: 0
  /// Maximum value: 100
  int? bonusPercentage;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ServerGroupCreation &&
     other.organizationId == organizationId &&
     other.name == name &&
     other.description == description &&
     other.utcOffset == utcOffset &&
     other.reportsProcessingDelayMinutes == reportsProcessingDelayMinutes &&
     other.bonusPercentage == bonusPercentage;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (organizationId.hashCode) +
    (name.hashCode) +
    (description.hashCode) +
    (utcOffset == null ? 0 : utcOffset!.hashCode) +
    (reportsProcessingDelayMinutes == null ? 0 : reportsProcessingDelayMinutes!.hashCode) +
    (bonusPercentage == null ? 0 : bonusPercentage!.hashCode);

  @override
  String toString() => 'ServerGroupCreation[organizationId=$organizationId, name=$name, description=$description, utcOffset=$utcOffset, reportsProcessingDelayMinutes=$reportsProcessingDelayMinutes, bonusPercentage=$bonusPercentage]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'organizationId'] = this.organizationId;
      json[r'name'] = this.name;
      json[r'description'] = this.description;
    if (this.utcOffset != null) {
      json[r'utcOffset'] = this.utcOffset;
    } else {
      json[r'utcOffset'] = null;
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

  /// Returns a new [ServerGroupCreation] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ServerGroupCreation? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ServerGroupCreation[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ServerGroupCreation[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ServerGroupCreation(
        organizationId: mapValueOfType<String>(json, r'organizationId')!,
        name: mapValueOfType<String>(json, r'name')!,
        description: mapValueOfType<String>(json, r'description')!,
        utcOffset: mapValueOfType<int>(json, r'utcOffset'),
        reportsProcessingDelayMinutes: mapValueOfType<int>(json, r'reportsProcessingDelayMinutes'),
        bonusPercentage: mapValueOfType<int>(json, r'bonusPercentage'),
      );
    }
    return null;
  }

  static List<ServerGroupCreation>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ServerGroupCreation>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ServerGroupCreation.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ServerGroupCreation> mapFromJson(dynamic json) {
    final map = <String, ServerGroupCreation>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ServerGroupCreation.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ServerGroupCreation-objects as value to a dart map
  static Map<String, List<ServerGroupCreation>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ServerGroupCreation>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ServerGroupCreation.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'organizationId',
    'name',
    'description',
  };
}

