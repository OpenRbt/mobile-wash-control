part of swagger.api;

class InlineResponse200 {
  
  int serviceAmount = null;
  

  bool openStation = null;
  
  InlineResponse200();

  @override
  String toString() {
    return 'InlineResponse200[serviceAmount=$serviceAmount, openStation=$openStation, ]';
  }

  InlineResponse200.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    serviceAmount =
        json['serviceAmount']
    ;
    openStation =
        json['openStation']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'serviceAmount': serviceAmount,
      'openStation': openStation
     };
  }

  static List<InlineResponse200> listFromJson(List<dynamic> json) {
    return json == null ? new List<InlineResponse200>() : json.map((value) => new InlineResponse200.fromJson(value)).toList();
  }

  static Map<String, InlineResponse200> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse200>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new InlineResponse200.fromJson(value));
    }
    return map;
  }
}

