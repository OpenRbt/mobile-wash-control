part of swagger.api;

class RelayStat {
  
  int relayID = null;
   // range from 1 to 6//

  int switchedCount = null;
  

  int totalTimeOn = null;
  
  RelayStat();

  @override
  String toString() {
    return 'RelayStat[relayID=$relayID, switchedCount=$switchedCount, totalTimeOn=$totalTimeOn, ]';
  }

  RelayStat.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    relayID =
        json['relayID']
    ;
    switchedCount =
        json['switchedCount']
    ;
    totalTimeOn =
        json['totalTimeOn']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'relayID': relayID,
      'switchedCount': switchedCount,
      'totalTimeOn': totalTimeOn
     };
  }

  static List<RelayStat> listFromJson(List<dynamic> json) {
    return json == null ? new List<RelayStat>() : json.map((value) => new RelayStat.fromJson(value)).toList();
  }

  static Map<String, RelayStat> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RelayStat>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new RelayStat.fromJson(value));
    }
    return map;
  }
}

