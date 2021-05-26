part of swagger.api;

class CardReaderConfig {
  
  int stationID = null;
  

  String cardReaderType = null;
  //enum cardReaderTypeEnum {  NOT_USED,  VENDOTEK,  PAYMENT_WORLD,  };

  String host = null;
  

  String port = null;
  
  CardReaderConfig();

  @override
  String toString() {
    return 'CardReaderConfig[stationID=$stationID, cardReaderType=$cardReaderType, host=$host, port=$port, ]';
  }

  CardReaderConfig.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    stationID =
        json['stationID']
    ;
    cardReaderType =
        json['cardReaderType']
    ;
    host =
        json['host']
    ;
    port =
        json['port']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'stationID': stationID,
      'cardReaderType': cardReaderType,
      'host': host,
      'port': port
     };
  }

  static List<CardReaderConfig> listFromJson(List<dynamic> json) {
    return json == null ? new List<CardReaderConfig>() : json.map((value) => new CardReaderConfig.fromJson(value)).toList();
  }

  static Map<String, CardReaderConfig> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CardReaderConfig>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new CardReaderConfig.fromJson(value));
    }
    return map;
  }
}

