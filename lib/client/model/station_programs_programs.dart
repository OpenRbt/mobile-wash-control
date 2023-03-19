//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StationProgramsPrograms {
  /// Returns a new [StationProgramsPrograms] instance.
  StationProgramsPrograms({
    this.buttonID,
    this.program,
  });

  int buttonID;

  Program program;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StationProgramsPrograms &&
     other.buttonID == buttonID &&
     other.program == program;

  @override
  int get hashCode =>
    (buttonID == null ? 0 : buttonID.hashCode) +
    (program == null ? 0 : program.hashCode);

  @override
  String toString() => 'StationProgramsPrograms[buttonID=$buttonID, program=$program]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (buttonID != null) {
      json[r'buttonID'] = buttonID;
    }
    if (program != null) {
      json[r'program'] = program;
    }
    return json;
  }

  /// Returns a new [StationProgramsPrograms] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static StationProgramsPrograms fromJson(Map<String, dynamic> json) => json == null
    ? null
    : StationProgramsPrograms(
        buttonID: json[r'buttonID'],
        program: Program.fromJson(json[r'program']),
    );

  static List<StationProgramsPrograms> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <StationProgramsPrograms>[]
      : json.map((dynamic value) => StationProgramsPrograms.fromJson(value)).toList(growable: true == growable);

  static Map<String, StationProgramsPrograms> mapFromJson(Map<String, dynamic> json) {
    final map = <String, StationProgramsPrograms>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = StationProgramsPrograms.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of StationProgramsPrograms-objects as value to a dart map
  static Map<String, List<StationProgramsPrograms>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<StationProgramsPrograms>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = StationProgramsPrograms.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

