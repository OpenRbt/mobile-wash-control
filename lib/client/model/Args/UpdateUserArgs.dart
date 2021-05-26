part of swagger.api;

class UpdateUserArgs {
  
  String login = null;
  

  String firstName = null;
  

  String middleName = null;
  

  String lastName = null;
  

  bool isAdmin = null;
  

  bool isOperator = null;
  

  bool isEngineer = null;
  
  UpdateUserArgs();

  @override
  String toString() {
    return 'Args21[login=$login, firstName=$firstName, middleName=$middleName, lastName=$lastName, isAdmin=$isAdmin, isOperator=$isOperator, isEngineer=$isEngineer, ]';
  }

  UpdateUserArgs.fromJson(Map<String, dynamic> json) {
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

  static List<UpdateUserArgs> listFromJson(List<dynamic> json) {
    return json == null ? new List<UpdateUserArgs>() : json.map((value) => new UpdateUserArgs.fromJson(value)).toList();
  }

  static Map<String, UpdateUserArgs> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdateUserArgs>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new UpdateUserArgs.fromJson(value));
    }
    return map;
  }
}

