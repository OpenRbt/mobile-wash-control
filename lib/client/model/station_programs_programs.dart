part of swagger.api;

class StationProgramsPrograms {
  
  int buttonID = null;
  

  Program program = null;
  
  StationProgramsPrograms();

  @override
  String toString() {
    return 'StationProgramsPrograms[buttonID=$buttonID, program=$program, ]';
  }

  StationProgramsPrograms.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    buttonID =
        json['buttonID']
    ;
    program =
      
      
      new Program.fromJson(json['program'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'buttonID': buttonID,
      'program': program
     };
  }

  static List<StationProgramsPrograms> listFromJson(List<dynamic> json) {
    return json == null ? new List<StationProgramsPrograms>() : json.map((value) => new StationProgramsPrograms.fromJson(value)).toList();
  }

  static Map<String, StationProgramsPrograms> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, StationProgramsPrograms>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new StationProgramsPrograms.fromJson(value));
    }
    return map;
  }
}

