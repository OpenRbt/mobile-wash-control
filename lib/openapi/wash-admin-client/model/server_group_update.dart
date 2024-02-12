//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ServerGroupUpdate {
  /// Returns a new [ServerGroupUpdate] instance.
  ServerGroupUpdate({
    this.name,
    this.description,
    this.utcOffset,
    this.reportsProcessingDelayMinutes,
    this.bonusPercentage,
  });

  String? name;

  String? description;

  /// Minimum value: -720
  /// Maximum value: 840
  int? utcOffset;

  /// Minimum value: 0
  int? reportsProcessingDelayMinutes;

  /// Minimum value: 0
  /// Maximum value: 100
  int? bonusPercentage;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ServerGroupUpdate &&
     other.name == name &&
     other.description == description &&
     other.utcOffset == utcOffset &&
     other.reportsProcessingDelayMinutes == reportsProcessingDelayMinutes &&
     other.bonusPercentage == bonusPercentage;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name == null ? 0 : name!.hashCode) +
    (description == null ? 0 : description!.hashCode) +
    (utcOffset == null ? 0 : utcOffset!.hashCode) +
    (reportsProcessingDelayMinutes == null ? 0 : reportsProcessingDelayMinutes!.hashCode) +
    (bonusPercentage == null ? 0 : bonusPercentage!.hashCode);

  @override
  String toString() => 'ServerGroupUpdate[name=$name, description=$description, utcOffset=$utcOffset, reportsProcessingDelayMinutes=$reportsProcessingDelayMinutes, bonusPercentage=$bonusPercentage]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
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

  /// Returns a new [ServerGroupUpdate] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ServerGroupUpdate? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ServerGroupUpdate[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ServerGroupUpdate[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ServerGroupUpdate(
        name: mapValueOfType<String>(json, r'name'),
        description: mapValueOfType<String>(json, r'description'),
        utcOffset: mapValueOfType<int>(json, r'utcOffset'),
        reportsProcessingDelayMinutes: mapValueOfType<int>(json, r'reportsProcessingDelayMinutes'),
        bonusPercentage: mapValueOfType<int>(json, r'bonusPercentage'),
      );
    }
    return null;
  }

  static List<ServerGroupUpdate>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ServerGroupUpdate>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ServerGroupUpdate.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ServerGroupUpdate> mapFromJson(dynamic json) {
    final map = <String, ServerGroupUpdate>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ServerGroupUpdate.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ServerGroupUpdate-objects as value to a dart map
  static Map<String, List<ServerGroupUpdate>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ServerGroupUpdate>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ServerGroupUpdate.listFromJson(entry.value, growable: growable,);
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

