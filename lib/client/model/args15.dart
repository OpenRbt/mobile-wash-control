part of swagger.api;

class Args15 {
  
  int stationID = null;
   // range from 1 to //

  int programID = null;
   // range from 1 to //

  String name = null;
  
  Args15();

  @override
  String toString() {
    return 'Args15[stationID=$stationID, programID=$programID, name=$name, ]';
  }

  Args15.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    stationID =
        json['stationID']
    ;
    programID =
        json['programID']
    ;
    name =
        json['name']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'stationID': stationID,
      'programID': programID,
      'name': name
     };
  }

  static List<Args15> listFromJson(List<dynamic> json) {
    return json == null ? new List<Args15>() : json.map((value) => new Args15.fromJson(value)).toList();
  }

  static Map<String, Args15> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Args15>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Args15.fromJson(value));
    }
    return map;
  }
}

