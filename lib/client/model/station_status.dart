part of swagger.api;

class StationStatus {
  
  int id = null;
  

  String name = null;
  

  String hash = null;
  

  Status status = null;
  

  String info = null;
  
  StationStatus();

  @override
  String toString() {
    return 'StationStatus[id=$id, name=$name, hash=$hash, status=$status, info=$info, ]';
  }

  StationStatus.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id =
        json['id']
    ;
    name =
        json['name']
    ;
    hash =
      
      
      json['hash']
;
    status =
      
      
      new Status.fromJson(json['status'])
;
    info =
        json['info']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'hash': hash,
      'status': status,
      'info': info
     };
  }

  static List<StationStatus> listFromJson(List<dynamic> json) {
    return json == null ? new List<StationStatus>() : json.map((value) => new StationStatus.fromJson(value)).toList();
  }

  static Map<String, StationStatus> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, StationStatus>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new StationStatus.fromJson(value));
    }
    return map;
  }
}

