part of swagger.api;

class StationReportCurrentMoneyArgs {
  
  int id = null;
  
  StationReportCurrentMoneyArgs();

  @override
  String toString() {
    return 'Args1[id=$id, ]';
  }

  StationReportCurrentMoneyArgs.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id =
        json['id']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id
     };
  }

  static List<StationReportCurrentMoneyArgs> listFromJson(List<dynamic> json) {
    return json == null ? new List<StationReportCurrentMoneyArgs>() : json.map((value) => new StationReportCurrentMoneyArgs.fromJson(value)).toList();
  }

  static Map<String, StationReportCurrentMoneyArgs> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, StationReportCurrentMoneyArgs>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new StationReportCurrentMoneyArgs.fromJson(value));
    }
    return map;
  }
}

