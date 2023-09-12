//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Notification {
  /// Returns a new [Notification] instance.
  Notification({
    this.terminalKey,
    this.orderId,
    this.success,
    this.status,
    this.paymentId,
    this.errorCode,
    this.amount,
    this.cardId,
    this.pan,
    this.expDate,
    this.token,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? terminalKey;

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
  bool? success;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? status;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? paymentId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? errorCode;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? amount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? cardId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? pan;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? expDate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? token;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Notification &&
     other.terminalKey == terminalKey &&
     other.orderId == orderId &&
     other.success == success &&
     other.status == status &&
     other.paymentId == paymentId &&
     other.errorCode == errorCode &&
     other.amount == amount &&
     other.cardId == cardId &&
     other.pan == pan &&
     other.expDate == expDate &&
     other.token == token;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (terminalKey == null ? 0 : terminalKey!.hashCode) +
    (orderId == null ? 0 : orderId!.hashCode) +
    (success == null ? 0 : success!.hashCode) +
    (status == null ? 0 : status!.hashCode) +
    (paymentId == null ? 0 : paymentId!.hashCode) +
    (errorCode == null ? 0 : errorCode!.hashCode) +
    (amount == null ? 0 : amount!.hashCode) +
    (cardId == null ? 0 : cardId!.hashCode) +
    (pan == null ? 0 : pan!.hashCode) +
    (expDate == null ? 0 : expDate!.hashCode) +
    (token == null ? 0 : token!.hashCode);

  @override
  String toString() => 'Notification[terminalKey=$terminalKey, orderId=$orderId, success=$success, status=$status, paymentId=$paymentId, errorCode=$errorCode, amount=$amount, cardId=$cardId, pan=$pan, expDate=$expDate, token=$token]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.terminalKey != null) {
      json[r'TerminalKey'] = this.terminalKey;
    } else {
      json[r'TerminalKey'] = null;
    }
    if (this.orderId != null) {
      json[r'OrderId'] = this.orderId;
    } else {
      json[r'OrderId'] = null;
    }
    if (this.success != null) {
      json[r'Success'] = this.success;
    } else {
      json[r'Success'] = null;
    }
    if (this.status != null) {
      json[r'Status'] = this.status;
    } else {
      json[r'Status'] = null;
    }
    if (this.paymentId != null) {
      json[r'PaymentId'] = this.paymentId;
    } else {
      json[r'PaymentId'] = null;
    }
    if (this.errorCode != null) {
      json[r'ErrorCode'] = this.errorCode;
    } else {
      json[r'ErrorCode'] = null;
    }
    if (this.amount != null) {
      json[r'Amount'] = this.amount;
    } else {
      json[r'Amount'] = null;
    }
    if (this.cardId != null) {
      json[r'CardId'] = this.cardId;
    } else {
      json[r'CardId'] = null;
    }
    if (this.pan != null) {
      json[r'Pan'] = this.pan;
    } else {
      json[r'Pan'] = null;
    }
    if (this.expDate != null) {
      json[r'ExpDate'] = this.expDate;
    } else {
      json[r'ExpDate'] = null;
    }
    if (this.token != null) {
      json[r'Token'] = this.token;
    } else {
      json[r'Token'] = null;
    }
    return json;
  }

  /// Returns a new [Notification] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Notification? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Notification[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Notification[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Notification(
        terminalKey: mapValueOfType<String>(json, r'TerminalKey'),
        orderId: mapValueOfType<String>(json, r'OrderId'),
        success: mapValueOfType<bool>(json, r'Success'),
        status: mapValueOfType<String>(json, r'Status'),
        paymentId: mapValueOfType<int>(json, r'PaymentId'),
        errorCode: mapValueOfType<String>(json, r'ErrorCode'),
        amount: mapValueOfType<int>(json, r'Amount'),
        cardId: mapValueOfType<int>(json, r'CardId'),
        pan: mapValueOfType<String>(json, r'Pan'),
        expDate: mapValueOfType<String>(json, r'ExpDate'),
        token: mapValueOfType<String>(json, r'Token'),
      );
    }
    return null;
  }

  static List<Notification>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Notification>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Notification.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Notification> mapFromJson(dynamic json) {
    final map = <String, Notification>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Notification.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Notification-objects as value to a dart map
  static Map<String, List<Notification>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Notification>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Notification.listFromJson(entry.value, growable: growable,);
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

