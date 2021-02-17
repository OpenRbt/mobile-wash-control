part of swagger.api;

class Args21 {

  String login = null;
  

  String firstName = null;


  String middleName = null;


  String lastName = null;
  

  bool isAdmin = null;


  bool isOperator = null;


  bool isEngineer = null;
  
  Args21();

  @override
  String toString() {
    return 'Args21[login=$login, firstName=$firstName, middleName=$middleName, lastName=$lastName, isAdmin=$isAdmin, isOperator=$isOperator, isEngineer=$isEngineer, ]';
  }

  Args21.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    login =
      
      
     json['login']
;
    firstName =
      
      
      json['firstName']
;
    middleName =
      
      
      json['middleName']
;
    lastName =
      
      
      json['lastName']
;
    isAdmin =
      
      
      json['isAdmin']
;
    isOperator =
      
      
     json['isOperator']
;
    isEngineer =
      
      
      json['isEngineer']
;
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'isAdmin': isAdmin,
      'isOperator': isOperator,
      'isEngineer': isEngineer
     };
  }

  static List<Args21> listFromJson(List<dynamic> json) {
    return json == null ? new List<Args21>() : json.map((value) => new Args21.fromJson(value)).toList();
  }

  static Map<String, Args21> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Args21>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Args21.fromJson(value));
    }
    return map;
  }
}

