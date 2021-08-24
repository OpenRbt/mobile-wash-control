//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
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

  static RelayBoard fromJson(dynamic value) => RelayBoardTypeTransformer().decode(value);

  static List<RelayBoard> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <RelayBoard>[]
          : json.map((value) => RelayBoard.fromJson(value)).toList(growable: true == growable);
}

/// Transformation class that can [encode] an instance of [RelayBoard] to String,
/// and [decode] dynamic data back to [RelayBoard].
class RelayBoardTypeTransformer {
  const RelayBoardTypeTransformer._();

  factory RelayBoardTypeTransformer() => _instance ??= RelayBoardTypeTransformer._();

  String encode(RelayBoard data) => data.value;

  /// Decodes a [dynamic value][data] to a RelayBoard.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  RelayBoard decode(dynamic data, {bool allowNull}) {
    switch (data) {
      case r'localGPIO':
        return RelayBoard.localGPIO;
      case r'danBoard':
        return RelayBoard.danBoard;
      default:
        if (allowNull == false) {
          throw ArgumentError('Unknown enum value to decode: $data');
        }
    }
    return null;
  }

  /// Singleton [RelayBoardTypeTransformer] instance.
  static RelayBoardTypeTransformer _instance;
}
