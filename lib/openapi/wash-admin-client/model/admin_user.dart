//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdminUser {
  /// Returns a new [AdminUser] instance.
  AdminUser({
    this.id,
    this.name,
    this.email,
    this.role,
    this.organizationId,
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
  String? email;

  AdminUserRoleEnum? role;

  String? organizationId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminUser &&
     other.id == id &&
     other.name == name &&
     other.email == email &&
     other.role == role &&
     other.organizationId == organizationId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (email == null ? 0 : email!.hashCode) +
    (role == null ? 0 : role!.hashCode) +
    (organizationId == null ? 0 : organizationId!.hashCode);

  @override
  String toString() => 'AdminUser[id=$id, name=$name, email=$email, role=$role, organizationId=$organizationId]';

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
    if (this.email != null) {
      json[r'email'] = this.email;
    } else {
      json[r'email'] = null;
    }
    if (this.role != null) {
      json[r'role'] = this.role;
    } else {
      json[r'role'] = null;
    }
    if (this.organizationId != null) {
      json[r'organizationId'] = this.organizationId;
    } else {
      json[r'organizationId'] = null;
    }
    return json;
  }

  /// Returns a new [AdminUser] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AdminUser? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AdminUser[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AdminUser[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AdminUser(
        id: mapValueOfType<String>(json, r'id'),
        name: mapValueOfType<String>(json, r'name'),
        email: mapValueOfType<String>(json, r'email'),
        role: AdminUserRoleEnum.fromJson(json[r'role']),
        organizationId: mapValueOfType<String>(json, r'organizationId'),
      );
    }
    return null;
  }

  static List<AdminUser>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminUser>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminUser.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AdminUser> mapFromJson(dynamic json) {
    final map = <String, AdminUser>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminUser.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdminUser-objects as value to a dart map
  static Map<String, List<AdminUser>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AdminUser>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminUser.listFromJson(entry.value, growable: growable,);
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


class AdminUserRoleEnum {
  /// Instantiate a new enum with the provided [value].
  const AdminUserRoleEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const systemManager = AdminUserRoleEnum._(r'systemManager');
  static const admin = AdminUserRoleEnum._(r'admin');

  /// List of all possible values in this [enum][AdminUserRoleEnum].
  static const values = <AdminUserRoleEnum>[
    systemManager,
    admin,
  ];

  static AdminUserRoleEnum? fromJson(dynamic value) => AdminUserRoleEnumTypeTransformer().decode(value);

  static List<AdminUserRoleEnum>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminUserRoleEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminUserRoleEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AdminUserRoleEnum] to String,
/// and [decode] dynamic data back to [AdminUserRoleEnum].
class AdminUserRoleEnumTypeTransformer {
  factory AdminUserRoleEnumTypeTransformer() => _instance ??= const AdminUserRoleEnumTypeTransformer._();

  const AdminUserRoleEnumTypeTransformer._();

  String encode(AdminUserRoleEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a AdminUserRoleEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AdminUserRoleEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'systemManager': return AdminUserRoleEnum.systemManager;
        case r'admin': return AdminUserRoleEnum.admin;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [AdminUserRoleEnumTypeTransformer] instance.
  static AdminUserRoleEnumTypeTransformer? _instance;
}


