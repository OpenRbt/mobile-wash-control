//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MoneyReport {
  /// Returns a new [MoneyReport] instance.
  MoneyReport({
    this.carsTotal,
    this.coins,
    this.banknotes,
    this.electronical,
    this.service,
    required this.hash,
  });

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

  String hash;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MoneyReport &&
     other.carsTotal == carsTotal &&
     other.coins == coins &&
     other.banknotes == banknotes &&
     other.electronical == electronical &&
     other.service == service &&
     other.hash == hash;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (carsTotal == null ? 0 : carsTotal!.hashCode) +
    (coins == null ? 0 : coins!.hashCode) +
    (banknotes == null ? 0 : banknotes!.hashCode) +
    (electronical == null ? 0 : electronical!.hashCode) +
    (service == null ? 0 : service!.hashCode) +
    (hash.hashCode);

  @override
  String toString() => 'MoneyReport[carsTotal=$carsTotal, coins=$coins, banknotes=$banknotes, electronical=$electronical, service=$service, hash=$hash]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
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
      json[r'hash'] = this.hash;
    return json;
  }

  /// Returns a new [MoneyReport] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MoneyReport? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MoneyReport[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MoneyReport[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MoneyReport(
        carsTotal: mapValueOfType<int>(json, r'carsTotal'),
        coins: mapValueOfType<int>(json, r'coins'),
        banknotes: mapValueOfType<int>(json, r'banknotes'),
        electronical: mapValueOfType<int>(json, r'electronical'),
        service: mapValueOfType<int>(json, r'service'),
        hash: mapValueOfType<String>(json, r'hash')!,
      );
    }
    return null;
  }

  static List<MoneyReport>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MoneyReport>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MoneyReport.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MoneyReport> mapFromJson(dynamic json) {
    final map = <String, MoneyReport>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MoneyReport.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MoneyReport-objects as value to a dart map
  static Map<String, List<MoneyReport>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MoneyReport>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MoneyReport.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'hash',
  };
}

