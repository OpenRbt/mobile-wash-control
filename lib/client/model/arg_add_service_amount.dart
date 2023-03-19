//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgAddServiceAmount {
  /// Returns a new [ArgAddServiceAmount] instance.
  ArgAddServiceAmount({
    this.hash,
    this.amount,
  });

  String hash;

  int amount;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgAddServiceAmount &&
     other.hash == hash &&
     other.amount == amount;

  @override
  int get hashCode =>
    (hash == null ? 0 : hash.hashCode) +
    (amount == null ? 0 : amount.hashCode);

  @override
  String toString() => 'ArgAddServiceAmount[hash=$hash, amount=$amount]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (hash != null) {
      json[r'hash'] = hash;
    }
    if (amount != null) {
      json[r'amount'] = amount;
    }
    return json;
  }

  /// Returns a new [ArgAddServiceAmount] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ArgAddServiceAmount fromJson(Map<String, dynamic> json) => json == null
    ? null
    : ArgAddServiceAmount(
        hash: json[r'hash'],
        amount: json[r'amount'],
    );

  static List<ArgAddServiceAmount> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ArgAddServiceAmount>[]
      : json.map((dynamic value) => ArgAddServiceAmount.fromJson(value)).toList(growable: true == growable);

  static Map<String, ArgAddServiceAmount> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ArgAddServiceAmount>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ArgAddServiceAmount.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ArgAddServiceAmount-objects as value to a dart map
  static Map<String, List<ArgAddServiceAmount>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<ArgAddServiceAmount>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ArgAddServiceAmount.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

