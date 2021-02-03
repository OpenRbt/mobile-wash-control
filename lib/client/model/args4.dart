part of swagger.api;

class Args4 {
  
  int id = null;
  
  Args4();

  @override
  String toString() {
    return 'Args4[id=$id, ]';
  }

  Args4.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id =
        json['id']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id
     };
  }

  static List<Args4> listFromJson(List<dynamic> json) {
    return json == null ? new List<Args4>() : json.map((value) => new Args4.fromJson(value)).toList();
  }

  static Map<String, Args4> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Args4>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Args4.fromJson(value));
    }
    return map;
  }
}

