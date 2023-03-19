//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StationStatus {
  /// Returns a new [StationStatus] instance.
  StationStatus({
    this.id,
    this.name,
    this.hash,
    this.status,
    this.info,
    this.currentBalance,
    this.currentProgram,
    this.currentProgramName,
    this.ip,
  });

  int id;

  String name;

  String hash;

  Status status;

  String info;

  int currentBalance;

  int currentProgram;

  String currentProgramName;

  String ip;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StationStatus &&
     other.id == id &&
     other.name == name &&
     other.hash == hash &&
     other.status == status &&
     other.info == info &&
     other.currentBalance == currentBalance &&
     other.currentProgram == currentProgram &&
     other.currentProgramName == currentProgramName &&
     other.ip == ip;

  @override
  int get hashCode =>
    (id == null ? 0 : id.hashCode) +
    (name == null ? 0 : name.hashCode) +
    (hash == null ? 0 : hash.hashCode) +
    (status == null ? 0 : status.hashCode) +
    (info == null ? 0 : info.hashCode) +
    (currentBalance == null ? 0 : currentBalance.hashCode) +
    (currentProgram == null ? 0 : currentProgram.hashCode) +
    (currentProgramName == null ? 0 : currentProgramName.hashCode) +
    (ip == null ? 0 : ip.hashCode);

  @override
  String toString() => 'StationStatus[id=$id, name=$name, hash=$hash, status=$status, info=$info, currentBalance=$currentBalance, currentProgram=$currentProgram, currentProgramName=$currentProgramName, ip=$ip]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (id != null) {
      json[r'id'] = id;
    }
    if (name != null) {
      json[r'name'] = name;
    }
    if (hash != null) {
      json[r'hash'] = hash;
    }
    if (status != null) {
      json[r'status'] = status;
    }
    if (info != null) {
      json[r'info'] = info;
    }
    if (currentBalance != null) {
      json[r'currentBalance'] = currentBalance;
    }
    if (currentProgram != null) {
      json[r'currentProgram'] = currentProgram;
    }
    if (currentProgramName != null) {
      json[r'currentProgramName'] = currentProgramName;
    }
    if (ip != null) {
      json[r'ip'] = ip;
    }
    return json;
  }

  /// Returns a new [StationStatus] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static StationStatus fromJson(Map<String, dynamic> json) => json == null
    ? null
    : StationStatus(
        id: json[r'id'],
        name: json[r'name'],
        hash: json[r'hash'],
        status: Status.fromJson(json[r'status']),
        info: json[r'info'],
        currentBalance: json[r'currentBalance'],
        currentProgram: json[r'currentProgram'],
        currentProgramName: json[r'currentProgramName'],
        ip: json[r'ip'],
    );

  static List<StationStatus> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <StationStatus>[]
      : json.map((dynamic value) => StationStatus.fromJson(value)).toList(growable: true == growable);

  static Map<String, StationStatus> mapFromJson(Map<String, dynamic> json) {
    final map = <String, StationStatus>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = StationStatus.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of StationStatus-objects as value to a dart map
  static Map<String, List<StationStatus>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<StationStatus>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = StationStatus.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

