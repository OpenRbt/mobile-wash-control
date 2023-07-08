//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DeleteUser409Response {
  /// Returns a new [DeleteUser409Response] instance.
  DeleteUser409Response({
    required this.code,
    required this.message,
  });

  int code;

  String message;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DeleteUser409Response &&
     other.code == code &&
     other.message == message;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (code.hashCode) +
    (message.hashCode);

  @override
  String toString() => 'DeleteUser409Response[code=$code, message=$message]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'code'] = this.code;
      json[r'message'] = this.message;
    return json;
  }

  /// Returns a new [DeleteUser409Response] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DeleteUser409Response? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DeleteUser409Response[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DeleteUser409Response[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DeleteUser409Response(
        code: mapValueOfType<int>(json, r'code')!,
        message: mapValueOfType<String>(json, r'message')!,
      );
    }
    return null;
  }

  static List<DeleteUser409Response>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DeleteUser409Response>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DeleteUser409Response.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DeleteUser409Response> mapFromJson(dynamic json) {
    final map = <String, DeleteUser409Response>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DeleteUser409Response.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DeleteUser409Response-objects as value to a dart map
  static Map<String, List<DeleteUser409Response>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DeleteUser409Response>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DeleteUser409Response.listFromJson(entry.value, growable: growable,);
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

