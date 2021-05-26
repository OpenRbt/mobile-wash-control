part of swagger.api;

class StationByHashArgs {
  
  String hash = null;
  
  StationByHashArgs();

  @override
  String toString() {
    return 'Args11[hash=$hash, ]';
  }

  StationByHashArgs.fromJson(Map<String, dynamic> json) {
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

  static List<StationByHashArgs> listFromJson(List<dynamic> json) {
    return json == null ? new List<StationByHashArgs>() : json.map((value) => new StationByHashArgs.fromJson(value)).toList();
  }

  static Map<String, StationByHashArgs> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, StationByHashArgs>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new StationByHashArgs.fromJson(value));
    }
    return map;
  }
}

