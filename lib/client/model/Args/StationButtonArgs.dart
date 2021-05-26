part of swagger.api;

class StationButtonArgs {
  
  int stationID = null;
   // range from 1 to //
  StationButtonArgs();

  @override
  String toString() {
    return 'Args16[stationID=$stationID, ]';
  }

  StationButtonArgs.fromJson(Map<String, dynamic> json) {
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

  static List<StationButtonArgs> listFromJson(List<dynamic> json) {
    return json == null ? new List<StationButtonArgs>() : json.map((value) => new StationButtonArgs.fromJson(value)).toList();
  }

  static Map<String, StationButtonArgs> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, StationButtonArgs>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new StationButtonArgs.fromJson(value));
    }
    return map;
  }
}

