//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
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

  KasseConfigTaxEnum? tax;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? receiptItemName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? cashier;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? cashierINN;

  @override
  bool operator ==(Object other) => identical(this, other) || other is KasseConfig &&
     other.tax == tax &&
     other.receiptItemName == receiptItemName &&
     other.cashier == cashier &&
     other.cashierINN == cashierINN;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (tax == null ? 0 : tax!.hashCode) +
    (receiptItemName == null ? 0 : receiptItemName!.hashCode) +
    (cashier == null ? 0 : cashier!.hashCode) +
    (cashierINN == null ? 0 : cashierINN!.hashCode);

  @override
  String toString() => 'KasseConfig[tax=$tax, receiptItemName=$receiptItemName, cashier=$cashier, cashierINN=$cashierINN]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.tax != null) {
      json[r'tax'] = this.tax;
    } else {
      json[r'tax'] = null;
    }
    if (this.receiptItemName != null) {
      json[r'receiptItemName'] = this.receiptItemName;
    } else {
      json[r'receiptItemName'] = null;
    }
    if (this.cashier != null) {
      json[r'cashier'] = this.cashier;
    } else {
      json[r'cashier'] = null;
    }
    if (this.cashierINN != null) {
      json[r'cashierINN'] = this.cashierINN;
    } else {
      json[r'cashierINN'] = null;
    }
    return json;
  }

  /// Returns a new [KasseConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static KasseConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "KasseConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "KasseConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return KasseConfig(
        tax: KasseConfigTaxEnum.fromJson(json[r'tax']),
        receiptItemName: mapValueOfType<String>(json, r'receiptItemName'),
        cashier: mapValueOfType<String>(json, r'cashier'),
        cashierINN: mapValueOfType<String>(json, r'cashierINN'),
      );
    }
    return null;
  }

  static List<KasseConfig>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <KasseConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = KasseConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, KasseConfig> mapFromJson(dynamic json) {
    final map = <String, KasseConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = KasseConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of KasseConfig-objects as value to a dart map
  static Map<String, List<KasseConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<KasseConfig>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = KasseConfig.listFromJson(entry.value, growable: growable,);
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

  static KasseConfigTaxEnum? fromJson(dynamic value) => KasseConfigTaxEnumTypeTransformer().decode(value);

  static List<KasseConfigTaxEnum>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <KasseConfigTaxEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = KasseConfigTaxEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [KasseConfigTaxEnum] to String,
/// and [decode] dynamic data back to [KasseConfigTaxEnum].
class KasseConfigTaxEnumTypeTransformer {
  factory KasseConfigTaxEnumTypeTransformer() => _instance ??= const KasseConfigTaxEnumTypeTransformer._();

  const KasseConfigTaxEnumTypeTransformer._();

  String encode(KasseConfigTaxEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a KasseConfigTaxEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  KasseConfigTaxEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'TAX_VAT110': return KasseConfigTaxEnum.vAT110;
        case r'TAX_VAT0': return KasseConfigTaxEnum.vAT0;
        case r'TAX_NO': return KasseConfigTaxEnum.NO;
        case r'TAX_VAT120': return KasseConfigTaxEnum.vAT120;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [KasseConfigTaxEnumTypeTransformer] instance.
  static KasseConfigTaxEnumTypeTransformer? _instance;
}


