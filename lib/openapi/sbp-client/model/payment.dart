//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Payment {
  /// Returns a new [Payment] instance.
  Payment({
    this.washId,
    this.postId,
    this.orderId,
    this.amount,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? washId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? postId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? orderId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? amount;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Payment &&
     other.washId == washId &&
     other.postId == postId &&
     other.orderId == orderId &&
     other.amount == amount;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (washId == null ? 0 : washId!.hashCode) +
    (postId == null ? 0 : postId!.hashCode) +
    (orderId == null ? 0 : orderId!.hashCode) +
    (amount == null ? 0 : amount!.hashCode);

  @override
  String toString() => 'Payment[washId=$washId, postId=$postId, orderId=$orderId, amount=$amount]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.washId != null) {
      json[r'washId'] = this.washId;
    } else {
      json[r'washId'] = null;
    }
    if (this.postId != null) {
      json[r'postId'] = this.postId;
    } else {
      json[r'postId'] = null;
    }
    if (this.orderId != null) {
      json[r'orderId'] = this.orderId;
    } else {
      json[r'orderId'] = null;
    }
    if (this.amount != null) {
      json[r'amount'] = this.amount;
    } else {
      json[r'amount'] = null;
    }
    return json;
  }

  /// Returns a new [Payment] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Payment? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Payment[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Payment[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Payment(
        washId: mapValueOfType<String>(json, r'washId'),
        postId: mapValueOfType<String>(json, r'postId'),
        orderId: mapValueOfType<String>(json, r'orderId'),
        amount: mapValueOfType<int>(json, r'amount'),
      );
    }
    return null;
  }

  static List<Payment>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Payment>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Payment.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Payment> mapFromJson(dynamic json) {
    final map = <String, Payment>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Payment.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Payment-objects as value to a dart map
  static Map<String, List<Payment>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Payment>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Payment.listFromJson(entry.value, growable: growable,);
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

