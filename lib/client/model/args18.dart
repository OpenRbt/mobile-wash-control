part of swagger.api;

class Args18 {
  
  int stationID = null;
   // range from 1 to //
  Args18();

  @override
  String toString() {
    return 'Args18[stationID=$stationID, ]';
  }

  Args18.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    stationID =
        json['stationID']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'stationID': stationID
     };
  }

  static List<Args18> listFromJson(List<dynamic> json) {
    return json == null ? new List<Args18>() : json.map((value) => new Args18.fromJson(value)).toList();
  }

  static Map<String, Args18> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Args18>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Args18.fromJson(value));
    }
    return map;
  }
}

