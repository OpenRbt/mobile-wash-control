part of swagger.api;

class Args5 {
  
  String hash = null;
  
  Args5();

  @override
  String toString() {
    return 'Args5[hash=$hash, ]';
  }

  Args5.fromJson(Map<String, dynamic> json) {
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

  static List<Args5> listFromJson(List<dynamic> json) {
    return json == null ? new List<Args5>() : json.map((value) => new Args5.fromJson(value)).toList();
  }

  static Map<String, Args5> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Args5>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Args5.fromJson(value));
    }
    return map;
  }
}

