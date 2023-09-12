//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CreateAdminApplicationRequest {
  /// Returns a new [CreateAdminApplicationRequest] instance.
  CreateAdminApplicationRequest({
    this.application,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AdminApplicationCreation? application;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CreateAdminApplicationRequest &&
     other.application == application;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (application == null ? 0 : application!.hashCode);

  @override
  String toString() => 'CreateAdminApplicationRequest[application=$application]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.application != null) {
      json[r'application'] = this.application;
    } else {
      json[r'application'] = null;
    }
    return json;
  }

  /// Returns a new [CreateAdminApplicationRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CreateAdminApplicationRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CreateAdminApplicationRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CreateAdminApplicationRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CreateAdminApplicationRequest(
        application: AdminApplicationCreation.fromJson(json[r'application']),
      );
    }
    return null;
  }

  static List<CreateAdminApplicationRequest>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CreateAdminApplicationRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CreateAdminApplicationRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CreateAdminApplicationRequest> mapFromJson(dynamic json) {
    final map = <String, CreateAdminApplicationRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CreateAdminApplicationRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CreateAdminApplicationRequest-objects as value to a dart map
  static Map<String, List<CreateAdminApplicationRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CreateAdminApplicationRequest>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CreateAdminApplicationRequest.listFromJson(entry.value, growable: growable,);
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

