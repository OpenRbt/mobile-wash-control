part of swagger.api;

class KasseConfig {
  
  String tax = null;
  //enum taxEnum {  TAX_VAT110,  TAX_VAT0,  TAX_NO,  TAX_VAT120,  };

  String receiptItemName = null;
  

  String cashier = null;
  

  String cashierINN = null;
  
  KasseConfig();

  @override
  String toString() {
    return 'KasseConfig[tax=$tax, receiptItemName=$receiptItemName, cashier=$cashier, cashierINN=$cashierINN, ]';
  }

  KasseConfig.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    tax =
        json['tax']
    ;
    receiptItemName =
        json['receiptItemName']
    ;
    cashier =
        json['cashier']
    ;
    cashierINN =
        json['cashierINN']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'tax': tax,
      'receiptItemName': receiptItemName,
      'cashier': cashier,
      'cashierINN': cashierINN
     };
  }

  static List<KasseConfig> listFromJson(List<dynamic> json) {
    return json == null ? new List<KasseConfig>() : json.map((value) => new KasseConfig.fromJson(value)).toList();
  }

  static Map<String, KasseConfig> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, KasseConfig>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new KasseConfig.fromJson(value));
    }
    return map;
  }
}

