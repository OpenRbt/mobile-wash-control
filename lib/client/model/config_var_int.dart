//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ConfigVarInt {
  /// Returns a new [ConfigVarInt] instance.
  ConfigVarInt({
    this.name,
    this.value,
    this.description,
    this.note,
  });

  String name;

  int value;

  String description;

  String note;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ConfigVarInt &&
     other.name == name &&
     other.value == value &&
     other.description == description &&
     other.note == note;

  @override
  int get hashCode =>
    (name == null ? 0 : name.hashCode) +
    (value == null ? 0 : value.hashCode) +
    (description == null ? 0 : description.hashCode) +
    (note == null ? 0 : note.hashCode);

  @override
  String toString() => 'ConfigVarInt[name=$name, value=$value, description=$description, note=$note]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (name != null) {
      json[r'name'] = name;
    }
    if (value != null) {
      json[r'value'] = value;
    }
    if (description != null) {
      json[r'description'] = description;
    }
    if (note != null) {
      json[r'note'] = note;
    }
    return json;
  }

  /// Returns a new [ConfigVarInt] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ConfigVarInt fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ConfigVarInt(
        name: json[r'name'],
        value: json[r'value'],
        description: json[r'description'],
        note: json[r'note'],
    );

  static List<ConfigVarInt> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ConfigVarInt>[]
      : json.map((dynamic value) => ConfigVarInt.fromJson(value)).toList(growable: true == growable);

  static Map<String, ConfigVarInt> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ConfigVarInt>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ConfigVarInt.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ConfigVarInt-objects as value to a dart map
  static Map<String, List<ConfigVarInt>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ConfigVarInt>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ConfigVarInt.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

