//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ButtonDiscount {
  /// Returns a new [ButtonDiscount] instance.
  ButtonDiscount({
    this.buttonID,
    this.discount,
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
  int? discount;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ButtonDiscount &&
     other.buttonID == buttonID &&
     other.discount == discount;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (buttonID == null ? 0 : buttonID!.hashCode) +
    (discount == null ? 0 : discount!.hashCode);

  @override
  String toString() => 'ButtonDiscount[buttonID=$buttonID, discount=$discount]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.buttonID != null) {
      json[r'buttonID'] = this.buttonID;
    } else {
      json[r'buttonID'] = null;
    }
    if (this.discount != null) {
      json[r'discount'] = this.discount;
    } else {
      json[r'discount'] = null;
    }
    return json;
  }

  /// Returns a new [ButtonDiscount] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ButtonDiscount? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ButtonDiscount[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ButtonDiscount[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ButtonDiscount(
        buttonID: mapValueOfType<int>(json, r'buttonID'),
        discount: mapValueOfType<int>(json, r'discount'),
      );
    }
    return null;
  }

  static List<ButtonDiscount>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ButtonDiscount>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ButtonDiscount.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ButtonDiscount> mapFromJson(dynamic json) {
    final map = <String, ButtonDiscount>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ButtonDiscount.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ButtonDiscount-objects as value to a dart map
  static Map<String, List<ButtonDiscount>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ButtonDiscount>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ButtonDiscount.listFromJson(entry.value, growable: growable,);
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

