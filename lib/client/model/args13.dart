part of swagger.api;

class Args13 {
  
  int stationID = null;
  
  Args13();

  @override
  String toString() {
    return 'Args13[stationID=$stationID, ]';
  }

  Args13.fromJson(Map<String, dynamic> json) {
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

  static List<Args13> listFromJson(List<dynamic> json) {
    return json == null ? new List<Args13>() : json.map((value) => new Args13.fromJson(value)).toList();
  }

  static Map<String, Args13> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Args13>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Args13.fromJson(value));
    }
    return map;
  }
}

