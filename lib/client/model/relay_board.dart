part of swagger.api;

class RelayBoard {
  /// The underlying value of this enum member.
  String value;

  RelayBoard._internal(this.value);

  static RelayBoard localGPIO_ = RelayBoard._internal("localGPIO");
  static RelayBoard danBoard_ = RelayBoard._internal("danBoard");

  RelayBoard.fromJson(dynamic data) {
    switch (data) {
          case "localGPIO": value = data; break;
          case "danBoard": value = data; break;
    default: throw('Unknown enum value to decode: $data');
    }
  }

  static dynamic encode(RelayBoard data) {
    return data.value;
  }
}

