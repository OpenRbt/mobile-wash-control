part of swagger.api;

class StationEventReport {
  
  List<StationEvent> events = [];
  
  StationEventReport();

  @override
  String toString() {
    return 'StationEventReport[events=$events, ]';
  }

  StationEventReport.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    events =
      StationEvent.listFromJson(json['eventsReport'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'events': events
     };
  }

  static List<StationEventReport> listFromJson(List<dynamic> json) {
    return json == null ? new List<StationEventReport>() : json.map((value) => new StationEventReport.fromJson(value)).toList();
  }

  static Map<String, StationEventReport> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, StationEventReport>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new StationEventReport.fromJson(value));
    }
    return map;
  }
}

