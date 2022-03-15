//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgPressButton {
  /// Returns a new [ArgPressButton] instance.
  ArgPressButton({
    @required this.hash,
    @required this.buttonID,
  });

  String hash;

  int buttonID;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgPressButton &&
     other.hash == hash &&
     other.buttonID == buttonID;

  @override
  int get hashCode =>
    (hash == null ? 0 : hash.hashCode) +
    (buttonID == null ? 0 : buttonID.hashCode);

  @override
  String toString() => 'ArgPressButton[hash=$hash, buttonID=$buttonID]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'hash'] = hash;
      json[r'buttonID'] = buttonID;
    return json;
  }

  /// Returns a new [ArgPressButton] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgPressButton fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ArgPressButton(
        hash: json[r'hash'],
        buttonID: json[r'buttonID'],
    );

  static List<ArgPressButton> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ArgPressButton>[]
      : json.map((dynamic value) => ArgPressButton.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgPressButton> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgPressButton>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgPressButton.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgPressButton-objects as value to a dart map
  static Map<String, List<ArgPressButton>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ArgPressButton>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgPressButton.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

