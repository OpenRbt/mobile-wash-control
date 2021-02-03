part of swagger.api;

class Args {
  
  int id = null;
  
/* Unix time */
  int startDate = null;
  
/* Unix time */
  int endDate = null;
  
  Args();

  @override
  String toString() {
    return 'Args[id=$id, startDate=$startDate, endDate=$endDate, ]';
  }

  Args.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id =
        json['id']
    ;
    startDate =
        json['startDate']
    ;
    endDate =
        json['endDate']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startDate': startDate,
      'endDate': endDate
     };
  }

  static List<Args> listFromJson(List<dynamic> json) {
    return json == null ? new List<Args>() : json.map((value) => new Args.fromJson(value)).toList();
  }

  static Map<String, Args> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Args>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Args.fromJson(value));
    }
    return map;
  }
}

