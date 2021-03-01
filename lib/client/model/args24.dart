part of swagger.api;

class Args24 {
  
  String hash = null;
  

  int programID = null;
   // range from 1 to //
  Args24();

  @override
  String toString() {
    return 'Args24[hash=$hash, programID=$programID, ]';
  }

  Args24.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    hash =
      
      
      json['hash']
;
    programID =
        json['programID']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'hash': hash,
      'programID': programID
     };
  }

  static List<Args24> listFromJson(List<dynamic> json) {
    return json == null ? new List<Args24>() : json.map((value) => new Args24.fromJson(value)).toList();
  }

  static Map<String, Args24> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Args24>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Args24.fromJson(value));
    }
    return map;
  }
}

