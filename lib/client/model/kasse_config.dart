//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class KasseConfig {
  /// Returns a new [KasseConfig] instance.
  KasseConfig({
    this.tax,
    this.receiptItemName,
    this.cashier,
    this.cashierINN,
  });

  KasseConfigTaxEnum tax;

  String receiptItemName;

  String cashier;

  String cashierINN;

  @override
  bool operator ==(Object other) => identical(this, other) || other is KasseConfig &&
     other.tax == tax &&
     other.receiptItemName == receiptItemName &&
     other.cashier == cashier &&
     other.cashierINN == cashierINN;

  @override
  int get hashCode =>
    (tax == null ? 0 : tax.hashCode) +
    (receiptItemName == null ? 0 : receiptItemName.hashCode) +
    (cashier == null ? 0 : cashier.hashCode) +
    (cashierINN == null ? 0 : cashierINN.hashCode);

  @override
  String toString() => 'KasseConfig[tax=$tax, receiptItemName=$receiptItemName, cashier=$cashier, cashierINN=$cashierINN]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (tax != null) {
      json[r'tax'] = tax;
    }
    if (receiptItemName != null) {
      json[r'receiptItemName'] = receiptItemName;
    }
    if (cashier != null) {
      json[r'cashier'] = cashier;
    }
    if (cashierINN != null) {
      json[r'cashierINN'] = cashierINN;
    }
    return json;
  }

  /// Returns a new [KasseConfig] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static KasseConfig fromJson(Map<String, dynamic> json) => json == null
    ? null
    : KasseConfig(
        tax: KasseConfigTaxEnum.fromJson(json[r'tax']),
        receiptItemName: json[r'receiptItemName'],
        cashier: json[r'cashier'],
        cashierINN: json[r'cashierINN'],
    );

  static List<KasseConfig> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <KasseConfig>[]
      : json.map((dynamic value) => KasseConfig.fromJson(value)).toList(growable: true == growable);

  static Map<String, KasseConfig> mapFromJson(Map<String, dynamic> json) {
    final map = <String, KasseConfig>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = KasseConfig.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of KasseConfig-objects as value to a dart map
  static Map<String, List<KasseConfig>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<KasseConfig>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = KasseConfig.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}


class KasseConfigTaxEnum {
  /// Instantiate a new enum with the provided [value].
  const KasseConfigTaxEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const vAT110 = KasseConfigTaxEnum._(r'TAX_VAT110');
  static const vAT0 = KasseConfigTaxEnum._(r'TAX_VAT0');
  static const NO = KasseConfigTaxEnum._(r'TAX_NO');
  static const vAT120 = KasseConfigTaxEnum._(r'TAX_VAT120');

  /// List of all possible values in this [enum][KasseConfigTaxEnum].
  static const values = <KasseConfigTaxEnum>[
    vAT110,
    vAT0,
    NO,
    vAT120,
  ];

  static KasseConfigTaxEnum fromJson(dynamic value) =>
    KasseConfigTaxEnumTypeTransformer().decode(value);

  static List<KasseConfigTaxEnum> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <KasseConfigTaxEnum>[]
      : json
          .map((value) => KasseConfigTaxEnum.fromJson(value))
          .toList(growable: true == growable);
}

/// Transformation class that can [encode] an instance of [KasseConfigTaxEnum] to String,
/// and [decode] dynamic data back to [KasseConfigTaxEnum].
class KasseConfigTaxEnumTypeTransformer {
  const KasseConfigTaxEnumTypeTransformer._();

  factory KasseConfigTaxEnumTypeTransformer() => _instance ??= KasseConfigTaxEnumTypeTransformer._();

  String encode(KasseConfigTaxEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a KasseConfigTaxEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  KasseConfigTaxEnum decode(dynamic data, {bool allowNull}) {
    switch (data) {
      case r'TAX_VAT110': return KasseConfigTaxEnum.vAT110;
      case r'TAX_VAT0': return KasseConfigTaxEnum.vAT0;
      case r'TAX_NO': return KasseConfigTaxEnum.NO;
      case r'TAX_VAT120': return KasseConfigTaxEnum.vAT120;
      default:
        if (allowNull == false) {
          throw ArgumentError('Unknown enum value to decode: $data');
        }
    }
    return null;
  }

  /// Singleton [KasseConfigTaxEnumTypeTransformer] instance.
  static KasseConfigTaxEnumTypeTransformer _instance;
}

