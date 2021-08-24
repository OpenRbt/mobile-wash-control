//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgPrograms {
  /// Returns a new [ArgPrograms] instance.
  ArgPrograms({
    this.programID,
  });

  // minimum: 1
  int programID;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgPrograms && other.programID == programID;

  @override
  int get hashCode => (programID == null ? 0 : programID.hashCode);

  @override
  String toString() => 'ArgPrograms[programID=$programID]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (programID != null) {
      json[r'programID'] = programID;
    }
    return json;
  }

  /// Returns a new [ArgPrograms] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgPrograms fromJson(Map<String, dynamic> json) => json == null
      ? null
      : ArgPrograms(
          programID: json[r'programID'],
        );

  static List<ArgPrograms> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <ArgPrograms>[]
          : json.map((dynamic value) => ArgPrograms.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgPrograms> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgPrograms>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgPrograms.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgPrograms-objects as value to a dart map
  static Map<String, List<ArgPrograms>> mapListFromJson(
    Map<String, dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<ArgPrograms>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgPrograms.listFromJson(
          value,
          emptyIsNull: emptyIsNull,
          growable: growable,
        );
      });
    }
    return map;
  }
}
