part of swagger.api;

class Args8 {
  
  Hash hash = null;
  

  KeyPair keyPair = null;
  
  Args8();

  @override
  String toString() {
    return 'Args8[hash=$hash, keyPair=$keyPair, ]';
  }

  Args8.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    hash =
      
      
      new Hash.fromJson(json['hash'])
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

  static List<Args8> listFromJson(List<dynamic> json) {
    return json == null ? new List<Args8>() : json.map((value) => new Args8.fromJson(value)).toList();
  }

  static Map<String, Args8> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Args8>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Args8.fromJson(value));
    }
    return map;
  }
}

