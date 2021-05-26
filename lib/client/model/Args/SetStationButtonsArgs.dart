part of swagger.api;

class SetStationButtonsArgs {
  
  int stationID = null;
   // range from 1 to //

  List<InlineResponse2001Buttons> buttons = [];
  
  SetStationButtonsArgs();

  @override
  String toString() {
    return 'Args17[stationID=$stationID, buttons=$buttons, ]';
  }

  SetStationButtonsArgs.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    stationID =
        json['stationID']
    ;
    buttons =
      InlineResponse2001Buttons.listFromJson(json['buttons'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'stationID': stationID,
      'buttons': buttons
     };
  }

  static List<SetStationButtonsArgs> listFromJson(List<dynamic> json) {
    return json == null ? new List<SetStationButtonsArgs>() : json.map((value) => new SetStationButtonsArgs.fromJson(value)).toList();
  }

  static Map<String, SetStationButtonsArgs> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, SetStationButtonsArgs>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new SetStationButtonsArgs.fromJson(value));
    }
    return map;
  }
}

