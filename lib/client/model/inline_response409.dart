part of swagger.api;

class InlineResponse409 {
  
  int code = null;
  

  String message = null;
  
  InlineResponse409();

  @override
  String toString() {
    return 'InlineResponse409[code=$code, message=$message, ]';
  }

  InlineResponse409.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    code =
        json['code']
    ;
    message =
        json['message']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message
     };
  }

  static List<InlineResponse409> listFromJson(List<dynamic> json) {
    return json == null ? new List<InlineResponse409>() : json.map((value) => new InlineResponse409.fromJson(value)).toList();
  }

  static Map<String, InlineResponse409> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse409>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new InlineResponse409.fromJson(value));
    }
    return map;
  }
}

