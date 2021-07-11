part of swagger.api;

class StationLastEvents {
  
  int okCtime = null;
  

  int warningCtime = null;
  

  int errorCtime = null;
  

  int criticalCtime = null;
  
  StationLastEvents();

  @override
  String toString() {
    return 'StationLastEvents[okCtime=$okCtime, warningCtime=$warningCtime, errorCtime=$errorCtime, criticalCtime=$criticalCtime, ]';
  }

  StationLastEvents.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    okCtime =
        json['ok_ctime']
    ;
    warningCtime =
        json['warning_ctime']
    ;
    errorCtime =
        json['error_ctime']
    ;
    criticalCtime =
        json['critical_ctime']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'ok_ctime': okCtime,
      'warning_ctime': warningCtime,
      'error_ctime': errorCtime,
      'critical_ctime': criticalCtime
     };
  }

  static List<StationLastEvents> listFromJson(List<dynamic> json) {
    return json == null ? new List<StationLastEvents>() : json.map((value) => new StationLastEvents.fromJson(value)).toList();
  }

  static Map<String, StationLastEvents> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, StationLastEvents>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new StationLastEvents.fromJson(value));
    }
    return map;
  }
}

