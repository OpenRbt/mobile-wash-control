part of swagger.api;

class RunProgramArgs {
  
  String hash = null;
  

  int programID = null;

  bool preflight = null;
   // range from 1 to //
  RunProgramArgs();

  @override
  String toString() {
    return 'Args24[hash=$hash, programID=$programID, preflight=$preflight]';
  }

  RunProgramArgs.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    hash =
      
      
      json['hash']
;
    programID =
        json['programID']
    ;
    preflight =
        json['preflight']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'hash': hash,
      'programID': programID,
      'preflight': preflight
     };
  }

  static List<RunProgramArgs> listFromJson(List<dynamic> json) {
    return json == null ? new List<RunProgramArgs>() : json.map((value) => new RunProgramArgs.fromJson(value)).toList();
  }

  static Map<String, RunProgramArgs> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RunProgramArgs>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new RunProgramArgs.fromJson(value));
    }
    return map;
  }
}

