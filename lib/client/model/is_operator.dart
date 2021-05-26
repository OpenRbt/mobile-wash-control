part of swagger.api;

class IsOperator {
    IsOperator();

  @override
  String toString() {
    return 'IsOperator[]';
  }

  IsOperator.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
  }

  Map<String, dynamic> toJson() {
    return {
     };
  }

  static List<IsOperator> listFromJson(List<dynamic> json) {
    return json == null ? new List<IsOperator>() : json.map((value) => new IsOperator.fromJson(value)).toList();
  }

  static Map<String, IsOperator> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, IsOperator>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new IsOperator.fromJson(value));
    }
    return map;
  }
}

