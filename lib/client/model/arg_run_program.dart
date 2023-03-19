//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgRunProgram {
  /// Returns a new [ArgRunProgram] instance.
  ArgRunProgram({
    @required this.hash,
    @required this.programID,
    @required this.preflight,
  });

  String hash;

  int programID;

  bool preflight;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgRunProgram &&
     other.hash == hash &&
     other.programID == programID &&
     other.preflight == preflight;

  @override
  int get hashCode =>
    (hash == null ? 0 : hash.hashCode) +
    (programID == null ? 0 : programID.hashCode) +
    (preflight == null ? 0 : preflight.hashCode);

  @override
  String toString() => 'ArgRunProgram[hash=$hash, programID=$programID, preflight=$preflight]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'hash'] = hash;
      json[r'programID'] = programID;
      json[r'preflight'] = preflight;
    return json;
  }

  /// Returns a new [ArgRunProgram] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgRunProgram fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ArgRunProgram(
        hash: json[r'hash'],
        programID: json[r'programID'],
        preflight: json[r'preflight'],
    );

  static List<ArgRunProgram> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ArgRunProgram>[]
      : json.map((dynamic value) => ArgRunProgram.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgRunProgram> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgRunProgram>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgRunProgram.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgRunProgram-objects as value to a dart map
  static Map<String, List<ArgRunProgram>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ArgRunProgram>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgRunProgram.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

