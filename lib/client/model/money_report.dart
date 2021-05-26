part of swagger.api;

class MoneyReport {
  
  int carsTotal = null;
  

  int coins = null;
  

  int banknotes = null;
  

  int electronical = null;
  

  int service = null;
  

  String hash = null;
  
  MoneyReport();

  @override
  String toString() {
    return 'MoneyReport[carsTotal=$carsTotal, coins=$coins, banknotes=$banknotes, electronical=$electronical, service=$service, hash=$hash, ]';
  }

  MoneyReport.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    carsTotal =
        json['carsTotal']
    ;
    coins =
        json['coins']
    ;
    banknotes =
        json['banknotes']
    ;
    electronical =
        json['electronical']
    ;
    service =
        json['service']
    ;
    hash =
      
      
      json['hash']
;
  }

  Map<String, dynamic> toJson() {
    return {
      'carsTotal': carsTotal,
      'coins': coins,
      'banknotes': banknotes,
      'electronical': electronical,
      'service': service,
      'hash': hash
     };
  }

  static List<MoneyReport> listFromJson(List<dynamic> json) {
    return json == null ? new List<MoneyReport>() : json.map((value) => new MoneyReport.fromJson(value)).toList();
  }

  static Map<String, MoneyReport> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MoneyReport>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new MoneyReport.fromJson(value));
    }
    return map;
  }
}

