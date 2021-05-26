part of swagger.api;

class StationsVariables {
  
  int id = null;
  

  String name = null;
  

  String hash = null;
  

  List<KeyPair> keyPairs = [];
  
  StationsVariables();

  @override
  String toString() {
    return 'StationsVariables[id=$id, name=$name, hash=$hash, keyPairs=$keyPairs, ]';
  }

  StationsVariables.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id =
        json['id']
    ;
    name =
        json['name']
    ;
    hash =
        json['hash']
    ;
    keyPairs =
      KeyPair.listFromJson(json['keyPairs'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'hash': hash,
      'keyPairs': keyPairs
     };
  }

  static List<StationsVariables> listFromJson(List<dynamic> json) {
    return json == null ? new List<StationsVariables>() : json.map((value) => new StationsVariables.fromJson(value)).toList();
  }

  static Map<String, StationsVariables> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, StationsVariables>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new StationsVariables.fromJson(value));
    }
    return map;
  }
}

