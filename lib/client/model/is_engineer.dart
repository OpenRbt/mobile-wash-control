part of swagger.api;

class IsEngineer {
    IsEngineer();

  @override
  String toString() {
    return 'IsEngineer[]';
  }

  IsEngineer.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
  }

  Map<String, dynamic> toJson() {
    return {
     };
  }

  static List<IsEngineer> listFromJson(List<dynamic> json) {
    return json == null ? new List<IsEngineer>() : json.map((value) => new IsEngineer.fromJson(value)).toList();
  }

  static Map<String, IsEngineer> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, IsEngineer>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new IsEngineer.fromJson(value));
    }
    return map;
  }
}

