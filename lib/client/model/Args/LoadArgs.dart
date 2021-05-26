part of swagger.api;

class LoadArgs {
  
  String hash = null;
  

  String key = null;
  
  LoadArgs();

  @override
  String toString() {
    return 'Args9[hash=$hash, key=$key, ]';
  }

  LoadArgs.fromJson(Map<String, dynamic> json) {
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

  static List<LoadArgs> listFromJson(List<dynamic> json) {
    return json == null ? new List<LoadArgs>() : json.map((value) => new LoadArgs.fromJson(value)).toList();
  }

  static Map<String, LoadArgs> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, LoadArgs>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new LoadArgs.fromJson(value));
    }
    return map;
  }
}

