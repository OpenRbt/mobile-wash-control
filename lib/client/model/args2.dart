part of swagger.api;

class Args2 {
  
  String hash = null;
  

  int amount = null;
  
  Args2();

  @override
  String toString() {
    return 'Args2[hash=$hash, amount=$amount, ]';
  }

  Args2.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    hash =
        json['hash']
    ;
    amount =
        json['amount']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'hash': hash,
      'amount': amount
     };
  }

  static List<Args2> listFromJson(List<dynamic> json) {
    return json == null ? new List<Args2>() : json.map((value) => new Args2.fromJson(value)).toList();
  }

  static Map<String, Args2> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Args2>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Args2.fromJson(value));
    }
    return map;
  }
}

