//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Transaction {
  /// Returns a new [Transaction] instance.
  Transaction({
    required this.id,
    required this.createdAt,
    required this.amount,
    required this.status,
    required this.postId,
    required this.wash,
    required this.group,
    required this.organization,
  });

  String id;

  DateTime createdAt;

  int amount;

  TransactionStatus status;

  int postId;

  SimpleWash wash;

  Group group;

  Organization organization;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Transaction &&
     other.id == id &&
     other.createdAt == createdAt &&
     other.amount == amount &&
     other.status == status &&
     other.postId == postId &&
     other.wash == wash &&
     other.group == group &&
     other.organization == organization;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (createdAt.hashCode) +
    (amount.hashCode) +
    (status.hashCode) +
    (postId.hashCode) +
    (wash.hashCode) +
    (group.hashCode) +
    (organization.hashCode);

  @override
  String toString() => 'Transaction[id=$id, createdAt=$createdAt, amount=$amount, status=$status, postId=$postId, wash=$wash, group=$group, organization=$organization]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'createdAt'] = this.createdAt.toUtc().toIso8601String();
      json[r'amount'] = this.amount;
      json[r'status'] = this.status;
      json[r'postId'] = this.postId;
      json[r'wash'] = this.wash;
      json[r'group'] = this.group;
      json[r'organization'] = this.organization;
    return json;
  }

  /// Returns a new [Transaction] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Transaction? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Transaction[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Transaction[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Transaction(
        id: mapValueOfType<String>(json, r'id')!,
        createdAt: mapDateTime(json, r'createdAt', '')!,
        amount: mapValueOfType<int>(json, r'amount')!,
        status: TransactionStatus.fromJson(json[r'status'])!,
        postId: mapValueOfType<int>(json, r'postId')!,
        wash: SimpleWash.fromJson(json[r'wash'])!,
        group: Group.fromJson(json[r'group'])!,
        organization: Organization.fromJson(json[r'organization'])!,
      );
    }
    return null;
  }

  static List<Transaction>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Transaction>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Transaction.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Transaction> mapFromJson(dynamic json) {
    final map = <String, Transaction>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Transaction.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Transaction-objects as value to a dart map
  static Map<String, List<Transaction>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Transaction>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Transaction.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'createdAt',
    'amount',
    'status',
    'postId',
    'wash',
    'group',
    'organization',
  };
}

