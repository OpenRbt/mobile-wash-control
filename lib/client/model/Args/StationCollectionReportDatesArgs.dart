part of swagger.api;

class StationCollectionReportDatesArgs {
  
  int stationID = null;
  
/* Unix time */
  int startDate = null;
  
/* Unix time */
  int endDate = null;
  
  StationCollectionReportDatesArgs();

  @override
  String toString() {
    return 'Args[stationID=$stationID, startDate=$startDate, endDate=$endDate, ]';
  }

  StationCollectionReportDatesArgs.fromJson(Map<String, dynamic> json) {
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

  static List<StationCollectionReportDatesArgs> listFromJson(List<dynamic> json) {
    return json == null ? new List<StationCollectionReportDatesArgs>() : json.map((value) => new StationCollectionReportDatesArgs.fromJson(value)).toList();
  }

  static Map<String, StationCollectionReportDatesArgs> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, StationCollectionReportDatesArgs>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new StationCollectionReportDatesArgs.fromJson(value));
    }
    return map;
  }
}
