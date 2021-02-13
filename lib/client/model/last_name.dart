part of swagger.api;

class LastName {
    LastName();

  @override
  String toString() {
    return 'LastName[]';
  }

  LastName.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
  }

  Map<String, dynamic> toJson() {
    return {
     };
  }

  static List<LastName> listFromJson(List<dynamic> json) {
    return json == null ? new List<LastName>() : json.map((value) => new LastName.fromJson(value)).toList();
  }

  static Map<String, LastName> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, LastName>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new LastName.fromJson(value));
    }
    return map;
  }
}

