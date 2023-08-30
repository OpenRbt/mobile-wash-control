//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Wallet {
  /// Returns a new [Wallet] instance.
  Wallet({
    this.id,
    this.userId,
    this.organizationId,
    this.balance,
    this.pendingBalance,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? id;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? userId;

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
  int? balance;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? pendingBalance;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Wallet &&
     other.id == id &&
     other.userId == userId &&
     other.organizationId == organizationId &&
     other.balance == balance &&
     other.pendingBalance == pendingBalance;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (userId == null ? 0 : userId!.hashCode) +
    (organizationId == null ? 0 : organizationId!.hashCode) +
    (balance == null ? 0 : balance!.hashCode) +
    (pendingBalance == null ? 0 : pendingBalance!.hashCode);

  @override
  String toString() => 'Wallet[id=$id, userId=$userId, organizationId=$organizationId, balance=$balance, pendingBalance=$pendingBalance]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.userId != null) {
      json[r'userId'] = this.userId;
    } else {
      json[r'userId'] = null;
    }
    if (this.organizationId != null) {
      json[r'organizationId'] = this.organizationId;
    } else {
      json[r'organizationId'] = null;
    }
    if (this.balance != null) {
      json[r'balance'] = this.balance;
    } else {
      json[r'balance'] = null;
    }
    if (this.pendingBalance != null) {
      json[r'pendingBalance'] = this.pendingBalance;
    } else {
      json[r'pendingBalance'] = null;
    }
    return json;
  }

  /// Returns a new [Wallet] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Wallet? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Wallet[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Wallet[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Wallet(
        id: mapValueOfType<String>(json, r'id'),
        userId: mapValueOfType<String>(json, r'userId'),
        organizationId: mapValueOfType<String>(json, r'organizationId'),
        balance: mapValueOfType<int>(json, r'balance'),
        pendingBalance: mapValueOfType<int>(json, r'pendingBalance'),
      );
    }
    return null;
  }

  static List<Wallet>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Wallet>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Wallet.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Wallet> mapFromJson(dynamic json) {
    final map = <String, Wallet>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Wallet.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Wallet-objects as value to a dart map
  static Map<String, List<Wallet>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Wallet>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Wallet.listFromJson(entry.value, growable: growable,);
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

