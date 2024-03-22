//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PaymentCancellation {
  /// Returns a new [PaymentCancellation] instance.
  PaymentCancellation({
    this.washID,
    this.postID,
    this.orderID,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? washID;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? postID;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? orderID;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PaymentCancellation &&
     other.washID == washID &&
     other.postID == postID &&
     other.orderID == orderID;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (washID == null ? 0 : washID!.hashCode) +
    (postID == null ? 0 : postID!.hashCode) +
    (orderID == null ? 0 : orderID!.hashCode);

  @override
  String toString() => 'PaymentCancellation[washID=$washID, postID=$postID, orderID=$orderID]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.washID != null) {
      json[r'washID'] = this.washID;
    } else {
      json[r'washID'] = null;
    }
    if (this.postID != null) {
      json[r'postID'] = this.postID;
    } else {
      json[r'postID'] = null;
    }
    if (this.orderID != null) {
      json[r'orderID'] = this.orderID;
    } else {
      json[r'orderID'] = null;
    }
    return json;
  }

  /// Returns a new [PaymentCancellation] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PaymentCancellation? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PaymentCancellation[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PaymentCancellation[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PaymentCancellation(
        washID: mapValueOfType<String>(json, r'washID'),
        postID: mapValueOfType<String>(json, r'postID'),
        orderID: mapValueOfType<String>(json, r'orderID'),
      );
    }
    return null;
  }

  static List<PaymentCancellation>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PaymentCancellation>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PaymentCancellation.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PaymentCancellation> mapFromJson(dynamic json) {
    final map = <String, PaymentCancellation>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PaymentCancellation.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PaymentCancellation-objects as value to a dart map
  static Map<String, List<PaymentCancellation>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PaymentCancellation>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PaymentCancellation.listFromJson(entry.value, growable: growable,);
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

