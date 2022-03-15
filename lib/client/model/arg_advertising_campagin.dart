//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgAdvertisingCampagin {
  /// Returns a new [ArgAdvertisingCampagin] instance.
  ArgAdvertisingCampagin({
    this.startDate,
    this.endDate,
  });

  /// Unix time local
  int startDate;

  /// Unix time local
  int endDate;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgAdvertisingCampagin &&
     other.startDate == startDate &&
     other.endDate == endDate;

  @override
  int get hashCode =>
    (startDate == null ? 0 : startDate.hashCode) +
    (endDate == null ? 0 : endDate.hashCode);

  @override
  String toString() => 'ArgAdvertisingCampagin[startDate=$startDate, endDate=$endDate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (startDate != null) {
      json[r'startDate'] = startDate;
    }
    if (endDate != null) {
      json[r'endDate'] = endDate;
    }
    return json;
  }

  /// Returns a new [ArgAdvertisingCampagin] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgAdvertisingCampagin fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ArgAdvertisingCampagin(
        startDate: json[r'startDate'],
        endDate: json[r'endDate'],
    );

  static List<ArgAdvertisingCampagin> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ArgAdvertisingCampagin>[]
      : json.map((dynamic value) => ArgAdvertisingCampagin.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgAdvertisingCampagin> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgAdvertisingCampagin>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgAdvertisingCampagin.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgAdvertisingCampagin-objects as value to a dart map
  static Map<String, List<ArgAdvertisingCampagin>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ArgAdvertisingCampagin>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgAdvertisingCampagin.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

