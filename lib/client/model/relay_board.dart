//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class RelayBoard {
  /// Instantiate a new enum with the provided [value].
  const RelayBoard._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const localGPIO = RelayBoard._(r'localGPIO');
  static const danBoard = RelayBoard._(r'danBoard');

  /// List of all possible values in this [enum][RelayBoard].
  static const values = <RelayBoard>[
    localGPIO,
    danBoard,
  ];

  static RelayBoard? fromJson(dynamic value) => RelayBoardTypeTransformer().decode(value);

  static List<RelayBoard>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <RelayBoard>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RelayBoard.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [RelayBoard] to String,
/// and [decode] dynamic data back to [RelayBoard].
class RelayBoardTypeTransformer {
  factory RelayBoardTypeTransformer() => _instance ??= const RelayBoardTypeTransformer._();

  const RelayBoardTypeTransformer._();

  String encode(RelayBoard data) => data.value;

  /// Decodes a [dynamic value][data] to a RelayBoard.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  RelayBoard? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'localGPIO': return RelayBoard.localGPIO;
        case r'danBoard': return RelayBoard.danBoard;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [RelayBoardTypeTransformer] instance.
  static RelayBoardTypeTransformer? _instance;
}

