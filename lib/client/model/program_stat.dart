//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProgramStat {
  /// Returns a new [ProgramStat] instance.
  ProgramStat({
    this.programID,
    this.programName,
    this.timeOn,
  });

  int programID;

  String programName;

  int timeOn;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProgramStat &&
     other.programID == programID &&
     other.programName == programName &&
     other.timeOn == timeOn;

  @override
  int get hashCode =>
    (programID == null ? 0 : programID.hashCode) +
    (programName == null ? 0 : programName.hashCode) +
    (timeOn == null ? 0 : timeOn.hashCode);

  @override
  String toString() => 'ProgramStat[programID=$programID, programName=$programName, timeOn=$timeOn]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (programID != null) {
      json[r'programID'] = programID;
    }
    if (programName != null) {
      json[r'programName'] = programName;
    }
    if (timeOn != null) {
      json[r'timeOn'] = timeOn;
    }
    return json;
  }

  /// Returns a new [ProgramStat] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ProgramStat fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ProgramStat(
        programID: json[r'programID'],
        programName: json[r'programName'],
        timeOn: json[r'timeOn'],
    );

  static List<ProgramStat> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ProgramStat>[]
      : json.map((dynamic value) => ProgramStat.fromJson(value)).toList(growable: true == growable);

  static Map<String, ProgramStat> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ProgramStat>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ProgramStat.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ProgramStat-objects as value to a dart map
  static Map<String, List<ProgramStat>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ProgramStat>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ProgramStat.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

