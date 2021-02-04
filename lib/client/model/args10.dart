part of swagger.api;

class Args10 {
  
  String hash = null;
  
  Args10();

  @override
  String toString() {
    return 'Args10[hash=$hash, ]';
  }

  Args10.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    hash =
      
      
     json['hash']
;
  }

  Map<String, dynamic> toJson() {
    return {
      'hash': hash
     };
  }

  static List<Args10> listFromJson(List<dynamic> json) {
    return json == null ? new List<Args10>() : json.map((value) => new Args10.fromJson(value)).toList();
  }

  static Map<String, Args10> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Args10>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Args10.fromJson(value));
    }
    return map;
  }
}

