//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ResponsePing {
  /// Returns a new [ResponsePing] instance.
  ResponsePing({
    required this.serviceAmount,
    required this.kaspiAmount,
    this.sessionID,
    this.bonusAmount,
    this.bonusSystemActive,
    required this.qrMoney,
    required this.qrUrl,
    required this.qrOrderId,
    required this.qrFailed,
    required this.openStation,
    this.lastUpdate,
    this.lastDiscountUpdate,
    this.buttonID,
    this.authorizedSessionID,
    this.sbpSystemActive,
  });

  int serviceAmount;

  int kaspiAmount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? sessionID;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? bonusAmount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? bonusSystemActive;

  int qrMoney;

  String qrUrl;

  String qrOrderId;

  bool qrFailed;

  bool openStation;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? lastUpdate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? lastDiscountUpdate;

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
  String? authorizedSessionID;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? sbpSystemActive;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ResponsePing &&
     other.serviceAmount == serviceAmount &&
     other.kaspiAmount == kaspiAmount &&
     other.sessionID == sessionID &&
     other.bonusAmount == bonusAmount &&
     other.bonusSystemActive == bonusSystemActive &&
     other.qrMoney == qrMoney &&
     other.qrUrl == qrUrl &&
     other.qrOrderId == qrOrderId &&
     other.qrFailed == qrFailed &&
     other.openStation == openStation &&
     other.lastUpdate == lastUpdate &&
     other.lastDiscountUpdate == lastDiscountUpdate &&
     other.buttonID == buttonID &&
     other.authorizedSessionID == authorizedSessionID &&
     other.sbpSystemActive == sbpSystemActive;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (serviceAmount.hashCode) +
    (kaspiAmount.hashCode) +
    (sessionID == null ? 0 : sessionID!.hashCode) +
    (bonusAmount == null ? 0 : bonusAmount!.hashCode) +
    (bonusSystemActive == null ? 0 : bonusSystemActive!.hashCode) +
    (qrMoney.hashCode) +
    (qrUrl.hashCode) +
    (qrOrderId.hashCode) +
    (qrFailed.hashCode) +
    (openStation.hashCode) +
    (lastUpdate == null ? 0 : lastUpdate!.hashCode) +
    (lastDiscountUpdate == null ? 0 : lastDiscountUpdate!.hashCode) +
    (buttonID == null ? 0 : buttonID!.hashCode) +
    (authorizedSessionID == null ? 0 : authorizedSessionID!.hashCode) +
    (sbpSystemActive == null ? 0 : sbpSystemActive!.hashCode);

  @override
  String toString() => 'ResponsePing[serviceAmount=$serviceAmount, kaspiAmount=$kaspiAmount, sessionID=$sessionID, bonusAmount=$bonusAmount, bonusSystemActive=$bonusSystemActive, qrMoney=$qrMoney, qrUrl=$qrUrl, qrOrderId=$qrOrderId, qrFailed=$qrFailed, openStation=$openStation, lastUpdate=$lastUpdate, lastDiscountUpdate=$lastDiscountUpdate, buttonID=$buttonID, authorizedSessionID=$authorizedSessionID, sbpSystemActive=$sbpSystemActive]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'serviceAmount'] = this.serviceAmount;
      json[r'kaspiAmount'] = this.kaspiAmount;
    if (this.sessionID != null) {
      json[r'sessionID'] = this.sessionID;
    } else {
      json[r'sessionID'] = null;
    }
    if (this.bonusAmount != null) {
      json[r'bonusAmount'] = this.bonusAmount;
    } else {
      json[r'bonusAmount'] = null;
    }
    if (this.bonusSystemActive != null) {
      json[r'bonusSystemActive'] = this.bonusSystemActive;
    } else {
      json[r'bonusSystemActive'] = null;
    }
      json[r'qrMoney'] = this.qrMoney;
      json[r'qrUrl'] = this.qrUrl;
      json[r'qrOrderId'] = this.qrOrderId;
      json[r'qrFailed'] = this.qrFailed;
      json[r'openStation'] = this.openStation;
    if (this.lastUpdate != null) {
      json[r'lastUpdate'] = this.lastUpdate;
    } else {
      json[r'lastUpdate'] = null;
    }
    if (this.lastDiscountUpdate != null) {
      json[r'lastDiscountUpdate'] = this.lastDiscountUpdate;
    } else {
      json[r'lastDiscountUpdate'] = null;
    }
    if (this.buttonID != null) {
      json[r'ButtonID'] = this.buttonID;
    } else {
      json[r'ButtonID'] = null;
    }
    if (this.authorizedSessionID != null) {
      json[r'AuthorizedSessionID'] = this.authorizedSessionID;
    } else {
      json[r'AuthorizedSessionID'] = null;
    }
    if (this.sbpSystemActive != null) {
      json[r'sbpSystemActive'] = this.sbpSystemActive;
    } else {
      json[r'sbpSystemActive'] = null;
    }
    return json;
  }

  /// Returns a new [ResponsePing] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ResponsePing? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ResponsePing[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ResponsePing[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ResponsePing(
        serviceAmount: mapValueOfType<int>(json, r'serviceAmount')!,
        kaspiAmount: mapValueOfType<int>(json, r'kaspiAmount')!,
        sessionID: mapValueOfType<String>(json, r'sessionID'),
        bonusAmount: mapValueOfType<int>(json, r'bonusAmount'),
        bonusSystemActive: mapValueOfType<bool>(json, r'bonusSystemActive'),
        qrMoney: mapValueOfType<int>(json, r'qrMoney')!,
        qrUrl: mapValueOfType<String>(json, r'qrUrl')!,
        qrOrderId: mapValueOfType<String>(json, r'qrOrderId')!,
        qrFailed: mapValueOfType<bool>(json, r'qrFailed')!,
        openStation: mapValueOfType<bool>(json, r'openStation')!,
        lastUpdate: mapValueOfType<int>(json, r'lastUpdate'),
        lastDiscountUpdate: mapValueOfType<int>(json, r'lastDiscountUpdate'),
        buttonID: mapValueOfType<int>(json, r'ButtonID'),
        authorizedSessionID: mapValueOfType<String>(json, r'AuthorizedSessionID'),
        sbpSystemActive: mapValueOfType<bool>(json, r'sbpSystemActive'),
      );
    }
    return null;
  }

  static List<ResponsePing>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ResponsePing>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ResponsePing.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ResponsePing> mapFromJson(dynamic json) {
    final map = <String, ResponsePing>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ResponsePing.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ResponsePing-objects as value to a dart map
  static Map<String, List<ResponsePing>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ResponsePing>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ResponsePing.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'serviceAmount',
    'kaspiAmount',
    'qrMoney',
    'qrUrl',
    'qrOrderId',
    'qrFailed',
    'openStation',
  };
}

