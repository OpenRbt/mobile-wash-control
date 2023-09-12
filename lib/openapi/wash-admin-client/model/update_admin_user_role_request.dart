//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateAdminUserRoleRequest {
  /// Returns a new [UpdateAdminUserRoleRequest] instance.
  UpdateAdminUserRoleRequest({
    this.role,
  });

  UpdateAdminUserRoleRequestRoleEnum? role;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateAdminUserRoleRequest &&
     other.role == role;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (role == null ? 0 : role!.hashCode);

  @override
  String toString() => 'UpdateAdminUserRoleRequest[role=$role]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.role != null) {
      json[r'role'] = this.role;
    } else {
      json[r'role'] = null;
    }
    return json;
  }

  /// Returns a new [UpdateAdminUserRoleRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateAdminUserRoleRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateAdminUserRoleRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateAdminUserRoleRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateAdminUserRoleRequest(
        role: UpdateAdminUserRoleRequestRoleEnum.fromJson(json[r'role']),
      );
    }
    return null;
  }

  static List<UpdateAdminUserRoleRequest>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateAdminUserRoleRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateAdminUserRoleRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateAdminUserRoleRequest> mapFromJson(dynamic json) {
    final map = <String, UpdateAdminUserRoleRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateAdminUserRoleRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateAdminUserRoleRequest-objects as value to a dart map
  static Map<String, List<UpdateAdminUserRoleRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateAdminUserRoleRequest>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateAdminUserRoleRequest.listFromJson(entry.value, growable: growable,);
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


class UpdateAdminUserRoleRequestRoleEnum {
  /// Instantiate a new enum with the provided [value].
  const UpdateAdminUserRoleRequestRoleEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const systemManager = UpdateAdminUserRoleRequestRoleEnum._(r'systemManager');
  static const admin = UpdateAdminUserRoleRequestRoleEnum._(r'admin');

  /// List of all possible values in this [enum][UpdateAdminUserRoleRequestRoleEnum].
  static const values = <UpdateAdminUserRoleRequestRoleEnum>[
    systemManager,
    admin,
  ];

  static UpdateAdminUserRoleRequestRoleEnum? fromJson(dynamic value) => UpdateAdminUserRoleRequestRoleEnumTypeTransformer().decode(value);

  static List<UpdateAdminUserRoleRequestRoleEnum>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateAdminUserRoleRequestRoleEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateAdminUserRoleRequestRoleEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [UpdateAdminUserRoleRequestRoleEnum] to String,
/// and [decode] dynamic data back to [UpdateAdminUserRoleRequestRoleEnum].
class UpdateAdminUserRoleRequestRoleEnumTypeTransformer {
  factory UpdateAdminUserRoleRequestRoleEnumTypeTransformer() => _instance ??= const UpdateAdminUserRoleRequestRoleEnumTypeTransformer._();

  const UpdateAdminUserRoleRequestRoleEnumTypeTransformer._();

  String encode(UpdateAdminUserRoleRequestRoleEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a UpdateAdminUserRoleRequestRoleEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  UpdateAdminUserRoleRequestRoleEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'systemManager': return UpdateAdminUserRoleRequestRoleEnum.systemManager;
        case r'admin': return UpdateAdminUserRoleRequestRoleEnum.admin;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [UpdateAdminUserRoleRequestRoleEnumTypeTransformer] instance.
  static UpdateAdminUserRoleRequestRoleEnumTypeTransformer? _instance;
}


