part of swagger.api;

class OpenStationArgs {
  
  int stationID = null;
  
  OpenStationArgs();

  @override
  String toString() {
    return 'Args13[stationID=$stationID, ]';
  }

  OpenStationArgs.fromJson(Map<String, dynamic> json) {
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

  static List<OpenStationArgs> listFromJson(List<dynamic> json) {
    return json == null ? new List<OpenStationArgs>() : json.map((value) => new OpenStationArgs.fromJson(value)).toList();
  }

  static Map<String, OpenStationArgs> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, OpenStationArgs>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new OpenStationArgs.fromJson(value));
    }
    return map;
  }
}

