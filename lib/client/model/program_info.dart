part of swagger.api;

class ProgramInfo {
  
  int id = null;
   // range from 1 to //

  String name = null;
  
  ProgramInfo();

  @override
  String toString() {
    return 'ProgramInfo[id=$id, name=$name, ]';
  }

  ProgramInfo.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id =
        json['id']
    ;
    name =
        json['name']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name
     };
  }

  static List<ProgramInfo> listFromJson(List<dynamic> json) {
    return json == null ? new List<ProgramInfo>() : json.map((value) => new ProgramInfo.fromJson(value)).toList();
  }

  static Map<String, ProgramInfo> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ProgramInfo>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new ProgramInfo.fromJson(value));
    }
    return map;
  }
}

