part of swagger.api;

class CardReaderConfigArgs {
  
  int stationID = null;
   // range from 1 to //
  CardReaderConfigArgs();

  @override
  String toString() {
    return 'Args18[stationID=$stationID, ]';
  }

  CardReaderConfigArgs.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    stationID =
        json['stationID']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'stationID': stationID
     };
  }

  static List<CardReaderConfigArgs> listFromJson(List<dynamic> json) {
    return json == null ? new List<CardReaderConfigArgs>() : json.map((value) => new CardReaderConfigArgs.fromJson(value)).toList();
  }

  static Map<String, CardReaderConfigArgs> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CardReaderConfigArgs>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new CardReaderConfigArgs.fromJson(value));
    }
    return map;
  }
}

