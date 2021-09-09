//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgAdvertisingCampaignByID {
  /// Returns a new [ArgAdvertisingCampaignByID] instance.
  ArgAdvertisingCampaignByID({
    @required this.id,
  });

  int id;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgAdvertisingCampaignByID && other.id == id;

  @override
  int get hashCode => (id == null ? 0 : id.hashCode);

  @override
  String toString() => 'ArgAdvertisingCampaignByID[id=$id]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'id'] = id;
    return json;
  }

  /// Returns a new [ArgAdvertisingCampaignByID] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgAdvertisingCampaignByID fromJson(Map<String, dynamic> json) => json == null
      ? null
      : ArgAdvertisingCampaignByID(
          id: json[r'id'],
        );

  static List<ArgAdvertisingCampaignByID> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <ArgAdvertisingCampaignByID>[]
          : json.map((dynamic value) => ArgAdvertisingCampaignByID.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgAdvertisingCampaignByID> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgAdvertisingCampaignByID>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgAdvertisingCampaignByID.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgAdvertisingCampaignByID-objects as value to a dart map
  static Map<String, List<ArgAdvertisingCampaignByID>> mapListFromJson(
    Map<String, dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<ArgAdvertisingCampaignByID>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgAdvertisingCampaignByID.listFromJson(
          value,
          emptyIsNull: emptyIsNull,
          growable: growable,
        );
      });
    }
    return map;
  }
}
