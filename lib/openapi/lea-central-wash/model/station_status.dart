//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
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
    this.version,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? id;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? hash;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Status? status;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? info;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? currentBalance;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? currentProgram;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? currentProgramName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? ip;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  FirmwareVersion? version;

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
     other.ip == ip &&
     other.version == version;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (hash == null ? 0 : hash!.hashCode) +
    (status == null ? 0 : status!.hashCode) +
    (info == null ? 0 : info!.hashCode) +
    (currentBalance == null ? 0 : currentBalance!.hashCode) +
    (currentProgram == null ? 0 : currentProgram!.hashCode) +
    (currentProgramName == null ? 0 : currentProgramName!.hashCode) +
    (ip == null ? 0 : ip!.hashCode) +
    (version == null ? 0 : version!.hashCode);

  @override
  String toString() => 'StationStatus[id=$id, name=$name, hash=$hash, status=$status, info=$info, currentBalance=$currentBalance, currentProgram=$currentProgram, currentProgramName=$currentProgramName, ip=$ip, version=$version]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.hash != null) {
      json[r'hash'] = this.hash;
    } else {
      json[r'hash'] = null;
    }
    if (this.status != null) {
      json[r'status'] = this.status;
    } else {
      json[r'status'] = null;
    }
    if (this.info != null) {
      json[r'info'] = this.info;
    } else {
      json[r'info'] = null;
    }
    if (this.currentBalance != null) {
      json[r'currentBalance'] = this.currentBalance;
    } else {
      json[r'currentBalance'] = null;
    }
    if (this.currentProgram != null) {
      json[r'currentProgram'] = this.currentProgram;
    } else {
      json[r'currentProgram'] = null;
    }
    if (this.currentProgramName != null) {
      json[r'currentProgramName'] = this.currentProgramName;
    } else {
      json[r'currentProgramName'] = null;
    }
    if (this.ip != null) {
      json[r'ip'] = this.ip;
    } else {
      json[r'ip'] = null;
    }
    if (this.version != null) {
      json[r'version'] = this.version;
    } else {
      json[r'version'] = null;
    }
    return json;
  }

  /// Returns a new [StationStatus] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StationStatus? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "StationStatus[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "StationStatus[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return StationStatus(
        id: mapValueOfType<int>(json, r'id'),
        name: mapValueOfType<String>(json, r'name'),
        hash: mapValueOfType<String>(json, r'hash'),
        status: Status.fromJson(json[r'status']),
        info: mapValueOfType<String>(json, r'info'),
        currentBalance: mapValueOfType<int>(json, r'currentBalance'),
        currentProgram: mapValueOfType<int>(json, r'currentProgram'),
        currentProgramName: mapValueOfType<String>(json, r'currentProgramName'),
        ip: mapValueOfType<String>(json, r'ip'),
        version: FirmwareVersion.fromJson(json[r'version']),
      );
    }
    return null;
  }

  static List<StationStatus>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StationStatus>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StationStatus.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StationStatus> mapFromJson(dynamic json) {
    final map = <String, StationStatus>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StationStatus.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StationStatus-objects as value to a dart map
  static Map<String, List<StationStatus>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StationStatus>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StationStatus.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

