part of swagger.api;

class StationArgs {
  
  int id = null;
  
  StationArgs();

  @override
  String toString() {
    return 'Args3[id=$id, ]';
  }

  StationArgs.fromJson(Map<String, dynamic> json) {
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

  static List<StationArgs> listFromJson(List<dynamic> json) {
    return json == null ? new List<StationArgs>() : json.map((value) => new StationArgs.fromJson(value)).toList();
  }

  static Map<String, StationArgs> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, StationArgs>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new StationArgs.fromJson(value));
    }
    return map;
  }
}

