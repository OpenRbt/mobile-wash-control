part of swagger.api;

class KeyPair {
  
  String key = null;
  

  String value = null;
  
  KeyPair();

  @override
  String toString() {
    return 'KeyPair[key=$key, value=$value, ]';
  }

  KeyPair.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    key =
        json['key']
    ;
    value =
        json['value']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value
     };
  }

  static List<KeyPair> listFromJson(List<dynamic> json) {
    return json == null ? new List<KeyPair>() : json.map((value) => new KeyPair.fromJson(value)).toList();
  }

  static Map<String, KeyPair> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, KeyPair>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new KeyPair.fromJson(value));
    }
    return map;
  }
}

