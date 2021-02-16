part of swagger.api;

class Args15 {
  
  Hash hash = null;
  
  Args15();

  @override
  String toString() {
    return 'Args15[hash=$hash, ]';
  }

  Args15.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    hash =
      
      
      new Hash.fromJson(json['hash'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'hash': hash
     };
  }

  static List<Args15> listFromJson(List<dynamic> json) {
    return json == null ? new List<Args15>() : json.map((value) => new Args15.fromJson(value)).toList();
  }

  static Map<String, Args15> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Args15>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Args15.fromJson(value));
    }
    return map;
  }
}

