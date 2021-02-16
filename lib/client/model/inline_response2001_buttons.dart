part of swagger.api;

class InlineResponse2001Buttons {
  
  int buttonID = null;
  

  int programID = null;
  
  InlineResponse2001Buttons();

  @override
  String toString() {
    return 'InlineResponse2001Buttons[buttonID=$buttonID, programID=$programID, ]';
  }

  InlineResponse2001Buttons.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    buttonID =
        json['buttonID']
    ;
    programID =
        json['programID']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'buttonID': buttonID,
      'programID': programID
     };
  }

  static List<InlineResponse2001Buttons> listFromJson(List<dynamic> json) {
    return json == null ? new List<InlineResponse2001Buttons>() : json.map((value) => new InlineResponse2001Buttons.fromJson(value)).toList();
  }

  static Map<String, InlineResponse2001Buttons> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse2001Buttons>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new InlineResponse2001Buttons.fromJson(value));
    }
    return map;
  }
}

