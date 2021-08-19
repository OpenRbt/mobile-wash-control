part of swagger.api;

class Program {
  
  int id = null;
   // range from 1 to //

  String name = null;
  

  int price = null;
  

  bool preflightEnabled = null;
  

  bool isFinishingProgram = null;
  

  int motorSpeedPercent = null;
   // range from 0 to 100//

  int preflightMotorSpeedPercent = null;
   // range from 0 to 100//

  List<RelayConfig> relays = [];
  

  List<RelayConfig> preflightRelays = [];
  
  Program();

  @override
  String toString() {
    return 'Program[id=$id, name=$name, price=$price, preflightEnabled=$preflightEnabled, isFinishingProgram=$isFinishingProgram, motorSpeedPercent=$motorSpeedPercent, preflightMotorSpeedPercent=$preflightMotorSpeedPercent, relays=$relays, preflightRelays=$preflightRelays, ]';
  }

  Program.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id =
        json['id']
    ;
    name =
        json['name']
    ;
    price =
        json['price']
    ;
    preflightEnabled =
        json['preflightEnabled']
    ;
    isFinishingProgram =
        json['isFinishingProgram']
    ;
    motorSpeedPercent =
        json['motorSpeedPercent']
    ;
    preflightMotorSpeedPercent =
        json['preflightMotorSpeedPercent']
    ;
    relays =
      RelayConfig.listFromJson(json['relays'])
;
    preflightRelays =
      RelayConfig.listFromJson(json['preflightRelays'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'preflightEnabled': preflightEnabled,
      'isFinishingProgram': isFinishingProgram,
      'motorSpeedPercent': motorSpeedPercent,
      'preflightMotorSpeedPercent': preflightMotorSpeedPercent,
      'relays': relays,
      'preflightRelays': preflightRelays
     };
  }

  static List<Program> listFromJson(List<dynamic> json) {
    return json == null ? new List<Program>() : json.map((value) => new Program.fromJson(value)).toList();
  }

  static Map<String, Program> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Program>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Program.fromJson(value));
    }
    return map;
  }
}

