//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UsersReport {
  /// Returns a new [UsersReport] instance.
  UsersReport({
    this.users = const [],
  });

  List<UserConfig> users;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UsersReport &&
     other.users == users;

  @override
  int get hashCode =>
    (users == null ? 0 : users.hashCode);

  @override
  String toString() => 'UsersReport[users=$users]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (users != null) {
      json[r'users'] = users;
    }
    return json;
  }

  /// Returns a new [UsersReport] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static UsersReport fromJson(Map<String, dynamic> json) => json == null
    ? null
    : UsersReport(
        users: UserConfig.listFromJson(json[r'users']),
    );

  static List<UsersReport> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <UsersReport>[]
      : json.map((dynamic value) => UsersReport.fromJson(value)).toList(growable: true == growable);

  static Map<String, UsersReport> mapFromJson(Map<String, dynamic> json) {
    final map = <String, UsersReport>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = UsersReport.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of UsersReport-objects as value to a dart map
  static Map<String, List<UsersReport>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<UsersReport>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = UsersReport.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

