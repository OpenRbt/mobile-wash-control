part of swagger.api;

class InlineResponse2001 {
  
  List<InlineResponse2001Buttons> buttons = [];
  
  InlineResponse2001();

  @override
  String toString() {
    return 'InlineResponse2001[buttons=$buttons, ]';
  }

  InlineResponse2001.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    buttons =
      InlineResponse2001Buttons.listFromJson(json['buttons'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'buttons': buttons
     };
  }

  static List<InlineResponse2001> listFromJson(List<dynamic> json) {
    return json == null ? new List<InlineResponse2001>() : json.map((value) => new InlineResponse2001.fromJson(value)).toList();
  }

  static Map<String, InlineResponse2001> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse2001>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new InlineResponse2001.fromJson(value));
    }
    return map;
  }
}

