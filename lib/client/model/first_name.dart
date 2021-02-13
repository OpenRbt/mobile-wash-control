part of swagger.api;

class FirstName {
    FirstName();

  @override
  String toString() {
    return 'FirstName[]';
  }

  FirstName.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
  }

  Map<String, dynamic> toJson() {
    return {
     };
  }

  static List<FirstName> listFromJson(List<dynamic> json) {
    return json == null ? new List<FirstName>() : json.map((value) => new FirstName.fromJson(value)).toList();
  }

  static Map<String, FirstName> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, FirstName>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new FirstName.fromJson(value));
    }
    return map;
  }
}

