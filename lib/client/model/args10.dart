part of swagger.api;

class Args10 {

  String hash = null;
  

  int currentBalance = null;
  

  int currentProgram = null;
  
  Args10();

  @override
  String toString() {
    return 'Args10[hash=$hash, currentBalance=$currentBalance, currentProgram=$currentProgram, ]';
  }

  Args10.fromJson(Map<String, dynamic> json) {
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

  static List<Args10> listFromJson(List<dynamic> json) {
    return json == null ? new List<Args10>() : json.map((value) => new Args10.fromJson(value)).toList();
  }

  static Map<String, Args10> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Args10>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Args10.fromJson(value));
    }
    return map;
  }
}

