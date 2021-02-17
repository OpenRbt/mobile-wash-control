
part of swagger.api;

class UserConfig {
  String login = null;

  String firstName = null;

  String middleName = null;

  String lastName = null;

  bool isAdmin = null;

  bool isOperator = null;

  bool isEngineer = null;

  UserConfig();

  @override
  String toString() {
    return 'UserConfig[login=$login, firstName=$firstName, middleName=$middleName, lastName=$lastName, isAdmin=$isAdmin, isOperator=$isOperator, isEngineer=$isEngineer, ]';
  }

  UserConfig.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    login = json['login'];
    firstName =  json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    isAdmin = json['isAdmin'];
    isOperator = json['isOperator'];
    isEngineer = json['isEngineer'];
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'isAdmin': isAdmin,
      'isOperator': isOperator,
      'isEngineer': isEngineer
    };
  }

  static List<UserConfig> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UserConfig>()
        : json.map((value) => new UserConfig.fromJson(value)).toList();
  }

  static Map<String, UserConfig> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UserConfig>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new UserConfig.fromJson(value));
    }
    return map;
  }
}