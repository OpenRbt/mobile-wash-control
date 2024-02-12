//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AdminUserRole {
  /// Instantiate a new enum with the provided [value].
  const AdminUserRole._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const systemManager = AdminUserRole._(r'systemManager');
  static const admin = AdminUserRole._(r'admin');
  static const noAccess = AdminUserRole._(r'noAccess');

  /// List of all possible values in this [enum][AdminUserRole].
  static const values = <AdminUserRole>[
    systemManager,
    admin,
    noAccess,
  ];

  static AdminUserRole? fromJson(dynamic value) => AdminUserRoleTypeTransformer().decode(value);

  static List<AdminUserRole>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminUserRole>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminUserRole.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AdminUserRole] to String,
/// and [decode] dynamic data back to [AdminUserRole].
class AdminUserRoleTypeTransformer {
  factory AdminUserRoleTypeTransformer() => _instance ??= const AdminUserRoleTypeTransformer._();

  const AdminUserRoleTypeTransformer._();

  String encode(AdminUserRole data) => data.value;

  /// Decodes a [dynamic value][data] to a AdminUserRole.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AdminUserRole? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'systemManager': return AdminUserRole.systemManager;
        case r'admin': return AdminUserRole.admin;
        case r'noAccess': return AdminUserRole.noAccess;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [AdminUserRoleTypeTransformer] instance.
  static AdminUserRoleTypeTransformer? _instance;
}

