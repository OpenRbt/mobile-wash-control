//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdminApplicationCreation {
  /// Returns a new [AdminApplicationCreation] instance.
  AdminApplicationCreation({
    required this.user,
  });

  FirebaseUser user;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminApplicationCreation &&
     other.user == user;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (user.hashCode);

  @override
  String toString() => 'AdminApplicationCreation[user=$user]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'user'] = this.user;
    return json;
  }

  /// Returns a new [AdminApplicationCreation] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AdminApplicationCreation? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AdminApplicationCreation[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AdminApplicationCreation[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AdminApplicationCreation(
        user: FirebaseUser.fromJson(json[r'user'])!,
      );
    }
    return null;
  }

  static List<AdminApplicationCreation>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminApplicationCreation>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminApplicationCreation.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AdminApplicationCreation> mapFromJson(dynamic json) {
    final map = <String, AdminApplicationCreation>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminApplicationCreation.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdminApplicationCreation-objects as value to a dart map
  static Map<String, List<AdminApplicationCreation>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AdminApplicationCreation>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminApplicationCreation.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'user',
  };
}

