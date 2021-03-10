part of swagger.api;

class AddServiceAmountArgs {
  
  String hash = null;
  

  int amount = null;
  
  AddServiceAmountArgs();

  @override
  String toString() {
    return 'Args2[hash=$hash, amount=$amount, ]';
  }

  AddServiceAmountArgs.fromJson(Map<String, dynamic> json) {
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

  static List<AddServiceAmountArgs> listFromJson(List<dynamic> json) {
    return json == null ? new List<AddServiceAmountArgs>() : json.map((value) => new AddServiceAmountArgs.fromJson(value)).toList();
  }

  static Map<String, AddServiceAmountArgs> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AddServiceAmountArgs>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new AddServiceAmountArgs.fromJson(value));
    }
    return map;
  }
}

