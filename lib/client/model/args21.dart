part of swagger.api;

class Args21 {
  
  Login login = null;
  

  FirstName firstName = null;
  

  MiddleName middleName = null;
  

  LastName lastName = null;
  

  IsAdmin isAdmin = null;
  

  IsOperator isOperator = null;
  

  IsEngineer isEngineer = null;
  
  Args21();

  @override
  String toString() {
    return 'Args21[login=$login, firstName=$firstName, middleName=$middleName, lastName=$lastName, isAdmin=$isAdmin, isOperator=$isOperator, isEngineer=$isEngineer, ]';
  }

  Args21.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    login =
      
      
      new Login.fromJson(json['login'])
;
    firstName =
      
      
      new FirstName.fromJson(json['firstName'])
;
    middleName =
      
      
      new MiddleName.fromJson(json['middleName'])
;
    lastName =
      
      
      new LastName.fromJson(json['lastName'])
;
    isAdmin =
      
      
      new IsAdmin.fromJson(json['isAdmin'])
;
    isOperator =
      
      
      new IsOperator.fromJson(json['isOperator'])
;
    isEngineer =
      
      
      new IsEngineer.fromJson(json['isEngineer'])
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

