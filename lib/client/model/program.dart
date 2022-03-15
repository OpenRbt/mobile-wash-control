//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Program {
  /// Returns a new [Program] instance.
  Program({
    @required this.id,
    this.name,
    this.price,
    this.preflightEnabled,
    this.isFinishingProgram,
    this.motorSpeedPercent,
    this.preflightMotorSpeedPercent,
    this.relays = const [],
    this.preflightRelays = const [],
  });

  // minimum: 1
  int id;

  String name;

  int price;

  bool preflightEnabled;

  bool isFinishingProgram;

  // minimum: 0
  // maximum: 100
  int motorSpeedPercent;

  // minimum: 0
  // maximum: 100
  int preflightMotorSpeedPercent;

  List<RelayConfig> relays;

  List<RelayConfig> preflightRelays;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Program &&
     other.id == id &&
     other.name == name &&
     other.price == price &&
     other.preflightEnabled == preflightEnabled &&
     other.isFinishingProgram == isFinishingProgram &&
     other.motorSpeedPercent == motorSpeedPercent &&
     other.preflightMotorSpeedPercent == preflightMotorSpeedPercent &&
     other.relays == relays &&
     other.preflightRelays == preflightRelays;

  @override
  int get hashCode =>
    (id == null ? 0 : id.hashCode) +
    (name == null ? 0 : name.hashCode) +
    (price == null ? 0 : price.hashCode) +
    (preflightEnabled == null ? 0 : preflightEnabled.hashCode) +
    (isFinishingProgram == null ? 0 : isFinishingProgram.hashCode) +
    (motorSpeedPercent == null ? 0 : motorSpeedPercent.hashCode) +
    (preflightMotorSpeedPercent == null ? 0 : preflightMotorSpeedPercent.hashCode) +
    (relays == null ? 0 : relays.hashCode) +
    (preflightRelays == null ? 0 : preflightRelays.hashCode);

  @override
  String toString() => 'Program[id=$id, name=$name, price=$price, preflightEnabled=$preflightEnabled, isFinishingProgram=$isFinishingProgram, motorSpeedPercent=$motorSpeedPercent, preflightMotorSpeedPercent=$preflightMotorSpeedPercent, relays=$relays, preflightRelays=$preflightRelays]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = id;
    if (name != null) {
      json[r'name'] = name;
    }
    if (price != null) {
      json[r'price'] = price;
    }
    if (preflightEnabled != null) {
      json[r'preflightEnabled'] = preflightEnabled;
    }
    if (isFinishingProgram != null) {
      json[r'isFinishingProgram'] = isFinishingProgram;
    }
    if (motorSpeedPercent != null) {
      json[r'motorSpeedPercent'] = motorSpeedPercent;
    }
    if (preflightMotorSpeedPercent != null) {
      json[r'preflightMotorSpeedPercent'] = preflightMotorSpeedPercent;
    }
    if (relays != null) {
      json[r'relays'] = relays;
    }
    if (preflightRelays != null) {
      json[r'preflightRelays'] = preflightRelays;
    }
    return json;
  }

  /// Returns a new [Program] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static Program fromJson(Map<String, dynamic> json) => json == null
    ? null
    : Program(
        id: json[r'id'],
        name: json[r'name'],
        price: json[r'price'],
        preflightEnabled: json[r'preflightEnabled'],
        isFinishingProgram: json[r'isFinishingProgram'],
        motorSpeedPercent: json[r'motorSpeedPercent'],
        preflightMotorSpeedPercent: json[r'preflightMotorSpeedPercent'],
        relays: RelayConfig.listFromJson(json[r'relays']),
        preflightRelays: RelayConfig.listFromJson(json[r'preflightRelays']),
    );

  static List<Program> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <Program>[]
      : json.map((dynamic value) => Program.fromJson(value)).toList(growable: true == growable);

  static Map<String, Program> mapFromJson(Map<String, dynamic> json) {
    final map = <String, Program>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = Program.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of Program-objects as value to a dart map
  static Map<String, List<Program>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<Program>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = Program.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

