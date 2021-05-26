part of swagger.api;

class CreateUserArgs {
  
  String login = null;
  

  String firstName = null;
  

  String middleName = null;
  

  String lastName = null;
  

  bool isAdmin = null;
  

  bool isOperator = null;
  

  bool isEngineer = null;
  

  String password = null;
  
  CreateUserArgs();

  @override
  String toString() {
    return 'Args22[login=$login, firstName=$firstName, middleName=$middleName, lastName=$lastName, isAdmin=$isAdmin, isOperator=$isOperator, isEngineer=$isEngineer, password=$password, ]';
  }

  CreateUserArgs.fromJson(Map<String, dynamic> json) {
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

  static List<CreateUserArgs> listFromJson(List<dynamic> json) {
    return json == null ? new List<CreateUserArgs>() : json.map((value) => new CreateUserArgs.fromJson(value)).toList();
  }

  static Map<String, CreateUserArgs> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CreateUserArgs>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new CreateUserArgs.fromJson(value));
    }
    return map;
  }
}

