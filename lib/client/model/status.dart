part of swagger.api;

class Status {
  /// The underlying value of this enum member.
  String value;

  Status._internal(this.value);

  static Status offline_ = Status._internal("offline");
  static Status online_ = Status._internal("online");

  Status.fromJson(dynamic data) {
    switch (data) {
          case "offline": value = data; break;
          case "online": value = data; break;
    default: throw('Unknown enum value to decode: $data');
    }
  }

  static dynamic encode(Status data) {
    return data.value;
  }
}

