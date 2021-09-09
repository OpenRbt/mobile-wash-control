//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdvertisingCampaign {
  /// Returns a new [AdvertisingCampaign] instance.
  AdvertisingCampaign({
    this.id,
    this.name,
    @required this.startDate,
    @required this.endDate,
    this.timezone,
    this.enabled,
    this.startMinute,
    this.endMinute,
    this.defaultDiscount,
    this.discountPrograms = const [],
    this.weekday = const [],
  });

  int id;

  String name;

  /// Unix time local
  int startDate;

  /// Unix time local
  int endDate;

  /// minute
  int timezone;

  bool enabled;

  int startMinute;

  int endMinute;

  int defaultDiscount;

  List<DiscountProgram> discountPrograms;

  List<AdvertisingCampaignWeekdayEnum> weekday;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdvertisingCampaign &&
          other.id == id &&
          other.name == name &&
          other.startDate == startDate &&
          other.endDate == endDate &&
          other.timezone == timezone &&
          other.enabled == enabled &&
          other.startMinute == startMinute &&
          other.endMinute == endMinute &&
          other.defaultDiscount == defaultDiscount &&
          other.discountPrograms == discountPrograms &&
          other.weekday == weekday;

  @override
  int get hashCode =>
      (id == null ? 0 : id.hashCode) +
      (name == null ? 0 : name.hashCode) +
      (startDate == null ? 0 : startDate.hashCode) +
      (endDate == null ? 0 : endDate.hashCode) +
      (timezone == null ? 0 : timezone.hashCode) +
      (enabled == null ? 0 : enabled.hashCode) +
      (startMinute == null ? 0 : startMinute.hashCode) +
      (endMinute == null ? 0 : endMinute.hashCode) +
      (defaultDiscount == null ? 0 : defaultDiscount.hashCode) +
      (discountPrograms == null ? 0 : discountPrograms.hashCode) +
      (weekday == null ? 0 : weekday.hashCode);

  @override
  String toString() =>
      'AdvertisingCampaign[id=$id, name=$name, startDate=$startDate, endDate=$endDate, timezone=$timezone, enabled=$enabled, startMinute=$startMinute, endMinute=$endMinute, defaultDiscount=$defaultDiscount, discountPrograms=$discountPrograms, weekday=$weekday]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (id != null) {
      json[r'id'] = id;
    }
    if (name != null) {
      json[r'name'] = name;
    }
    json[r'startDate'] = startDate;
    json[r'endDate'] = endDate;
    if (timezone != null) {
      json[r'timezone'] = timezone;
    }
    if (enabled != null) {
      json[r'enabled'] = enabled;
    }
    if (startMinute != null) {
      json[r'startMinute'] = startMinute;
    }
    if (endMinute != null) {
      json[r'endMinute'] = endMinute;
    }
    if (defaultDiscount != null) {
      json[r'defaultDiscount'] = defaultDiscount;
    }
    if (discountPrograms != null) {
      json[r'discountPrograms'] = discountPrograms;
    }
    if (weekday != null) {
      json[r'weekday'] = weekday;
    }
    return json;
  }

  /// Returns a new [AdvertisingCampaign] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static AdvertisingCampaign fromJson(Map<String, dynamic> json) => json == null
      ? null
      : AdvertisingCampaign(
          id: json[r'id'],
          name: json[r'name'],
          startDate: json[r'startDate'],
          endDate: json[r'endDate'],
          timezone: json[r'timezone'],
          enabled: json[r'enabled'],
          startMinute: json[r'startMinute'],
          endMinute: json[r'endMinute'],
          defaultDiscount: json[r'defaultDiscount'],
          discountPrograms: DiscountProgram.listFromJson(json[r'discountPrograms']),
          weekday: AdvertisingCampaignWeekdayEnum.listFromJson(json[r'weekday']),
        );

  static List<AdvertisingCampaign> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <AdvertisingCampaign>[]
          : json.map((dynamic value) => AdvertisingCampaign.fromJson(value)).toList(growable: true == growable);

  static Map<String, AdvertisingCampaign> mapFromJson(Map<String, dynamic> json) {
    final map = <String, AdvertisingCampaign>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = AdvertisingCampaign.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of AdvertisingCampaign-objects as value to a dart map
  static Map<String, List<AdvertisingCampaign>> mapListFromJson(
    Map<String, dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<AdvertisingCampaign>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = AdvertisingCampaign.listFromJson(
          value,
          emptyIsNull: emptyIsNull,
          growable: growable,
        );
      });
    }
    return map;
  }
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

  static AdvertisingCampaignWeekdayEnum fromJson(dynamic value) => AdvertisingCampaignWeekdayEnumTypeTransformer().decode(value);

  static List<AdvertisingCampaignWeekdayEnum> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <AdvertisingCampaignWeekdayEnum>[]
          : json.map((value) => AdvertisingCampaignWeekdayEnum.fromJson(value)).toList(growable: true == growable);
}

/// Transformation class that can [encode] an instance of [AdvertisingCampaignWeekdayEnum] to String,
/// and [decode] dynamic data back to [AdvertisingCampaignWeekdayEnum].
class AdvertisingCampaignWeekdayEnumTypeTransformer {
  const AdvertisingCampaignWeekdayEnumTypeTransformer._();

  factory AdvertisingCampaignWeekdayEnumTypeTransformer() => _instance ??= AdvertisingCampaignWeekdayEnumTypeTransformer._();

  String encode(AdvertisingCampaignWeekdayEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a AdvertisingCampaignWeekdayEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AdvertisingCampaignWeekdayEnum decode(dynamic data, {bool allowNull}) {
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
        if (allowNull == false) {
          throw ArgumentError('Unknown enum value to decode: $data');
        }
    }
    return null;
  }

  /// Singleton [AdvertisingCampaignWeekdayEnumTypeTransformer] instance.
  static AdvertisingCampaignWeekdayEnumTypeTransformer _instance;
}
