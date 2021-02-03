part of swagger.api;

class Args17 {
  
  int stationID = null;
   // range from 1 to //

  int programID = null;
   // range from 1 to //

  List<RelayConfig> relays = [];
  
  Args17();

  @override
  String toString() {
    return 'Args17[stationID=$stationID, programID=$programID, relays=$relays, ]';
  }

  Args17.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    stationID =
        json['stationID']
    ;
    programID =
        json['programID']
    ;
    relays =
      RelayConfig.listFromJson(json['relays'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'stationID': stationID,
      'programID': programID,
      'relays': relays
     };
  }

  static List<Args17> listFromJson(List<dynamic> json) {
    return json == null ? new List<Args17>() : json.map((value) => new Args17.fromJson(value)).toList();
  }

  static Map<String, Args17> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Args17>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Args17.fromJson(value));
    }
    return map;
  }
}

