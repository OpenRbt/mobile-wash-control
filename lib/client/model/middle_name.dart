part of swagger.api;

class MiddleName {
    MiddleName();

  @override
  String toString() {
    return 'MiddleName[]';
  }

  MiddleName.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
  }

  Map<String, dynamic> toJson() {
    return {
     };
  }

  static List<MiddleName> listFromJson(List<dynamic> json) {
    return json == null ? new List<MiddleName>() : json.map((value) => new MiddleName.fromJson(value)).toList();
  }

  static Map<String, MiddleName> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MiddleName>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new MiddleName.fromJson(value));
    }
    return map;
  }
}

