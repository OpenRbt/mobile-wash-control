part of swagger.api;

class RelayReport {
  
  Hash hash = null;
  

  List<RelayStat> relayStats = [];
  
  RelayReport();

  @override
  String toString() {
    return 'RelayReport[hash=$hash, relayStats=$relayStats, ]';
  }

  RelayReport.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    hash =
      
      
      new Hash.fromJson(json['hash'])
;
    relayStats =
      RelayStat.listFromJson(json['relayStats'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'hash': hash,
      'relayStats': relayStats
     };
  }

  static List<RelayReport> listFromJson(List<dynamic> json) {
    return json == null ? new List<RelayReport>() : json.map((value) => new RelayReport.fromJson(value)).toList();
  }

  static Map<String, RelayReport> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RelayReport>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new RelayReport.fromJson(value));
    }
    return map;
  }
}

