part of swagger.api;

class StationConfig {
  
  int id = null;
  

  int preflightSec = null;
  

  String name = null;
  

  String hash = null;
  

  String relayBoard = null;
  
  StationConfig();

  @override
  String toString() {
    return 'StationConfig[id=$id, preflightSec=$preflightSec, name=$name, hash=$hash, relayBoard=$relayBoard, ]';
  }

  StationConfig.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id =
        json['id']
    ;
    preflightSec =
        json['preflightSec']
    ;
    name =
        json['name']
    ;
    hash =
        json['hash']
    ;
    relayBoard =
      
      
     json['relayBoard']
;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'preflightSec': preflightSec,
      'name': name,
      'hash': hash,
      'relayBoard': relayBoard
     };
  }

  static List<StationConfig> listFromJson(List<dynamic> json) {
    return json == null ? new List<StationConfig>() : json.map((value) => new StationConfig.fromJson(value)).toList();
  }

  static Map<String, StationConfig> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, StationConfig>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new StationConfig.fromJson(value));
    }
    return map;
  }
}

