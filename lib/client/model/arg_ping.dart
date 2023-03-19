//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgPing {
  /// Returns a new [ArgPing] instance.
  ArgPing({
    @required this.hash,
    this.currentBalance,
    this.currentProgram,
  });

  String hash;

  int currentBalance;

  int currentProgram;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgPing &&
     other.hash == hash &&
     other.currentBalance == currentBalance &&
     other.currentProgram == currentProgram;

  @override
  int get hashCode =>
    (hash == null ? 0 : hash.hashCode) +
    (currentBalance == null ? 0 : currentBalance.hashCode) +
    (currentProgram == null ? 0 : currentProgram.hashCode);

  @override
  String toString() => 'ArgPing[hash=$hash, currentBalance=$currentBalance, currentProgram=$currentProgram]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'hash'] = hash;
    if (currentBalance != null) {
      json[r'currentBalance'] = currentBalance;
    }
    if (currentProgram != null) {
      json[r'currentProgram'] = currentProgram;
    }
    return json;
  }

  /// Returns a new [ArgPing] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgPing fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ArgPing(
        hash: json[r'hash'],
        currentBalance: json[r'currentBalance'],
        currentProgram: json[r'currentProgram'],
    );

  static List<ArgPing> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ArgPing>[]
      : json.map((dynamic value) => ArgPing.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgPing> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgPing>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgPing.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgPing-objects as value to a dart map
  static Map<String, List<ArgPing>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ArgPing>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgPing.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

