part of swagger.api;

class DeleteUserArgs {
  
  String login = null;
  
  DeleteUserArgs();

  @override
  String toString() {
    return 'Args23[login=$login, ]';
  }

  DeleteUserArgs.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    login =
      
      
      json['login']
;
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login
     };
  }

  static List<DeleteUserArgs> listFromJson(List<dynamic> json) {
    return json == null ? new List<DeleteUserArgs>() : json.map((value) => new DeleteUserArgs.fromJson(value)).toList();
  }

  static Map<String, DeleteUserArgs> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, DeleteUserArgs>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new DeleteUserArgs.fromJson(value));
    }
    return map;
  }
}

