//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ApplicationStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const ApplicationStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const accepted = ApplicationStatusEnum._(r'accepted');
  static const rejected = ApplicationStatusEnum._(r'rejected');
  static const pending = ApplicationStatusEnum._(r'pending');

  /// List of all possible values in this [enum][ApplicationStatusEnum].
  static const values = <ApplicationStatusEnum>[
    accepted,
    rejected,
    pending,
  ];

  static ApplicationStatusEnum? fromJson(dynamic value) => ApplicationStatusEnumTypeTransformer().decode(value);

  static List<ApplicationStatusEnum>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ApplicationStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ApplicationStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ApplicationStatusEnum] to String,
/// and [decode] dynamic data back to [ApplicationStatusEnum].
class ApplicationStatusEnumTypeTransformer {
  factory ApplicationStatusEnumTypeTransformer() => _instance ??= const ApplicationStatusEnumTypeTransformer._();

  const ApplicationStatusEnumTypeTransformer._();

  String encode(ApplicationStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a ApplicationStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ApplicationStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'accepted': return ApplicationStatusEnum.accepted;
        case r'rejected': return ApplicationStatusEnum.rejected;
        case r'pending': return ApplicationStatusEnum.pending;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ApplicationStatusEnumTypeTransformer] instance.
  static ApplicationStatusEnumTypeTransformer? _instance;
}

