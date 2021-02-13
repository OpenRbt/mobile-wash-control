part of swagger.api;

class IsAdmin {
    IsAdmin();

  @override
  String toString() {
    return 'IsAdmin[]';
  }

  IsAdmin.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
  }

  Map<String, dynamic> toJson() {
    return {
     };
  }

  static List<IsAdmin> listFromJson(List<dynamic> json) {
    return json == null ? new List<IsAdmin>() : json.map((value) => new IsAdmin.fromJson(value)).toList();
  }

  static Map<String, IsAdmin> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, IsAdmin>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new IsAdmin.fromJson(value));
    }
    return map;
  }
}

