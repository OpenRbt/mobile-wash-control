//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdminApplicationReview {
  /// Returns a new [AdminApplicationReview] instance.
  AdminApplicationReview({
    this.status,
    this.organizationId,
    this.role,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ApplicationStatusEnum? status;

  String? organizationId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AdminUserRole? role;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminApplicationReview &&
     other.status == status &&
     other.organizationId == organizationId &&
     other.role == role;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (status == null ? 0 : status!.hashCode) +
    (organizationId == null ? 0 : organizationId!.hashCode) +
    (role == null ? 0 : role!.hashCode);

  @override
  String toString() => 'AdminApplicationReview[status=$status, organizationId=$organizationId, role=$role]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.status != null) {
      json[r'status'] = this.status;
    } else {
      json[r'status'] = null;
    }
    if (this.organizationId != null) {
      json[r'organizationId'] = this.organizationId;
    } else {
      json[r'organizationId'] = null;
    }
    if (this.role != null) {
      json[r'role'] = this.role;
    } else {
      json[r'role'] = null;
    }
    return json;
  }

  /// Returns a new [AdminApplicationReview] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AdminApplicationReview? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AdminApplicationReview[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AdminApplicationReview[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AdminApplicationReview(
        status: ApplicationStatusEnum.fromJson(json[r'status']),
        organizationId: mapValueOfType<String>(json, r'organizationId'),
        role: AdminUserRole.fromJson(json[r'role']),
      );
    }
    return null;
  }

  static List<AdminApplicationReview>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminApplicationReview>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminApplicationReview.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AdminApplicationReview> mapFromJson(dynamic json) {
    final map = <String, AdminApplicationReview>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminApplicationReview.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdminApplicationReview-objects as value to a dart map
  static Map<String, List<AdminApplicationReview>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AdminApplicationReview>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminApplicationReview.listFromJson(entry.value, growable: growable,);
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

