part of swagger.api;

class CollectionReport {
  
  int id = null;
  

  int carsTotal = null;
  

  int coins = null;
  

  int banknotes = null;
  

  int electronical = null;
  

  int service = null;
  

  int ctime = null;
  
  CollectionReport();

  @override
  String toString() {
    return 'CollectionReport[id=$id, carsTotal=$carsTotal, coins=$coins, banknotes=$banknotes, electronical=$electronical, service=$service, ctime=$ctime, ]';
  }

  CollectionReport.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id =
        json['id']
    ;
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
    ctime =
        json['ctime']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'carsTotal': carsTotal,
      'coins': coins,
      'banknotes': banknotes,
      'electronical': electronical,
      'service': service,
      'ctime': ctime
     };
  }

  static List<CollectionReport> listFromJson(List<dynamic> json) {
    return json == null ? new List<CollectionReport>() : json.map((value) => new CollectionReport.fromJson(value)).toList();
  }

  static Map<String, CollectionReport> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CollectionReport>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new CollectionReport.fromJson(value));
    }
    return map;
  }
}

