part of swagger.api;

class StationProgramByHashArgs {
  
  String hash = null;
  
  StationProgramByHashArgs();

  @override
  String toString() {
    return 'Args15[hash=$hash, ]';
  }

  StationProgramByHashArgs.fromJson(Map<String, dynamic> json) {
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

  static List<StationProgramByHashArgs> listFromJson(List<dynamic> json) {
    return json == null ? new List<StationProgramByHashArgs>() : json.map((value) => new StationProgramByHashArgs.fromJson(value)).toList();
  }

  static Map<String, StationProgramByHashArgs> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, StationProgramByHashArgs>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new StationProgramByHashArgs.fromJson(value));
    }
    return map;
  }
}

