//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgStation {
  /// Returns a new [ArgStation] instance.
  ArgStation({
    @required this.id,
  });

  int id;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgStation && other.id == id;

  @override
  int get hashCode => (id == null ? 0 : id.hashCode);

  @override
  String toString() => 'ArgStation[id=$id]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'id'] = id;
    return json;
  }

  /// Returns a new [ArgStation] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgStation fromJson(Map<String, dynamic> json) => json == null
      ? null
      : ArgStation(
          id: json[r'id'],
        );

  static List<ArgStation> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <ArgStation>[]
          : json.map((dynamic value) => ArgStation.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgStation> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgStation>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgStation.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgStation-objects as value to a dart map
  static Map<String, List<ArgStation>> mapListFromJson(
    Map<String, dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<ArgStation>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgStation.listFromJson(
          value,
          emptyIsNull: emptyIsNull,
          growable: growable,
        );
      });
    }
    return map;
  }
}