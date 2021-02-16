part of swagger.api;

class Args19 {

  String hash = null;
  
  Args19();

  @override
  String toString() {
    return 'Args19[hash=$hash, ]';
  }

  Args19.fromJson(Map<String, dynamic> json) {
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

  static List<Args19> listFromJson(List<dynamic> json) {
    return json == null ? new List<Args19>() : json.map((value) => new Args19.fromJson(value)).toList();
  }

  static Map<String, Args19> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Args19>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Args19.fromJson(value));
    }
    return map;
  }
}

