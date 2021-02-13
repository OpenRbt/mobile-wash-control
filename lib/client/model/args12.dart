part of swagger.api;

class Args12 {
  
  String hash = null;
  

  KeyPair keyPair = null;
  
  Args12();

  @override
  String toString() {
    return 'Args12[hash=$hash, keyPair=$keyPair, ]';
  }

  Args12.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    hash =
      
      
      json['hash']
;
    keyPair =
      
      
      new KeyPair.fromJson(json['keyPair'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'hash': hash,
      'keyPair': keyPair
     };
  }

  static List<Args12> listFromJson(List<dynamic> json) {
    return json == null ? new List<Args12>() : json.map((value) => new Args12.fromJson(value)).toList();
  }

  static Map<String, Args12> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Args12>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Args12.fromJson(value));
    }
    return map;
  }
}

