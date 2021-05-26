part of swagger.api;

class DelStationArgs {
  
  int id = null;
  
  DelStationArgs();

  @override
  String toString() {
    return 'Args4[id=$id, ]';
  }

  DelStationArgs.fromJson(Map<String, dynamic> json) {
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

  static List<DelStationArgs> listFromJson(List<dynamic> json) {
    return json == null ? new List<DelStationArgs>() : json.map((value) => new DelStationArgs.fromJson(value)).toList();
  }

  static Map<String, DelStationArgs> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, DelStationArgs>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new DelStationArgs.fromJson(value));
    }
    return map;
  }
}

