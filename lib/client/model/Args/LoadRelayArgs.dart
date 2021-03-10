part of swagger.api;

class LoadRelayArgs {
  
  String hash = null;
  
  LoadRelayArgs();

  @override
  String toString() {
    return 'Args5[hash=$hash, ]';
  }

  LoadRelayArgs.fromJson(Map<String, dynamic> json) {
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

  static List<LoadRelayArgs> listFromJson(List<dynamic> json) {
    return json == null ? new List<LoadRelayArgs>() : json.map((value) => new LoadRelayArgs.fromJson(value)).toList();
  }

  static Map<String, LoadRelayArgs> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, LoadRelayArgs>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new LoadRelayArgs.fromJson(value));
    }
    return map;
  }
}

