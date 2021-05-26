part of swagger.api;

class PingArgs {
  
  String hash = null;
  

  int currentBalance = null;
  

  int currentProgram = null;

  PingArgs();

  @override
  String toString() {
    return 'Args10[hash=$hash, currentBalance=$currentBalance, currentProgram=$currentProgram, ]';
  }

  PingArgs.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    hash =
      
      
      json['hash']
;
    currentBalance =
        json['currentBalance']
    ;
    currentProgram =
        json['currentProgram']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'hash': hash,
      'currentBalance': currentBalance,
      'currentProgram': currentProgram
     };
  }

  static List<PingArgs> listFromJson(List<dynamic> json) {
    return json == null ? new List<PingArgs>() : json.map((value) => new PingArgs.fromJson(value)).toList();
  }

  static Map<String, PingArgs> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PingArgs>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new PingArgs.fromJson(value));
    }
    return map;
  }
}

