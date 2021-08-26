//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RelayConfig {
  /// Returns a new [RelayConfig] instance.
  RelayConfig({
    this.id,
    this.timeon,
    this.timeoff,
  });

  // minimum: 1
  int id;

  int timeon;

  int timeoff;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RelayConfig && other.id == id && other.timeon == timeon && other.timeoff == timeoff;

  @override
  int get hashCode => (id == null ? 0 : id.hashCode) + (timeon == null ? 0 : timeon.hashCode) + (timeoff == null ? 0 : timeoff.hashCode);

  @override
  String toString() => 'RelayConfig[id=$id, timeon=$timeon, timeoff=$timeoff]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (id != null) {
      json[r'id'] = id;
    }
    if (timeon != null) {
      json[r'timeon'] = timeon;
    }
    if (timeoff != null) {
      json[r'timeoff'] = timeoff;
    }
    return json;
  }

  /// Returns a new [RelayConfig] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static RelayConfig fromJson(Map<String, dynamic> json) => json == null
      ? null
      : RelayConfig(
          id: json[r'id'],
          timeon: json[r'timeon'],
          timeoff: json[r'timeoff'],
        );

  static List<RelayConfig> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <RelayConfig>[]
          : json.map((dynamic value) => RelayConfig.fromJson(value)).toList(growable: true == growable);

  static Map<String, RelayConfig> mapFromJson(Map<String, dynamic> json) {
    final map = <String, RelayConfig>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = RelayConfig.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of RelayConfig-objects as value to a dart map
  static Map<String, List<RelayConfig>> mapListFromJson(
    Map<String, dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<RelayConfig>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = RelayConfig.listFromJson(
          value,
          emptyIsNull: emptyIsNull,
          growable: growable,
        );
      });
    }
    return map;
  }
}
