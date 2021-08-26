//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CardReaderConfig {
  /// Returns a new [CardReaderConfig] instance.
  CardReaderConfig({
    @required this.stationID,
    this.cardReaderType,
    this.host,
    this.port,
  });

  int stationID;

  CardReaderConfigCardReaderTypeEnum cardReaderType;

  String host;

  String port;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CardReaderConfig && other.stationID == stationID && other.cardReaderType == cardReaderType && other.host == host && other.port == port;

  @override
  int get hashCode => (stationID == null ? 0 : stationID.hashCode) + (cardReaderType == null ? 0 : cardReaderType.hashCode) + (host == null ? 0 : host.hashCode) + (port == null ? 0 : port.hashCode);

  @override
  String toString() => 'CardReaderConfig[stationID=$stationID, cardReaderType=$cardReaderType, host=$host, port=$port]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'stationID'] = stationID;
    if (cardReaderType != null) {
      json[r'cardReaderType'] = cardReaderType;
    }
    if (host != null) {
      json[r'host'] = host;
    }
    if (port != null) {
      json[r'port'] = port;
    }
    return json;
  }

  /// Returns a new [CardReaderConfig] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static CardReaderConfig fromJson(Map<String, dynamic> json) => json == null
      ? null
      : CardReaderConfig(
          stationID: json[r'stationID'],
          cardReaderType: CardReaderConfigCardReaderTypeEnum.fromJson(json[r'cardReaderType']),
          host: json[r'host'],
          port: json[r'port'],
        );

  static List<CardReaderConfig> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <CardReaderConfig>[]
          : json.map((dynamic value) => CardReaderConfig.fromJson(value)).toList(growable: true == growable);

  static Map<String, CardReaderConfig> mapFromJson(Map<String, dynamic> json) {
    final map = <String, CardReaderConfig>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = CardReaderConfig.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of CardReaderConfig-objects as value to a dart map
  static Map<String, List<CardReaderConfig>> mapListFromJson(
    Map<String, dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<CardReaderConfig>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = CardReaderConfig.listFromJson(
          value,
          emptyIsNull: emptyIsNull,
          growable: growable,
        );
      });
    }
    return map;
  }
}

class CardReaderConfigCardReaderTypeEnum {
  /// Instantiate a new enum with the provided [value].
  const CardReaderConfigCardReaderTypeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const NOT_USED = CardReaderConfigCardReaderTypeEnum._(r'NOT_USED');
  static const VENDOTEK = CardReaderConfigCardReaderTypeEnum._(r'VENDOTEK');
  static const PAYMENT_WORLD = CardReaderConfigCardReaderTypeEnum._(r'PAYMENT_WORLD');

  /// List of all possible values in this [enum][CardReaderConfigCardReaderTypeEnum].
  static const values = <CardReaderConfigCardReaderTypeEnum>[
    NOT_USED,
    VENDOTEK,
    PAYMENT_WORLD,
  ];

  static CardReaderConfigCardReaderTypeEnum fromJson(dynamic value) => CardReaderConfigCardReaderTypeEnumTypeTransformer().decode(value);

  static List<CardReaderConfigCardReaderTypeEnum> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <CardReaderConfigCardReaderTypeEnum>[]
          : json.map((value) => CardReaderConfigCardReaderTypeEnum.fromJson(value)).toList(growable: true == growable);
}

/// Transformation class that can [encode] an instance of [CardReaderConfigCardReaderTypeEnum] to String,
/// and [decode] dynamic data back to [CardReaderConfigCardReaderTypeEnum].
class CardReaderConfigCardReaderTypeEnumTypeTransformer {
  const CardReaderConfigCardReaderTypeEnumTypeTransformer._();

  factory CardReaderConfigCardReaderTypeEnumTypeTransformer() => _instance ??= CardReaderConfigCardReaderTypeEnumTypeTransformer._();

  String encode(CardReaderConfigCardReaderTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a CardReaderConfigCardReaderTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CardReaderConfigCardReaderTypeEnum decode(dynamic data, {bool allowNull}) {
    switch (data) {
      case r'NOT_USED':
        return CardReaderConfigCardReaderTypeEnum.NOT_USED;
      case r'VENDOTEK':
        return CardReaderConfigCardReaderTypeEnum.VENDOTEK;
      case r'PAYMENT_WORLD':
        return CardReaderConfigCardReaderTypeEnum.PAYMENT_WORLD;
      default:
        if (allowNull == false) {
          throw ArgumentError('Unknown enum value to decode: $data');
        }
    }
    return null;
  }

  /// Singleton [CardReaderConfigCardReaderTypeEnumTypeTransformer] instance.
  static CardReaderConfigCardReaderTypeEnumTypeTransformer _instance;
}
