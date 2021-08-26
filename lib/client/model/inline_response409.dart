//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class InlineResponse409 {
  /// Returns a new [InlineResponse409] instance.
  InlineResponse409({
    @required this.code,
    @required this.message,
  });

  int code;

  String message;

  @override
  bool operator ==(Object other) => identical(this, other) || other is InlineResponse409 && other.code == code && other.message == message;

  @override
  int get hashCode => (code == null ? 0 : code.hashCode) + (message == null ? 0 : message.hashCode);

  @override
  String toString() => 'InlineResponse409[code=$code, message=$message]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'code'] = code;
    json[r'message'] = message;
    return json;
  }

  /// Returns a new [InlineResponse409] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static InlineResponse409 fromJson(Map<String, dynamic> json) => json == null
      ? null
      : InlineResponse409(
          code: json[r'code'],
          message: json[r'message'],
        );

  static List<InlineResponse409> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <InlineResponse409>[]
          : json.map((dynamic value) => InlineResponse409.fromJson(value)).toList(growable: true == growable);

  static Map<String, InlineResponse409> mapFromJson(Map<String, dynamic> json) {
    final map = <String, InlineResponse409>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = InlineResponse409.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of InlineResponse409-objects as value to a dart map
  static Map<String, List<InlineResponse409>> mapListFromJson(
    Map<String, dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<InlineResponse409>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = InlineResponse409.listFromJson(
          value,
          emptyIsNull: emptyIsNull,
          growable: growable,
        );
      });
    }
    return map;
  }
}
