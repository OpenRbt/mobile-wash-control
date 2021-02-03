part of swagger.api;

class Args6 {
  
  int id = null;
  
  Args6();

  @override
  String toString() {
    return 'Args6[id=$id, ]';
  }

  Args6.fromJson(Map<String, dynamic> json) {
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

  static List<Args6> listFromJson(List<dynamic> json) {
    return json == null ? new List<Args6>() : json.map((value) => new Args6.fromJson(value)).toList();
  }

  static Map<String, Args6> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Args6>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Args6.fromJson(value));
    }
    return map;
  }
}

