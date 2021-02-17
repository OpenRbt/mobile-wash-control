part of swagger.api;

class Args20 {
  
  String login = null;
  

  Password oldPassword = null;
  

  Password newPassword = null;
  
  Args20();

  @override
  String toString() {
    return 'Args20[login=$login, oldPassword=$oldPassword, newPassword=$newPassword, ]';
  }

  Args20.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    login =
      
      
      json['login']
;
    oldPassword =
      
      
      new Password.fromJson(json['oldPassword'])
;
    newPassword =
      
      
      new Password.fromJson(json['newPassword'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'oldPassword': oldPassword,
      'newPassword': newPassword
     };
  }

  static List<Args20> listFromJson(List<dynamic> json) {
    return json == null ? new List<Args20>() : json.map((value) => new Args20.fromJson(value)).toList();
  }

  static Map<String, Args20> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Args20>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Args20.fromJson(value));
    }
    return map;
  }
}

