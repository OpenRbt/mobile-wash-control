//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ResponseStationButtonButtonsInner {
  /// Returns a new [ResponseStationButtonButtonsInner] instance.
  ResponseStationButtonButtonsInner({
    this.buttonID,
    this.programID,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? buttonID;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? programID;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ResponseStationButtonButtonsInner &&
     other.buttonID == buttonID &&
     other.programID == programID;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (buttonID == null ? 0 : buttonID!.hashCode) +
    (programID == null ? 0 : programID!.hashCode);

  @override
  String toString() => 'ResponseStationButtonButtonsInner[buttonID=$buttonID, programID=$programID]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.buttonID != null) {
      json[r'buttonID'] = this.buttonID;
    } else {
      json[r'buttonID'] = null;
    }
    if (this.programID != null) {
      json[r'programID'] = this.programID;
    } else {
      json[r'programID'] = null;
    }
    return json;
  }

  /// Returns a new [ResponseStationButtonButtonsInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ResponseStationButtonButtonsInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ResponseStationButtonButtonsInner[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ResponseStationButtonButtonsInner[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ResponseStationButtonButtonsInner(
        buttonID: mapValueOfType<int>(json, r'buttonID'),
        programID: mapValueOfType<int>(json, r'programID'),
      );
    }
    return null;
  }

  static List<ResponseStationButtonButtonsInner>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ResponseStationButtonButtonsInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ResponseStationButtonButtonsInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ResponseStationButtonButtonsInner> mapFromJson(dynamic json) {
    final map = <String, ResponseStationButtonButtonsInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ResponseStationButtonButtonsInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ResponseStationButtonButtonsInner-objects as value to a dart map
  static Map<String, List<ResponseStationButtonButtonsInner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ResponseStationButtonButtonsInner>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ResponseStationButtonButtonsInner.listFromJson(entry.value, growable: growable,);
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

