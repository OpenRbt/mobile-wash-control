part of swagger.api;

class SaveArgs {
  
  String hash = null;
  

  KeyPair keyPair = null;
  
  SaveArgs();

  @override
  String toString() {
    return 'Args8[hash=$hash, keyPair=$keyPair, ]';
  }

  SaveArgs.fromJson(Map<String, dynamic> json) {
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

  static List<SaveArgs> listFromJson(List<dynamic> json) {
    return json == null ? new List<SaveArgs>() : json.map((value) => new SaveArgs.fromJson(value)).toList();
  }

  static Map<String, SaveArgs> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, SaveArgs>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new SaveArgs.fromJson(value));
    }
    return map;
  }
}

