//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgOpenStation {
  /// Returns a new [ArgOpenStation] instance.
  ArgOpenStation({
    @required this.stationID,
  });

  int stationID;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgOpenStation && other.stationID == stationID;

  @override
  int get hashCode => (stationID == null ? 0 : stationID.hashCode);

  @override
  String toString() => 'ArgOpenStation[stationID=$stationID]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'stationID'] = stationID;
    return json;
  }

  /// Returns a new [ArgOpenStation] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgOpenStation fromJson(Map<String, dynamic> json) => json == null
      ? null
      : ArgOpenStation(
          stationID: json[r'stationID'],
        );

  static List<ArgOpenStation> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <ArgOpenStation>[]
          : json.map((dynamic value) => ArgOpenStation.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgOpenStation> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgOpenStation>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgOpenStation.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgOpenStation-objects as value to a dart map
  static Map<String, List<ArgOpenStation>> mapListFromJson(
    Map<String, dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<ArgOpenStation>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgOpenStation.listFromJson(
          value,
          emptyIsNull: emptyIsNull,
          growable: growable,
        );
      });
    }
    return map;
  }
}
