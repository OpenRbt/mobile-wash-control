part of swagger.api;

class Args23 {
  
  String login = null;
  
  Args23();

  @override
  String toString() {
    return 'Args23[login=$login, ]';
  }

  Args23.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    login =
      
      
      json['login']
;
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login
     };
  }

  static List<Args23> listFromJson(List<dynamic> json) {
    return json == null ? new List<Args23>() : json.map((value) => new Args23.fromJson(value)).toList();
  }

  static Map<String, Args23> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Args23>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Args23.fromJson(value));
    }
    return map;
  }
}

