part of swagger.api;

class Password {
    Password();

  @override
  String toString() {
    return 'Password[]';
  }

  Password.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
  }

  Map<String, dynamic> toJson() {
    return {
     };
  }

  static List<Password> listFromJson(List<dynamic> json) {
    return json == null ? new List<Password>() : json.map((value) => new Password.fromJson(value)).toList();
  }

  static Map<String, Password> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Password>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Password.fromJson(value));
    }
    return map;
  }
}

