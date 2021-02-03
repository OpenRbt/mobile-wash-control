part of swagger.api;

class Args7 {
  
  Hash hash = null;
  
  Args7();

  @override
  String toString() {
    return 'Args7[hash=$hash, ]';
  }

  Args7.fromJson(Map<String, dynamic> json) {
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

  static List<Args7> listFromJson(List<dynamic> json) {
    return json == null ? new List<Args7>() : json.map((value) => new Args7.fromJson(value)).toList();
  }

  static Map<String, Args7> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Args7>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Args7.fromJson(value));
    }
    return map;
  }
}

