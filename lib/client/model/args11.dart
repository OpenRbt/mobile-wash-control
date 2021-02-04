part of swagger.api;

class Args11 {
  
  String hash = null;
  
  Args11();

  @override
  String toString() {
    return 'Args11[hash=$hash, ]';
  }

  Args11.fromJson(Map<String, dynamic> json) {
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

  static List<Args11> listFromJson(List<dynamic> json) {
    return json == null ? new List<Args11>() : json.map((value) => new Args11.fromJson(value)).toList();
  }

  static Map<String, Args11> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Args11>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Args11.fromJson(value));
    }
    return map;
  }
}

