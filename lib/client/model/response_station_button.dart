//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ResponseStationButton {
  /// Returns a new [ResponseStationButton] instance.
  ResponseStationButton({
    this.buttons = const [],
  });

  List<ResponseStationButtonButtons> buttons;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ResponseStationButton &&
     other.buttons == buttons;

  @override
  int get hashCode =>
    (buttons == null ? 0 : buttons.hashCode);

  @override
  String toString() => 'ResponseStationButton[buttons=$buttons]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (buttons != null) {
      json[r'buttons'] = buttons;
    }
    return json;
  }

  /// Returns a new [ResponseStationButton] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ResponseStationButton fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ResponseStationButton(
        buttons: ResponseStationButtonButtons.listFromJson(json[r'buttons']),
    );

  static List<ResponseStationButton> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ResponseStationButton>[]
      : json.map((dynamic value) => ResponseStationButton.fromJson(value)).toList(growable: true == growable);

  static Map<String, ResponseStationButton> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ResponseStationButton>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ResponseStationButton.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ResponseStationButton-objects as value to a dart map
  static Map<String, List<ResponseStationButton>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ResponseStationButton>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ResponseStationButton.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

