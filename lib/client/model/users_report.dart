part of swagger.api;

class UsersReport {
  List<UserConfig> users = [];

  UsersReport();

  @override
  String toString() {
    return 'UsersReport[users=$users, ]';
  }

  UsersReport.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    users = UserConfig.listFromJson(json['users']);
  }

  Map<String, dynamic> toJson() {
    return {'users': users};
  }

  static List<UsersReport> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UsersReport>()
        : json.map((value) => new UsersReport.fromJson(value)).toList();
  }

  static Map<String, UsersReport> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UsersReport>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new UsersReport.fromJson(value));
    }
    return map;
  }
}
