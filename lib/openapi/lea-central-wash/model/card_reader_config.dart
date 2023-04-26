//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CardReaderConfig {
  /// Returns a new [CardReaderConfig] instance.
  CardReaderConfig({
    required this.stationID,
    this.cardReaderType,
    this.host,
    this.port,
  });

  int stationID;

  CardReaderConfigCardReaderTypeEnum? cardReaderType;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? host;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? port;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CardReaderConfig &&
     other.stationID == stationID &&
     other.cardReaderType == cardReaderType &&
     other.host == host &&
     other.port == port;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (stationID.hashCode) +
    (cardReaderType == null ? 0 : cardReaderType!.hashCode) +
    (host == null ? 0 : host!.hashCode) +
    (port == null ? 0 : port!.hashCode);

  @override
  String toString() => 'CardReaderConfig[stationID=$stationID, cardReaderType=$cardReaderType, host=$host, port=$port]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'stationID'] = this.stationID;
    if (this.cardReaderType != null) {
      json[r'cardReaderType'] = this.cardReaderType;
    } else {
      json[r'cardReaderType'] = null;
    }
    if (this.host != null) {
      json[r'host'] = this.host;
    } else {
      json[r'host'] = null;
    }
    if (this.port != null) {
      json[r'port'] = this.port;
    } else {
      json[r'port'] = null;
    }
    return json;
  }

  /// Returns a new [CardReaderConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CardReaderConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CardReaderConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CardReaderConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CardReaderConfig(
        stationID: mapValueOfType<int>(json, r'stationID')!,
        cardReaderType: CardReaderConfigCardReaderTypeEnum.fromJson(json[r'cardReaderType']),
        host: mapValueOfType<String>(json, r'host'),
        port: mapValueOfType<String>(json, r'port'),
      );
    }
    return null;
  }

  static List<CardReaderConfig>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CardReaderConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CardReaderConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CardReaderConfig> mapFromJson(dynamic json) {
    final map = <String, CardReaderConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CardReaderConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CardReaderConfig-objects as value to a dart map
  static Map<String, List<CardReaderConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CardReaderConfig>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CardReaderConfig.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'stationID',
  };
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

  static CardReaderConfigCardReaderTypeEnum? fromJson(dynamic value) => CardReaderConfigCardReaderTypeEnumTypeTransformer().decode(value);

  static List<CardReaderConfigCardReaderTypeEnum>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CardReaderConfigCardReaderTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CardReaderConfigCardReaderTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CardReaderConfigCardReaderTypeEnum] to String,
/// and [decode] dynamic data back to [CardReaderConfigCardReaderTypeEnum].
class CardReaderConfigCardReaderTypeEnumTypeTransformer {
  factory CardReaderConfigCardReaderTypeEnumTypeTransformer() => _instance ??= const CardReaderConfigCardReaderTypeEnumTypeTransformer._();

  const CardReaderConfigCardReaderTypeEnumTypeTransformer._();

  String encode(CardReaderConfigCardReaderTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a CardReaderConfigCardReaderTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CardReaderConfigCardReaderTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'NOT_USED': return CardReaderConfigCardReaderTypeEnum.NOT_USED;
        case r'VENDOTEK': return CardReaderConfigCardReaderTypeEnum.VENDOTEK;
        case r'PAYMENT_WORLD': return CardReaderConfigCardReaderTypeEnum.PAYMENT_WORLD;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [CardReaderConfigCardReaderTypeEnumTypeTransformer] instance.
  static CardReaderConfigCardReaderTypeEnumTypeTransformer? _instance;
}


