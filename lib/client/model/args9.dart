part of swagger.api;

class Args9 {
  
  String hash = null;
  

  String key = null;
  
  Args9();

  @override
  String toString() {
    return 'Args9[hash=$hash, key=$key, ]';
  }

  Args9.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    hash =
      
      
      json['hash']
;
    key =
        json['key']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'hash': hash,
      'key': key
     };
  }

  static List<Args9> listFromJson(List<dynamic> json) {
    return json == null ? new List<Args9>() : json.map((value) => new Args9.fromJson(value)).toList();
  }

  static Map<String, Args9> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Args9>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Args9.fromJson(value));
    }
    return map;
  }
}

