//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdminApplication {
  /// Returns a new [AdminApplication] instance.
  AdminApplication({
    required this.id,
    required this.user,
    required this.status,
  });

  String id;

  FirebaseUser user;

  ApplicationStatusEnum status;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminApplication &&
     other.id == id &&
     other.user == user &&
     other.status == status;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (user.hashCode) +
    (status.hashCode);

  @override
  String toString() => 'AdminApplication[id=$id, user=$user, status=$status]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'user'] = this.user;
      json[r'status'] = this.status;
    return json;
  }

  /// Returns a new [AdminApplication] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AdminApplication? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AdminApplication[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AdminApplication[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AdminApplication(
        id: mapValueOfType<String>(json, r'id')!,
        user: FirebaseUser.fromJson(json[r'user'])!,
        status: ApplicationStatusEnum.fromJson(json[r'status'])!,
      );
    }
    return null;
  }

  static List<AdminApplication>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminApplication>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminApplication.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AdminApplication> mapFromJson(dynamic json) {
    final map = <String, AdminApplication>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminApplication.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdminApplication-objects as value to a dart map
  static Map<String, List<AdminApplication>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AdminApplication>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminApplication.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'user',
    'status',
  };
}

