part of swagger.api;

class Args22 {

  String login = null;


  String firstName = null;


  String middleName = null;


  String lastName = null;


  bool isAdmin = null;


  bool isOperator = null;


  bool isEngineer = null;
  

  String password = null;
  
  Args22();

  @override
  String toString() {
    return 'Args22[login=$login, firstName=$firstName, middleName=$middleName, lastName=$lastName, isAdmin=$isAdmin, isOperator=$isOperator, isEngineer=$isEngineer, password=$password, ]';
  }

  Args22.fromJson(Map<String, dynamic> json) {
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
    password =
      
      
     json['password']
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
      'isEngineer': isEngineer,
      'password': password
     };
  }

  static List<Args22> listFromJson(List<dynamic> json) {
    return json == null ? new List<Args22>() : json.map((value) => new Args22.fromJson(value)).toList();
  }

  static Map<String, Args22> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Args22>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Args22.fromJson(value));
    }
    return map;
  }
}

