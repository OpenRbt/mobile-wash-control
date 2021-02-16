part of swagger.api;

class Args14 {
  
  int programID = null;
   // range from 1 to //
  Args14();

  @override
  String toString() {
    return 'Args14[programID=$programID, ]';
  }

  Args14.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    programID =
        json['programID']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'programID': programID
     };
  }

  static List<Args14> listFromJson(List<dynamic> json) {
    return json == null ? new List<Args14>() : json.map((value) => new Args14.fromJson(value)).toList();
  }

  static Map<String, Args14> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Args14>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Args14.fromJson(value));
    }
    return map;
  }
}

