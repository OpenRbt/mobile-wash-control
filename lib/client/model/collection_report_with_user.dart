//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CollectionReportWithUser {
  /// Returns a new [CollectionReportWithUser] instance.
  CollectionReportWithUser({
    this.id,
    this.carsTotal,
    this.coins,
    this.banknotes,
    this.electronical,
    this.service,
    this.ctime,
    this.user,
  });

  int id;

  int carsTotal;

  int coins;

  int banknotes;

  int electronical;

  int service;

  int ctime;

  String user;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollectionReportWithUser &&
          other.id == id &&
          other.carsTotal == carsTotal &&
          other.coins == coins &&
          other.banknotes == banknotes &&
          other.electronical == electronical &&
          other.service == service &&
          other.ctime == ctime &&
          other.user == user;

  @override
  int get hashCode =>
      (id == null ? 0 : id.hashCode) +
      (carsTotal == null ? 0 : carsTotal.hashCode) +
      (coins == null ? 0 : coins.hashCode) +
      (banknotes == null ? 0 : banknotes.hashCode) +
      (electronical == null ? 0 : electronical.hashCode) +
      (service == null ? 0 : service.hashCode) +
      (ctime == null ? 0 : ctime.hashCode) +
      (user == null ? 0 : user.hashCode);

  @override
  String toString() => 'CollectionReportWithUser[id=$id, carsTotal=$carsTotal, coins=$coins, banknotes=$banknotes, electronical=$electronical, service=$service, ctime=$ctime, user=$user]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (id != null) {
      json[r'id'] = id;
    }
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
    if (ctime != null) {
      json[r'ctime'] = ctime;
    }
    if (user != null) {
      json[r'user'] = user;
    }
    return json;
  }

  /// Returns a new [CollectionReportWithUser] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static CollectionReportWithUser fromJson(Map<String, dynamic> json) => json == null
      ? null
      : CollectionReportWithUser(
          id: json[r'id'],
          carsTotal: json[r'carsTotal'],
          coins: json[r'coins'],
          banknotes: json[r'banknotes'],
          electronical: json[r'electronical'],
          service: json[r'service'],
          ctime: json[r'ctime'],
          user: json[r'user'],
        );

  static List<CollectionReportWithUser> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <CollectionReportWithUser>[]
          : json.map((dynamic value) => CollectionReportWithUser.fromJson(value)).toList(growable: true == growable);

  static Map<String, CollectionReportWithUser> mapFromJson(Map<String, dynamic> json) {
    final map = <String, CollectionReportWithUser>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = CollectionReportWithUser.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of CollectionReportWithUser-objects as value to a dart map
  static Map<String, List<CollectionReportWithUser>> mapListFromJson(
    Map<String, dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<CollectionReportWithUser>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = CollectionReportWithUser.listFromJson(
          value,
          emptyIsNull: emptyIsNull,
          growable: growable,
        );
      });
    }
    return map;
  }
}
