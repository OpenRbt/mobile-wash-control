//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UserRoleUpdate {
  /// Returns a new [UserRoleUpdate] instance.
  UserRoleUpdate({
    this.role,
  });

  UserRoleUpdateRoleEnum? role;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UserRoleUpdate &&
     other.role == role;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (role == null ? 0 : role!.hashCode);

  @override
  String toString() => 'UserRoleUpdate[role=$role]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.role != null) {
      json[r'role'] = this.role;
    } else {
      json[r'role'] = null;
    }
    return json;
  }

  /// Returns a new [UserRoleUpdate] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UserRoleUpdate? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UserRoleUpdate[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UserRoleUpdate[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UserRoleUpdate(
        role: UserRoleUpdateRoleEnum.fromJson(json[r'role']),
      );
    }
    return null;
  }

  static List<UserRoleUpdate>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UserRoleUpdate>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserRoleUpdate.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UserRoleUpdate> mapFromJson(dynamic json) {
    final map = <String, UserRoleUpdate>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UserRoleUpdate.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UserRoleUpdate-objects as value to a dart map
  static Map<String, List<UserRoleUpdate>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UserRoleUpdate>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UserRoleUpdate.listFromJson(entry.value, growable: growable,);
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


class UserRoleUpdateRoleEnum {
  /// Instantiate a new enum with the provided [value].
  const UserRoleUpdateRoleEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const user = UserRoleUpdateRoleEnum._(r'user');
  static const admin = UserRoleUpdateRoleEnum._(r'admin');
  static const engineer = UserRoleUpdateRoleEnum._(r'engineer');

  /// List of all possible values in this [enum][UserRoleUpdateRoleEnum].
  static const values = <UserRoleUpdateRoleEnum>[
    user,
    admin,
    engineer,
  ];

  static UserRoleUpdateRoleEnum? fromJson(dynamic value) => UserRoleUpdateRoleEnumTypeTransformer().decode(value);

  static List<UserRoleUpdateRoleEnum>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UserRoleUpdateRoleEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserRoleUpdateRoleEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [UserRoleUpdateRoleEnum] to String,
/// and [decode] dynamic data back to [UserRoleUpdateRoleEnum].
class UserRoleUpdateRoleEnumTypeTransformer {
  factory UserRoleUpdateRoleEnumTypeTransformer() => _instance ??= const UserRoleUpdateRoleEnumTypeTransformer._();

  const UserRoleUpdateRoleEnumTypeTransformer._();

  String encode(UserRoleUpdateRoleEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a UserRoleUpdateRoleEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  UserRoleUpdateRoleEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'user': return UserRoleUpdateRoleEnum.user;
        case r'admin': return UserRoleUpdateRoleEnum.admin;
        case r'engineer': return UserRoleUpdateRoleEnum.engineer;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [UserRoleUpdateRoleEnumTypeTransformer] instance.
  static UserRoleUpdateRoleEnumTypeTransformer? _instance;
}


