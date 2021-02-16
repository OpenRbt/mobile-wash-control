part of swagger.api;

class Program {
  
  int id = null;
  

  String name = null;
  

  int price = null;
  

  bool preflightEnabled = null;
  

  List<RelayConfig> relays = [];
  

  List<RelayConfig> preflightRelays = [];
  
  Program();

  @override
  String toString() {
    return 'Program[id=$id, name=$name, price=$price, preflightEnabled=$preflightEnabled, relays=$relays, preflightRelays=$preflightRelays, ]';
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

