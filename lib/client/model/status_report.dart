part of swagger.api;

class StatusReport {
  
  String lcwInfo = null;
  

  Status kasseStatus = null;
  

  String kasseInfo = null;
  

  List<StationStatus> stations = [];
  
  StatusReport();

  @override
  String toString() {
    return 'StatusReport[lcwInfo=$lcwInfo, kasseStatus=$kasseStatus, kasseInfo=$kasseInfo, stations=$stations, ]';
  }

  StatusReport.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    lcwInfo =
        json['lcw_info']
    ;
    kasseStatus =
      
      
      new Status.fromJson(json['kasse_status'])
;
    kasseInfo =
        json['kasse_info']
    ;
    stations =
      StationStatus.listFromJson(json['stations'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'lcw_info': lcwInfo,
      'kasse_status': kasseStatus,
      'kasse_info': kasseInfo,
      'stations': stations
     };
  }

  static List<StatusReport> listFromJson(List<dynamic> json) {
    return json == null ? new List<StatusReport>() : json.map((value) => new StatusReport.fromJson(value)).toList();
  }

  static Map<String, StatusReport> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, StatusReport>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new StatusReport.fromJson(value));
    }
    return map;
  }
}

