//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TransactionPage {
  /// Returns a new [TransactionPage] instance.
  TransactionPage({
    this.items = const [],
    required this.page,
    required this.pageSize,
    required this.totalPages,
    required this.totalItems,
  });

  List<Transaction> items;

  /// Minimum value: 1
  int page;

  /// Minimum value: 1
  /// Maximum value: 100
  int pageSize;

  /// Minimum value: 0
  int totalPages;

  /// Minimum value: 0
  int totalItems;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TransactionPage &&
     other.items == items &&
     other.page == page &&
     other.pageSize == pageSize &&
     other.totalPages == totalPages &&
     other.totalItems == totalItems;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (items.hashCode) +
    (page.hashCode) +
    (pageSize.hashCode) +
    (totalPages.hashCode) +
    (totalItems.hashCode);

  @override
  String toString() => 'TransactionPage[items=$items, page=$page, pageSize=$pageSize, totalPages=$totalPages, totalItems=$totalItems]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'items'] = this.items;
      json[r'page'] = this.page;
      json[r'pageSize'] = this.pageSize;
      json[r'totalPages'] = this.totalPages;
      json[r'totalItems'] = this.totalItems;
    return json;
  }

  /// Returns a new [TransactionPage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TransactionPage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "TransactionPage[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "TransactionPage[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TransactionPage(
        items: Transaction.listFromJson(json[r'items'])!,
        page: mapValueOfType<int>(json, r'page')!,
        pageSize: mapValueOfType<int>(json, r'pageSize')!,
        totalPages: mapValueOfType<int>(json, r'totalPages')!,
        totalItems: mapValueOfType<int>(json, r'totalItems')!,
      );
    }
    return null;
  }

  static List<TransactionPage>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TransactionPage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TransactionPage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TransactionPage> mapFromJson(dynamic json) {
    final map = <String, TransactionPage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TransactionPage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TransactionPage-objects as value to a dart map
  static Map<String, List<TransactionPage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TransactionPage>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TransactionPage.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'items',
    'page',
    'pageSize',
    'totalPages',
    'totalItems',
  };
}

