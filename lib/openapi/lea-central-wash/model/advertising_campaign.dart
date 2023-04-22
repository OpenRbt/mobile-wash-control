//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DiscountCampaign {
  /// Returns a new [DiscountCampaign] instance.
  DiscountCampaign({
    this.id,
    this.name,
    required this.startDate,
    required this.endDate,
    this.enabled,
    this.startMinute,
    this.endMinute,
    this.defaultDiscount,
    this.discountPrograms = const [],
    this.weekday = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? id;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;

  /// Unix time local
  int startDate;

  /// Unix time local
  int endDate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? enabled;

  /// Minimum value: 0
  /// Maximum value: 1440
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? startMinute;

  /// Minimum value: 0
  /// Maximum value: 1440
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? endMinute;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? defaultDiscount;

  List<DiscountProgram> discountPrograms;

  List<AdvertisingCampaignWeekdayEnum> weekday;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiscountCampaign &&
          other.id == id &&
          other.name == name &&
          other.startDate == startDate &&
          other.endDate == endDate &&
          other.enabled == enabled &&
          other.startMinute == startMinute &&
          other.endMinute == endMinute &&
          other.defaultDiscount == defaultDiscount &&
          other.discountPrograms == discountPrograms &&
          other.weekday == weekday;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (id == null ? 0 : id!.hashCode) +
      (name == null ? 0 : name!.hashCode) +
      (startDate.hashCode) +
      (endDate.hashCode) +
      (enabled == null ? 0 : enabled!.hashCode) +
      (startMinute == null ? 0 : startMinute!.hashCode) +
      (endMinute == null ? 0 : endMinute!.hashCode) +
      (defaultDiscount == null ? 0 : defaultDiscount!.hashCode) +
      (discountPrograms.hashCode) +
      (weekday.hashCode);

  @override
  String toString() =>
      'AdvertisingCampaign[id=$id, name=$name, startDate=$startDate, endDate=$endDate, enabled=$enabled, startMinute=$startMinute, endMinute=$endMinute, defaultDiscount=$defaultDiscount, discountPrograms=$discountPrograms, weekday=$weekday]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    json[r'startDate'] = this.startDate;
    json[r'endDate'] = this.endDate;
    if (this.enabled != null) {
      json[r'enabled'] = this.enabled;
    } else {
      json[r'enabled'] = null;
    }
    if (this.startMinute != null) {
      json[r'startMinute'] = this.startMinute;
    } else {
      json[r'startMinute'] = null;
    }
    if (this.endMinute != null) {
      json[r'endMinute'] = this.endMinute;
    } else {
      json[r'endMinute'] = null;
    }
    if (this.defaultDiscount != null) {
      json[r'defaultDiscount'] = this.defaultDiscount;
    } else {
      json[r'defaultDiscount'] = null;
    }
    json[r'discountPrograms'] = this.discountPrograms;
    json[r'weekday'] = this.weekday;
    return json;
  }

  /// Returns a new [DiscountCampaign] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DiscountCampaign? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AdvertisingCampaign[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AdvertisingCampaign[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DiscountCampaign(
        id: mapValueOfType<int>(json, r'id'),
        name: mapValueOfType<String>(json, r'name'),
        startDate: mapValueOfType<int>(json, r'startDate')!,
        endDate: mapValueOfType<int>(json, r'endDate')!,
        enabled: mapValueOfType<bool>(json, r'enabled'),
        startMinute: mapValueOfType<int>(json, r'startMinute'),
        endMinute: mapValueOfType<int>(json, r'endMinute'),
        defaultDiscount: mapValueOfType<int>(json, r'defaultDiscount'),
        discountPrograms: DiscountProgram.listFromJson(json[r'discountPrograms']) ?? const [],
        weekday: AdvertisingCampaignWeekdayEnum.listFromJson(json[r'weekday']) ?? const [],
      );
    }
    return null;
  }

  static List<DiscountCampaign>? listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <DiscountCampaign>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DiscountCampaign.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DiscountCampaign> mapFromJson(dynamic json) {
    final map = <String, DiscountCampaign>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DiscountCampaign.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdvertisingCampaign-objects as value to a dart map
  static Map<String, List<DiscountCampaign>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<DiscountCampaign>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DiscountCampaign.listFromJson(
          entry.value,
          growable: growable,
        );
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'startDate',
    'endDate',
  };
}

class AdvertisingCampaignWeekdayEnum {
  /// Instantiate a new enum with the provided [value].
  const AdvertisingCampaignWeekdayEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const sunday = AdvertisingCampaignWeekdayEnum._(r'sunday');
  static const monday = AdvertisingCampaignWeekdayEnum._(r'monday');
  static const tuesday = AdvertisingCampaignWeekdayEnum._(r'tuesday');
  static const wednesday = AdvertisingCampaignWeekdayEnum._(r'wednesday');
  static const thursday = AdvertisingCampaignWeekdayEnum._(r'thursday');
  static const friday = AdvertisingCampaignWeekdayEnum._(r'friday');
  static const saturday = AdvertisingCampaignWeekdayEnum._(r'saturday');

  /// List of all possible values in this [enum][AdvertisingCampaignWeekdayEnum].
  static const values = <AdvertisingCampaignWeekdayEnum>[
    sunday,
    monday,
    tuesday,
    wednesday,
    thursday,
    friday,
    saturday,
  ];

  static AdvertisingCampaignWeekdayEnum? fromJson(dynamic value) => AdvertisingCampaignWeekdayEnumTypeTransformer().decode(value);

  static List<AdvertisingCampaignWeekdayEnum>? listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <AdvertisingCampaignWeekdayEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdvertisingCampaignWeekdayEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AdvertisingCampaignWeekdayEnum] to String,
/// and [decode] dynamic data back to [AdvertisingCampaignWeekdayEnum].
class AdvertisingCampaignWeekdayEnumTypeTransformer {
  factory AdvertisingCampaignWeekdayEnumTypeTransformer() => _instance ??= const AdvertisingCampaignWeekdayEnumTypeTransformer._();

  const AdvertisingCampaignWeekdayEnumTypeTransformer._();

  String encode(AdvertisingCampaignWeekdayEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a AdvertisingCampaignWeekdayEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AdvertisingCampaignWeekdayEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'sunday':
          return AdvertisingCampaignWeekdayEnum.sunday;
        case r'monday':
          return AdvertisingCampaignWeekdayEnum.monday;
        case r'tuesday':
          return AdvertisingCampaignWeekdayEnum.tuesday;
        case r'wednesday':
          return AdvertisingCampaignWeekdayEnum.wednesday;
        case r'thursday':
          return AdvertisingCampaignWeekdayEnum.thursday;
        case r'friday':
          return AdvertisingCampaignWeekdayEnum.friday;
        case r'saturday':
          return AdvertisingCampaignWeekdayEnum.saturday;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [AdvertisingCampaignWeekdayEnumTypeTransformer] instance.
  static AdvertisingCampaignWeekdayEnumTypeTransformer? _instance;
}
