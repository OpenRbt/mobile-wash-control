//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
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
    @required this.hash,
  });

  int carsTotal;

  int coins;

  int banknotes;

  int electronical;

  int service;

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
    (carsTotal == null ? 0 : carsTotal.hashCode) +
    (coins == null ? 0 : coins.hashCode) +
    (banknotes == null ? 0 : banknotes.hashCode) +
    (electronical == null ? 0 : electronical.hashCode) +
    (service == null ? 0 : service.hashCode) +
    (hash == null ? 0 : hash.hashCode);

  @override
  String toString() => 'MoneyReport[carsTotal=$carsTotal, coins=$coins, banknotes=$banknotes, electronical=$electronical, service=$service, hash=$hash]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (carsTotal != null) {
      json[r'carsTotal'] = carsTotal;
    }
    if (coins != null) {
      json[r'coins'] = coins;
    }
    if (banknotes != null) {
      json[r'banknotes'] = banknotes;
    }
    if (electronical != null) {
      json[r'electronical'] = electronical;
    }
    if (service != null) {
      json[r'service'] = service;
    }
      json[r'hash'] = hash;
    return json;
  }

  /// Returns a new [MoneyReport] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static MoneyReport fromJson(Map<String, dynamic> json) => json == null
    ? null
    : MoneyReport(
        carsTotal: json[r'carsTotal'],
        coins: json[r'coins'],
        banknotes: json[r'banknotes'],
        electronical: json[r'electronical'],
        service: json[r'service'],
        hash: json[r'hash'],
    );

  static List<MoneyReport> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <MoneyReport>[]
      : json.map((dynamic value) => MoneyReport.fromJson(value)).toList(growable: true == growable);

  static Map<String, MoneyReport> mapFromJson(Map<String, dynamic> json) {
    final map = <String, MoneyReport>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = MoneyReport.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of MoneyReport-objects as value to a dart map
  static Map<String, List<MoneyReport>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<MoneyReport>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = MoneyReport.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

