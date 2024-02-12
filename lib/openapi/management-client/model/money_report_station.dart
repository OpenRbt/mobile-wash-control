//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MoneyReportStation {
  /// Returns a new [MoneyReportStation] instance.
  MoneyReportStation({
    this.organizationId,
    this.organizationDisplayName,
    this.groupId,
    this.groupName,
    this.washServerId,
    this.washName,
    this.stationId,
    this.carsTotal,
    this.coins,
    this.banknotes,
    this.electronical,
    this.service,
    this.bonuses,
    this.qrMoney,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? organizationId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? organizationDisplayName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? groupId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? groupName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? washServerId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? washName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? stationId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? carsTotal;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? coins;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? banknotes;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? electronical;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? service;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? bonuses;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? qrMoney;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MoneyReportStation &&
     other.organizationId == organizationId &&
     other.organizationDisplayName == organizationDisplayName &&
     other.groupId == groupId &&
     other.groupName == groupName &&
     other.washServerId == washServerId &&
     other.washName == washName &&
     other.stationId == stationId &&
     other.carsTotal == carsTotal &&
     other.coins == coins &&
     other.banknotes == banknotes &&
     other.electronical == electronical &&
     other.service == service &&
     other.bonuses == bonuses &&
     other.qrMoney == qrMoney;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (organizationId == null ? 0 : organizationId!.hashCode) +
    (organizationDisplayName == null ? 0 : organizationDisplayName!.hashCode) +
    (groupId == null ? 0 : groupId!.hashCode) +
    (groupName == null ? 0 : groupName!.hashCode) +
    (washServerId == null ? 0 : washServerId!.hashCode) +
    (washName == null ? 0 : washName!.hashCode) +
    (stationId == null ? 0 : stationId!.hashCode) +
    (carsTotal == null ? 0 : carsTotal!.hashCode) +
    (coins == null ? 0 : coins!.hashCode) +
    (banknotes == null ? 0 : banknotes!.hashCode) +
    (electronical == null ? 0 : electronical!.hashCode) +
    (service == null ? 0 : service!.hashCode) +
    (bonuses == null ? 0 : bonuses!.hashCode) +
    (qrMoney == null ? 0 : qrMoney!.hashCode);

  @override
  String toString() => 'MoneyReportStation[organizationId=$organizationId, organizationDisplayName=$organizationDisplayName, groupId=$groupId, groupName=$groupName, washServerId=$washServerId, washName=$washName, stationId=$stationId, carsTotal=$carsTotal, coins=$coins, banknotes=$banknotes, electronical=$electronical, service=$service, bonuses=$bonuses, qrMoney=$qrMoney]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.organizationId != null) {
      json[r'organizationId'] = this.organizationId;
    } else {
      json[r'organizationId'] = null;
    }
    if (this.organizationDisplayName != null) {
      json[r'organizationDisplayName'] = this.organizationDisplayName;
    } else {
      json[r'organizationDisplayName'] = null;
    }
    if (this.groupId != null) {
      json[r'groupId'] = this.groupId;
    } else {
      json[r'groupId'] = null;
    }
    if (this.groupName != null) {
      json[r'groupName'] = this.groupName;
    } else {
      json[r'groupName'] = null;
    }
    if (this.washServerId != null) {
      json[r'washServerId'] = this.washServerId;
    } else {
      json[r'washServerId'] = null;
    }
    if (this.washName != null) {
      json[r'washName'] = this.washName;
    } else {
      json[r'washName'] = null;
    }
    if (this.stationId != null) {
      json[r'stationId'] = this.stationId;
    } else {
      json[r'stationId'] = null;
    }
    if (this.carsTotal != null) {
      json[r'carsTotal'] = this.carsTotal;
    } else {
      json[r'carsTotal'] = null;
    }
    if (this.coins != null) {
      json[r'coins'] = this.coins;
    } else {
      json[r'coins'] = null;
    }
    if (this.banknotes != null) {
      json[r'banknotes'] = this.banknotes;
    } else {
      json[r'banknotes'] = null;
    }
    if (this.electronical != null) {
      json[r'electronical'] = this.electronical;
    } else {
      json[r'electronical'] = null;
    }
    if (this.service != null) {
      json[r'service'] = this.service;
    } else {
      json[r'service'] = null;
    }
    if (this.bonuses != null) {
      json[r'bonuses'] = this.bonuses;
    } else {
      json[r'bonuses'] = null;
    }
    if (this.qrMoney != null) {
      json[r'qrMoney'] = this.qrMoney;
    } else {
      json[r'qrMoney'] = null;
    }
    return json;
  }

  /// Returns a new [MoneyReportStation] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MoneyReportStation? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MoneyReportStation[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MoneyReportStation[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MoneyReportStation(
        organizationId: mapValueOfType<String>(json, r'organizationId'),
        organizationDisplayName: mapValueOfType<String>(json, r'organizationDisplayName'),
        groupId: mapValueOfType<String>(json, r'groupId'),
        groupName: mapValueOfType<String>(json, r'groupName'),
        washServerId: mapValueOfType<String>(json, r'washServerId'),
        washName: mapValueOfType<String>(json, r'washName'),
        stationId: mapValueOfType<int>(json, r'stationId'),
        carsTotal: mapValueOfType<int>(json, r'carsTotal'),
        coins: mapValueOfType<int>(json, r'coins'),
        banknotes: mapValueOfType<int>(json, r'banknotes'),
        electronical: mapValueOfType<int>(json, r'electronical'),
        service: mapValueOfType<int>(json, r'service'),
        bonuses: mapValueOfType<int>(json, r'bonuses'),
        qrMoney: mapValueOfType<int>(json, r'qrMoney'),
      );
    }
    return null;
  }

  static List<MoneyReportStation>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MoneyReportStation>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MoneyReportStation.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MoneyReportStation> mapFromJson(dynamic json) {
    final map = <String, MoneyReportStation>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MoneyReportStation.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MoneyReportStation-objects as value to a dart map
  static Map<String, List<MoneyReportStation>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MoneyReportStation>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MoneyReportStation.listFromJson(entry.value, growable: growable,);
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

