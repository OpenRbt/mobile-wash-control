//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgStationButton {
  /// Returns a new [ArgStationButton] instance.
  ArgStationButton({
    @required this.stationID,
  });

  // minimum: 1
  int stationID;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgStationButton &&
     other.stationID == stationID;

  @override
  int get hashCode =>
    (stationID == null ? 0 : stationID.hashCode);

  @override
  String toString() => 'ArgStationButton[stationID=$stationID]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'stationID'] = stationID;
    return json;
  }

  /// Returns a new [ArgStationButton] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgStationButton fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ArgStationButton(
        stationID: json[r'stationID'],
    );

  static List<ArgStationButton> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ArgStationButton>[]
      : json.map((dynamic value) => ArgStationButton.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgStationButton> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgStationButton>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgStationButton.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgStationButton-objects as value to a dart map
  static Map<String, List<ArgStationButton>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ArgStationButton>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgStationButton.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

