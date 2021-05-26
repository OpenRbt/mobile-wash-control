part of swagger.api;

class LoadMoneyArgs {
  
  String hash = null;
  
  LoadMoneyArgs();

  @override
  String toString() {
    return 'Args7[hash=$hash, ]';
  }

  LoadMoneyArgs.fromJson(Map<String, dynamic> json) {
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

  static List<LoadMoneyArgs> listFromJson(List<dynamic> json) {
    return json == null ? new List<LoadMoneyArgs>() : json.map((value) => new LoadMoneyArgs.fromJson(value)).toList();
  }

  static Map<String, LoadMoneyArgs> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, LoadMoneyArgs>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new LoadMoneyArgs.fromJson(value));
    }
    return map;
  }
}

