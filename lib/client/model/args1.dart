part of swagger.api;

class Args1 {
  
  int id = null;
  
  Args1();

  @override
  String toString() {
    return 'Args1[id=$id, ]';
  }

  Args1.fromJson(Map<String, dynamic> json) {
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

  static List<Args1> listFromJson(List<dynamic> json) {
    return json == null ? new List<Args1>() : json.map((value) => new Args1.fromJson(value)).toList();
  }

  static Map<String, Args1> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Args1>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Args1.fromJson(value));
    }
    return map;
  }
}

