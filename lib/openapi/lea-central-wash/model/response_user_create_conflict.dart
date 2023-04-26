//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ResponseUserCreateConflict {
  /// Returns a new [ResponseUserCreateConflict] instance.
  ResponseUserCreateConflict({
    required this.code,
    required this.message,
  });

  int code;

  String message;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ResponseUserCreateConflict &&
     other.code == code &&
     other.message == message;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (code.hashCode) +
    (message.hashCode);

  @override
  String toString() => 'ResponseUserCreateConflict[code=$code, message=$message]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'code'] = this.code;
      json[r'message'] = this.message;
    return json;
  }

  /// Returns a new [ResponseUserCreateConflict] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ResponseUserCreateConflict? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ResponseUserCreateConflict[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ResponseUserCreateConflict[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ResponseUserCreateConflict(
        code: mapValueOfType<int>(json, r'code')!,
        message: mapValueOfType<String>(json, r'message')!,
      );
    }
    return null;
  }

  static List<ResponseUserCreateConflict>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ResponseUserCreateConflict>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ResponseUserCreateConflict.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ResponseUserCreateConflict> mapFromJson(dynamic json) {
    final map = <String, ResponseUserCreateConflict>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ResponseUserCreateConflict.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ResponseUserCreateConflict-objects as value to a dart map
  static Map<String, List<ResponseUserCreateConflict>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ResponseUserCreateConflict>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ResponseUserCreateConflict.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'code',
    'message',
  };
}

