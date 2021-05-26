part of swagger.api;

class StatusCollectionReport {
  
  List<CollectionReport> stations = [];
  
  StatusCollectionReport();

  @override
  String toString() {
    return 'StatusCollectionReport[stations=$stations, ]';
  }

  StatusCollectionReport.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    stations =
      CollectionReport.listFromJson(json['stations'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'stations': stations
     };
  }

  static List<StatusCollectionReport> listFromJson(List<dynamic> json) {
    return json == null ? new List<StatusCollectionReport>() : json.map((value) => new StatusCollectionReport.fromJson(value)).toList();
  }

  static Map<String, StatusCollectionReport> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, StatusCollectionReport>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new StatusCollectionReport.fromJson(value));
    }
    return map;
  }
}

