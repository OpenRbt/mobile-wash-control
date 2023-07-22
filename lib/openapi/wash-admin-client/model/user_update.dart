//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UserUpdate {
  /// Returns a new [UserUpdate] instance.
  UserUpdate({
    this.role,
  });

  UserUpdateRoleEnum? role;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UserUpdate &&
     other.role == role;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (role == null ? 0 : role!.hashCode);

  @override
  String toString() => 'UserUpdate[role=$role]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.role != null) {
      json[r'role'] = this.role;
    } else {
      json[r'role'] = null;
    }
    return json;
  }

  /// Returns a new [UserUpdate] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UserUpdate? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UserUpdate[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UserUpdate[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UserUpdate(
        role: UserUpdateRoleEnum.fromJson(json[r'role']),
      );
    }
    return null;
  }

  static List<UserUpdate>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UserUpdate>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserUpdate.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UserUpdate> mapFromJson(dynamic json) {
    final map = <String, UserUpdate>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UserUpdate.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UserUpdate-objects as value to a dart map
  static Map<String, List<UserUpdate>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UserUpdate>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UserUpdate.listFromJson(entry.value, growable: growable,);
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


class UserUpdateRoleEnum {
  /// Instantiate a new enum with the provided [value].
  const UserUpdateRoleEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const user = UserUpdateRoleEnum._(r'user');
  static const admin = UserUpdateRoleEnum._(r'admin');
  static const engineer = UserUpdateRoleEnum._(r'engineer');

  /// List of all possible values in this [enum][UserUpdateRoleEnum].
  static const values = <UserUpdateRoleEnum>[
    user,
    admin,
    engineer,
  ];

  static UserUpdateRoleEnum? fromJson(dynamic value) => UserUpdateRoleEnumTypeTransformer().decode(value);

  static List<UserUpdateRoleEnum>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UserUpdateRoleEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserUpdateRoleEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [UserUpdateRoleEnum] to String,
/// and [decode] dynamic data back to [UserUpdateRoleEnum].
class UserUpdateRoleEnumTypeTransformer {
  factory UserUpdateRoleEnumTypeTransformer() => _instance ??= const UserUpdateRoleEnumTypeTransformer._();

  const UserUpdateRoleEnumTypeTransformer._();

  String encode(UserUpdateRoleEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a UserUpdateRoleEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  UserUpdateRoleEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'user': return UserUpdateRoleEnum.user;
        case r'admin': return UserUpdateRoleEnum.admin;
        case r'engineer': return UserUpdateRoleEnum.engineer;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [UserUpdateRoleEnumTypeTransformer] instance.
  static UserUpdateRoleEnumTypeTransformer? _instance;
}


