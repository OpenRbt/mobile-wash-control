part of swagger.api;

class SaveCollectionArgs {
  
  int id = null;
  
  SaveCollectionArgs();

  @override
  String toString() {
    return 'Args6[id=$id, ]';
  }

  SaveCollectionArgs.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id =
        json['id']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id
     };
  }

  static List<SaveCollectionArgs> listFromJson(List<dynamic> json) {
    return json == null ? new List<SaveCollectionArgs>() : json.map((value) => new SaveCollectionArgs.fromJson(value)).toList();
  }

  static Map<String, SaveCollectionArgs> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, SaveCollectionArgs>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new SaveCollectionArgs.fromJson(value));
    }
    return map;
  }
}

