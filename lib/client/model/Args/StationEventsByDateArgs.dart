part of swagger.api;

class StationEventsByDateArgs {

  int stationID = null;

/* Unix time */
  int startDate = null;

/* Unix time */
  int endDate = null;

  StationEventsByDateArgs();

  @override
  String toString() {
    return 'StationEventsByDateArgs[id=$stationID, startDate=$startDate, endDate=$endDate, ]';
  }

  StationEventsByDateArgs.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    stationID =
    json['stationID']
    ;
    startDate =
    json['startDate']
    ;
    endDate =
    json['endDate']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'stationID': stationID,
      'startDate': startDate,
      'endDate': endDate
    };
  }

  static List<StationEventsByDateArgs> listFromJson(List<dynamic> json) {
    return json == null ? new List<StationEventsByDateArgs>() : json.map((value) => new StationEventsByDateArgs.fromJson(value)).toList();
  }

  static Map<String, StationEventsByDateArgs> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, StationEventsByDateArgs>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new StationEventsByDateArgs.fromJson(value));
    }
    return map;
  }
}

