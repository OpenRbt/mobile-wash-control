//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Program {
  /// Returns a new [Program] instance.
  Program({
    required this.id,
    this.name,
    this.price,
    this.preflightEnabled,
    this.isFinishingProgram,
    this.motorSpeedPercent,
    this.preflightMotorSpeedPercent,
    this.relays = const [],
    this.preflightRelays = const [],
  });

  /// Minimum value: 1
  int id;

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
  int? price;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? preflightEnabled;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? isFinishingProgram;

  /// Minimum value: 0
  /// Maximum value: 100
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? motorSpeedPercent;

  /// Minimum value: 0
  /// Maximum value: 100
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? preflightMotorSpeedPercent;

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
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (price == null ? 0 : price!.hashCode) +
    (preflightEnabled == null ? 0 : preflightEnabled!.hashCode) +
    (isFinishingProgram == null ? 0 : isFinishingProgram!.hashCode) +
    (motorSpeedPercent == null ? 0 : motorSpeedPercent!.hashCode) +
    (preflightMotorSpeedPercent == null ? 0 : preflightMotorSpeedPercent!.hashCode) +
    (relays.hashCode) +
    (preflightRelays.hashCode);

  @override
  String toString() => 'Program[id=$id, name=$name, price=$price, preflightEnabled=$preflightEnabled, isFinishingProgram=$isFinishingProgram, motorSpeedPercent=$motorSpeedPercent, preflightMotorSpeedPercent=$preflightMotorSpeedPercent, relays=$relays, preflightRelays=$preflightRelays]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.price != null) {
      json[r'price'] = this.price;
    } else {
      json[r'price'] = null;
    }
    if (this.preflightEnabled != null) {
      json[r'preflightEnabled'] = this.preflightEnabled;
    } else {
      json[r'preflightEnabled'] = null;
    }
    if (this.isFinishingProgram != null) {
      json[r'isFinishingProgram'] = this.isFinishingProgram;
    } else {
      json[r'isFinishingProgram'] = null;
    }
    if (this.motorSpeedPercent != null) {
      json[r'motorSpeedPercent'] = this.motorSpeedPercent;
    } else {
      json[r'motorSpeedPercent'] = null;
    }
    if (this.preflightMotorSpeedPercent != null) {
      json[r'preflightMotorSpeedPercent'] = this.preflightMotorSpeedPercent;
    } else {
      json[r'preflightMotorSpeedPercent'] = null;
    }
      json[r'relays'] = this.relays;
      json[r'preflightRelays'] = this.preflightRelays;
    return json;
  }

  /// Returns a new [Program] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Program? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Program[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Program[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Program(
        id: mapValueOfType<int>(json, r'id')!,
        name: mapValueOfType<String>(json, r'name'),
        price: mapValueOfType<int>(json, r'price'),
        preflightEnabled: mapValueOfType<bool>(json, r'preflightEnabled'),
        isFinishingProgram: mapValueOfType<bool>(json, r'isFinishingProgram'),
        motorSpeedPercent: mapValueOfType<int>(json, r'motorSpeedPercent'),
        preflightMotorSpeedPercent: mapValueOfType<int>(json, r'preflightMotorSpeedPercent'),
        relays: RelayConfig.listFromJson(json[r'relays']) ?? const [],
        preflightRelays: RelayConfig.listFromJson(json[r'preflightRelays']) ?? const [],
      );
    }
    return null;
  }

  static List<Program>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Program>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Program.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Program> mapFromJson(dynamic json) {
    final map = <String, Program>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Program.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Program-objects as value to a dart map
  static Map<String, List<Program>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Program>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Program.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
  };
}

