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
    required this.name,
    required this.description,
    required this.organizationId,
  });

  String name;

  String description;

  String organizationId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ServerGroupCreation &&
     other.name == name &&
     other.description == description &&
     other.organizationId == organizationId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (description.hashCode) +
    (organizationId.hashCode);

  @override
  String toString() => 'ServerGroupCreation[name=$name, description=$description, organizationId=$organizationId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
      json[r'description'] = this.description;
      json[r'organizationId'] = this.organizationId;
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
        name: mapValueOfType<String>(json, r'name')!,
        description: mapValueOfType<String>(json, r'description')!,
        organizationId: mapValueOfType<String>(json, r'organizationId')!,
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
    'name',
    'description',
    'organizationId',
  };
}

