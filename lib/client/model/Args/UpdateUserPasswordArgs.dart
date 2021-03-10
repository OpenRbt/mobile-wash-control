part of swagger.api;

class UpdateUserPasswordArgs {
  
  String login = null;
  

  String oldPassword = null;


  String newPassword = null;
  
  UpdateUserPasswordArgs();

  @override
  String toString() {
    return 'Args20[login=$login, oldPassword=$oldPassword, newPassword=$newPassword, ]';
  }

  UpdateUserPasswordArgs.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    login =
      
      
      json['login']
;
    oldPassword =
      
      
      json['oldPassword']
;
    newPassword =
      
      
      json['newPassword']
;
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'oldPassword': oldPassword,
      'newPassword': newPassword
     };
  }

  static List<UpdateUserPasswordArgs> listFromJson(List<dynamic> json) {
    return json == null ? new List<UpdateUserPasswordArgs>() : json.map((value) => new UpdateUserPasswordArgs.fromJson(value)).toList();
  }

  static Map<String, UpdateUserPasswordArgs> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdateUserPasswordArgs>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new UpdateUserPasswordArgs.fromJson(value));
    }
    return map;
  }
}

