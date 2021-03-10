part of swagger.api;

class StationReportDatesArgs {
  
  int id = null;
  
/* Unix time */
  int startDate = null;
  
/* Unix time */
  int endDate = null;
  
  StationReportDatesArgs();

  @override
  String toString() {
    return 'Args[id=$id, startDate=$startDate, endDate=$endDate, ]';
  }

  StationReportDatesArgs.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id =
        json['id']
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
      'id': id,
      'startDate': startDate,
      'endDate': endDate
     };
  }

  static List<StationReportDatesArgs> listFromJson(List<dynamic> json) {
    return json == null ? new List<StationReportDatesArgs>() : json.map((value) => new StationReportDatesArgs.fromJson(value)).toList();
  }

  static Map<String, StationReportDatesArgs> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, StationReportDatesArgs>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new StationReportDatesArgs.fromJson(value));
    }
    return map;
  }
}

