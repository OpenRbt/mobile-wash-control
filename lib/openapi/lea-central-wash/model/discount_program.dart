//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DiscountProgram {
  /// Returns a new [DiscountProgram] instance.
  DiscountProgram({
    this.programID,
    this.discount,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? programID;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? discount;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DiscountProgram &&
     other.programID == programID &&
     other.discount == discount;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (programID == null ? 0 : programID!.hashCode) +
    (discount == null ? 0 : discount!.hashCode);

  @override
  String toString() => 'DiscountProgram[programID=$programID, discount=$discount]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.programID != null) {
      json[r'programID'] = this.programID;
    } else {
      json[r'programID'] = null;
    }
    if (this.discount != null) {
      json[r'discount'] = this.discount;
    } else {
      json[r'discount'] = null;
    }
    return json;
  }

  /// Returns a new [DiscountProgram] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DiscountProgram? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DiscountProgram[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DiscountProgram[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DiscountProgram(
        programID: mapValueOfType<int>(json, r'programID'),
        discount: mapValueOfType<int>(json, r'discount'),
      );
    }
    return null;
  }

  static List<DiscountProgram>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DiscountProgram>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DiscountProgram.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DiscountProgram> mapFromJson(dynamic json) {
    final map = <String, DiscountProgram>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DiscountProgram.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DiscountProgram-objects as value to a dart map
  static Map<String, List<DiscountProgram>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DiscountProgram>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DiscountProgram.listFromJson(entry.value, growable: growable,);
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

