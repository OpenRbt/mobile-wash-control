part of swagger.api;

class StationStatus {
  
  int id = null;
  

  String name = null;


  String ip = null;
  

  String hash = null;
  

  Status status = null;
  

  String info = null;
  

  int currentBalance = null;
  

  int currentProgram = null;

  String currentProgramName = null;
  
  StationStatus();

  @override
  String toString() {
    return 'StationStatus[id=$id, name=$name, ip = $ip, hash=$hash, status=$status, info=$info, currentBalance=$currentBalance, currentProgram=$currentProgram, currentProgramName=$currentProgramName]';
  }

  StationStatus.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id =
        json['id']
    ;
    name =
        json['name']
    ;
    ip =
        json['ip']
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
    currentBalance =
        json['currentBalance']
    ;
    currentProgram =
        json['currentProgram']
    ;
    currentProgramName =
        json['currentProgramName']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ip': ip,
      'hash': hash,
      'status': status,
      'info': info,
      'currentBalance': currentBalance,
      'currentProgram': currentProgram,
      'currentProgramName': currentProgramName,
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

