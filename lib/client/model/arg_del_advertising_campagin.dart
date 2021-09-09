//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgDelAdvertisingCampagin {
  /// Returns a new [ArgDelAdvertisingCampagin] instance.
  ArgDelAdvertisingCampagin({
    @required this.id,
  });

  int id;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgDelAdvertisingCampagin && other.id == id;

  @override
  int get hashCode => (id == null ? 0 : id.hashCode);

  @override
  String toString() => 'ArgDelAdvertisingCampagin[id=$id]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'id'] = id;
    return json;
  }

  /// Returns a new [ArgDelAdvertisingCampagin] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgDelAdvertisingCampagin fromJson(Map<String, dynamic> json) => json == null
      ? null
      : ArgDelAdvertisingCampagin(
          id: json[r'id'],
        );

  static List<ArgDelAdvertisingCampagin> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <ArgDelAdvertisingCampagin>[]
          : json.map((dynamic value) => ArgDelAdvertisingCampagin.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgDelAdvertisingCampagin> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgDelAdvertisingCampagin>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgDelAdvertisingCampagin.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgDelAdvertisingCampagin-objects as value to a dart map
  static Map<String, List<ArgDelAdvertisingCampagin>> mapListFromJson(
    Map<String, dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<ArgDelAdvertisingCampagin>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgDelAdvertisingCampagin.listFromJson(
          value,
          emptyIsNull: emptyIsNull,
          growable: growable,
        );
      });
    }
    return map;
  }
}
