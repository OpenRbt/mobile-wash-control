//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SessionRefresh {
  /// Returns a new [SessionRefresh] instance.
  SessionRefresh({
    this.userID,
    this.receiveAmount,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? userID;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? receiveAmount;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SessionRefresh &&
     other.userID == userID &&
     other.receiveAmount == receiveAmount;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (userID == null ? 0 : userID!.hashCode) +
    (receiveAmount == null ? 0 : receiveAmount!.hashCode);

  @override
  String toString() => 'SessionRefresh[userID=$userID, receiveAmount=$receiveAmount]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.userID != null) {
      json[r'userID'] = this.userID;
    } else {
      json[r'userID'] = null;
    }
    if (this.receiveAmount != null) {
      json[r'receiveAmount'] = this.receiveAmount;
    } else {
      json[r'receiveAmount'] = null;
    }
    return json;
  }

  /// Returns a new [SessionRefresh] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SessionRefresh? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SessionRefresh[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SessionRefresh[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SessionRefresh(
        userID: mapValueOfType<String>(json, r'userID'),
        receiveAmount: mapValueOfType<int>(json, r'receiveAmount'),
      );
    }
    return null;
  }

  static List<SessionRefresh>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SessionRefresh>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SessionRefresh.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SessionRefresh> mapFromJson(dynamic json) {
    final map = <String, SessionRefresh>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SessionRefresh.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SessionRefresh-objects as value to a dart map
  static Map<String, List<SessionRefresh>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SessionRefresh>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SessionRefresh.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

