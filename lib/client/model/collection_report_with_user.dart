part of swagger.api;

class CollectionReportWithUser {
  
  int id = null;
  

  int carsTotal = null;
  

  int coins = null;
  

  int banknotes = null;
  

  int electronical = null;
  

  int service = null;
  

  int ctime = null;
  

  String user = null;
  
  CollectionReportWithUser();

  @override
  String toString() {
    return 'CollectionReportWithUser[id=$id, carsTotal=$carsTotal, coins=$coins, banknotes=$banknotes, electronical=$electronical, service=$service, ctime=$ctime, user=$user, ]';
  }

  CollectionReportWithUser.fromJson(Map<String, dynamic> json) {
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
    user =
        json['user']
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
      'ctime': ctime,
      'user': user
     };
  }

  static List<CollectionReportWithUser> listFromJson(List<dynamic> json) {
    return json == null ? new List<CollectionReportWithUser>() : json.map((value) => new CollectionReportWithUser.fromJson(value)).toList();
  }

  static Map<String, CollectionReportWithUser> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CollectionReportWithUser>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new CollectionReportWithUser.fromJson(value));
    }
    return map;
  }
}

