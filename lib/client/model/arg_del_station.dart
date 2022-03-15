//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgDelStation {
  /// Returns a new [ArgDelStation] instance.
  ArgDelStation({
    @required this.id,
  });

  int id;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgDelStation &&
     other.id == id;

  @override
  int get hashCode =>
    (id == null ? 0 : id.hashCode);

  @override
  String toString() => 'ArgDelStation[id=$id]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = id;
    return json;
  }

  /// Returns a new [ArgDelStation] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgDelStation fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ArgDelStation(
        id: json[r'id'],
    );

  static List<ArgDelStation> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ArgDelStation>[]
      : json.map((dynamic value) => ArgDelStation.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgDelStation> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgDelStation>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgDelStation.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgDelStation-objects as value to a dart map
  static Map<String, List<ArgDelStation>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ArgDelStation>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgDelStation.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

