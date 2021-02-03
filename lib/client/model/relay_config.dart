part of swagger.api;

class RelayConfig {
  
  int id = null;
   // range from 1 to //

  int timeon = null;
  

  int timeoff = null;
  

  int prfelight = null;
  
  RelayConfig();

  @override
  String toString() {
    return 'RelayConfig[id=$id, timeon=$timeon, timeoff=$timeoff, prfelight=$prfelight, ]';
  }

  RelayConfig.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id =
        json['id']
    ;
    timeon =
        json['timeon']
    ;
    timeoff =
        json['timeoff']
    ;
    prfelight =
        json['prfelight']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timeon': timeon,
      'timeoff': timeoff,
      'prfelight': prfelight
     };
  }

  static List<RelayConfig> listFromJson(List<dynamic> json) {
    return json == null ? new List<RelayConfig>() : json.map((value) => new RelayConfig.fromJson(value)).toList();
  }

  static Map<String, RelayConfig> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RelayConfig>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new RelayConfig.fromJson(value));
    }
    return map;
  }
}

