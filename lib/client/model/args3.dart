part of swagger.api;

class Args3 {
  
  int id = null;
  
  Args3();

  @override
  String toString() {
    return 'Args3[id=$id, ]';
  }

  Args3.fromJson(Map<String, dynamic> json) {
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

  static List<Args3> listFromJson(List<dynamic> json) {
    return json == null ? new List<Args3>() : json.map((value) => new Args3.fromJson(value)).toList();
  }

  static Map<String, Args3> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Args3>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Args3.fromJson(value));
    }
    return map;
  }
}

