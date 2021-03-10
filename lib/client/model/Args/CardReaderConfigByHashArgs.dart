part of swagger.api;

class CardReaderConfigByHashArgs {
  
  String hash = null;
  
  CardReaderConfigByHashArgs();

  @override
  String toString() {
    return 'Args19[hash=$hash, ]';
  }

  CardReaderConfigByHashArgs.fromJson(Map<String, dynamic> json) {
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

  static List<CardReaderConfigByHashArgs> listFromJson(List<dynamic> json) {
    return json == null ? new List<CardReaderConfigByHashArgs>() : json.map((value) => new CardReaderConfigByHashArgs.fromJson(value)).toList();
  }

  static Map<String, CardReaderConfigByHashArgs> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CardReaderConfigByHashArgs>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new CardReaderConfigByHashArgs.fromJson(value));
    }
    return map;
  }
}

