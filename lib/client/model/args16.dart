part of swagger.api;

class Args16 {
  
  int stationID = null;
   // range from 1 to //

  int programID = null;
   // range from 1 to //
  Args16();

  @override
  String toString() {
    return 'Args16[stationID=$stationID, programID=$programID, ]';
  }

  Args16.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    stationID =
        json['stationID']
    ;
    programID =
        json['programID']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'stationID': stationID,
      'programID': programID
     };
  }

  static List<Args16> listFromJson(List<dynamic> json) {
    return json == null ? new List<Args16>() : json.map((value) => new Args16.fromJson(value)).toList();
  }

  static Map<String, Args16> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Args16>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Args16.fromJson(value));
    }
    return map;
  }
}

