//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ResponseStationButtonButtons {
  /// Returns a new [ResponseStationButtonButtons] instance.
  ResponseStationButtonButtons({
    this.buttonID,
    this.programID,
  });

  int buttonID;

  int programID;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ResponseStationButtonButtons && other.buttonID == buttonID && other.programID == programID;

  @override
  int get hashCode => (buttonID == null ? 0 : buttonID.hashCode) + (programID == null ? 0 : programID.hashCode);

  @override
  String toString() => 'ResponseStationButtonButtons[buttonID=$buttonID, programID=$programID]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (buttonID != null) {
      json[r'buttonID'] = buttonID;
    }
    if (programID != null) {
      json[r'programID'] = programID;
    }
    return json;
  }

  /// Returns a new [ResponseStationButtonButtons] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ResponseStationButtonButtons fromJson(Map<String, dynamic> json) => json == null
      ? null
      : ResponseStationButtonButtons(
          buttonID: json[r'buttonID'],
          programID: json[r'programID'],
        );

  static List<ResponseStationButtonButtons> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <ResponseStationButtonButtons>[]
          : json.map((dynamic value) => ResponseStationButtonButtons.fromJson(value)).toList(growable: true == growable);

  static Map<String, ResponseStationButtonButtons> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ResponseStationButtonButtons>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ResponseStationButtonButtons.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ResponseStationButtonButtons-objects as value to a dart map
  static Map<String, List<ResponseStationButtonButtons>> mapListFromJson(
    Map<String, dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<ResponseStationButtonButtons>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ResponseStationButtonButtons.listFromJson(
          value,
          emptyIsNull: emptyIsNull,
          growable: growable,
        );
      });
    }
    return map;
  }
}
