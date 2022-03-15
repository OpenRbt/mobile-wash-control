//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgSetStationButton {
  /// Returns a new [ArgSetStationButton] instance.
  ArgSetStationButton({
    @required this.stationID,
    this.buttons = const [],
  });

  // minimum: 1
  int stationID;

  List<ResponseStationButtonButtons> buttons;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgSetStationButton &&
     other.stationID == stationID &&
     other.buttons == buttons;

  @override
  int get hashCode =>
    (stationID == null ? 0 : stationID.hashCode) +
    (buttons == null ? 0 : buttons.hashCode);

  @override
  String toString() => 'ArgSetStationButton[stationID=$stationID, buttons=$buttons]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'stationID'] = stationID;
    if (buttons != null) {
      json[r'buttons'] = buttons;
    }
    return json;
  }

  /// Returns a new [ArgSetStationButton] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgSetStationButton fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ArgSetStationButton(
        stationID: json[r'stationID'],
        buttons: ResponseStationButtonButtons.listFromJson(json[r'buttons']),
    );

  static List<ArgSetStationButton> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ArgSetStationButton>[]
      : json.map((dynamic value) => ArgSetStationButton.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgSetStationButton> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgSetStationButton>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgSetStationButton.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgSetStationButton-objects as value to a dart map
  static Map<String, List<ArgSetStationButton>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ArgSetStationButton>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgSetStationButton.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

