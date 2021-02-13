part of swagger.api;

class Args22 {
  
  Login login = null;
  

  FirstName firstName = null;
  

  MiddleName middleName = null;
  

  LastName lastName = null;
  

  IsAdmin isAdmin = null;
  

  IsOperator isOperator = null;
  

  IsEngineer isEngineer = null;
  

  Password password = null;
  
  Args22();

  @override
  String toString() {
    return 'Args22[login=$login, firstName=$firstName, middleName=$middleName, lastName=$lastName, isAdmin=$isAdmin, isOperator=$isOperator, isEngineer=$isEngineer, password=$password, ]';
  }

  Args22.fromJson(Map<String, dynamic> json) {
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
    password =
      
      
      new Password.fromJson(json['password'])
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

