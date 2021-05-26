part of swagger.api;

class StationReport {
  
  MoneyReport moneyReport = null;
  

  List<RelayStat> relayStats = [];
  
  StationReport();

  @override
  String toString() {
    return 'StationReport[moneyReport=$moneyReport, relayStats=$relayStats, ]';
  }

  StationReport.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    moneyReport =
      
      
      new MoneyReport.fromJson(json['moneyReport'])
;
    relayStats =
      RelayStat.listFromJson(json['relayStats'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'moneyReport': moneyReport,
      'relayStats': relayStats
     };
  }

  static List<StationReport> listFromJson(List<dynamic> json) {
    return json == null ? new List<StationReport>() : json.map((value) => new StationReport.fromJson(value)).toList();
  }

  static Map<String, StationReport> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, StationReport>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new StationReport.fromJson(value));
    }
    return map;
  }
}

