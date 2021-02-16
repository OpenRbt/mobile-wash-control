part of swagger.api;

class StationPrograms {
  
  int stationID = null;
  

  String name = null;
  

  int preflightSec = null;
  

  List<StationProgramsPrograms> programs = [];
  
  StationPrograms();

  @override
  String toString() {
    return 'StationPrograms[stationID=$stationID, name=$name, preflightSec=$preflightSec, programs=$programs, ]';
  }

  StationPrograms.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    stationID =
        json['stationID']
    ;
    name =
        json['name']
    ;
    preflightSec =
        json['preflightSec']
    ;
    programs =
      StationProgramsPrograms.listFromJson(json['programs'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'stationID': stationID,
      'name': name,
      'preflightSec': preflightSec,
      'programs': programs
     };
  }

  static List<StationPrograms> listFromJson(List<dynamic> json) {
    return json == null ? new List<StationPrograms>() : json.map((value) => new StationPrograms.fromJson(value)).toList();
  }

  static Map<String, StationPrograms> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, StationPrograms>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new StationPrograms.fromJson(value));
    }
    return map;
  }
}

