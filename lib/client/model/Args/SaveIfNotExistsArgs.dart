part of swagger.api;

class SaveIfNotExistsArgs {
  
  String hash = null;
  

  KeyPair keyPair = null;

  SaveIfNotExistsArgs();

  @override
  String toString() {
    return 'Args12[hash=$hash, keyPair=$keyPair, ]';
  }

  SaveIfNotExistsArgs.fromJson(Map<String, dynamic> json) {
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

  static List<SaveIfNotExistsArgs> listFromJson(List<dynamic> json) {
    return json == null ? new List<SaveIfNotExistsArgs>() : json.map((value) => new SaveIfNotExistsArgs.fromJson(value)).toList();
  }

  static Map<String, SaveIfNotExistsArgs> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, SaveIfNotExistsArgs>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new SaveIfNotExistsArgs.fromJson(value));
    }
    return map;
  }
}

