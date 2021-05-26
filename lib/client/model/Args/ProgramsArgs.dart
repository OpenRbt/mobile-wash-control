part of swagger.api;

class ProgramsArgs {
  
  int programID = null;
   // range from 1 to //
  ProgramsArgs();

  @override
  String toString() {
    return 'Args14[programID=$programID, ]';
  }

  ProgramsArgs.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    programID =
        json['programID']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'programID': programID
     };
  }

  static List<ProgramsArgs> listFromJson(List<dynamic> json) {
    return json == null ? new List<ProgramsArgs>() : json.map((value) => new ProgramsArgs.fromJson(value)).toList();
  }

  static Map<String, ProgramsArgs> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ProgramsArgs>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new ProgramsArgs.fromJson(value));
    }
    return map;
  }
}

