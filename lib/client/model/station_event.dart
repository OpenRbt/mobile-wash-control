part of swagger.api;

class StationEvent {
  
  int stationID = null;
  

  int ctime = null;
  

  String module = null;
  

  String status = null;
  //enum statusEnum {  OK,  WARNING,  ERROR,  CRITICAL,  };

  String info = null;
  
  StationEvent();

  @override
  String toString() {
    return 'StationEvent[stationID=$stationID, ctime=$ctime, module=$module, status=$status, info=$info, ]';
  }

  StationEvent.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    stationID =
        json['stationID']
    ;
    ctime =
        json['ctime']
    ;
    module =
        json['module']
    ;
    status =
        json['status']
    ;
    info =
        json['info']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'stationID': stationID,
      'ctime': ctime,
      'module': module,
      'status': status,
      'info': info
     };
  }

  static List<StationEvent> listFromJson(List<dynamic> json) {
    return json == null ? new List<StationEvent>() : json.map((value) => new StationEvent.fromJson(value)).toList();
  }

  static Map<String, StationEvent> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, StationEvent>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new StationEvent.fromJson(value));
    }
    return map;
  }
}

