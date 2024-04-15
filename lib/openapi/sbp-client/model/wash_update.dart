//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class WashUpdate {
  /// Returns a new [WashUpdate] instance.
  WashUpdate({
    this.name,
    this.description,
    this.terminalKey,
    this.terminalPassword,
    this.twoStagePayment,
  });

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
  String? description;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? terminalKey;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? terminalPassword;

  bool? twoStagePayment;

  @override
  bool operator ==(Object other) => identical(this, other) || other is WashUpdate &&
     other.name == name &&
     other.description == description &&
     other.terminalKey == terminalKey &&
     other.terminalPassword == terminalPassword &&
     other.twoStagePayment == twoStagePayment;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name == null ? 0 : name!.hashCode) +
    (description == null ? 0 : description!.hashCode) +
    (terminalKey == null ? 0 : terminalKey!.hashCode) +
    (terminalPassword == null ? 0 : terminalPassword!.hashCode) +
    (twoStagePayment == null ? 0 : twoStagePayment!.hashCode);

  @override
  String toString() => 'WashUpdate[name=$name, description=$description, terminalKey=$terminalKey, terminalPassword=$terminalPassword, twoStagePayment=$twoStagePayment]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
    if (this.terminalKey != null) {
      json[r'terminalKey'] = this.terminalKey;
    } else {
      json[r'terminalKey'] = null;
    }
    if (this.terminalPassword != null) {
      json[r'terminalPassword'] = this.terminalPassword;
    } else {
      json[r'terminalPassword'] = null;
    }
    if (this.twoStagePayment != null) {
      json[r'twoStagePayment'] = this.twoStagePayment;
    } else {
      json[r'twoStagePayment'] = null;
    }
    return json;
  }

  /// Returns a new [WashUpdate] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static WashUpdate? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "WashUpdate[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "WashUpdate[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return WashUpdate(
        name: mapValueOfType<String>(json, r'name'),
        description: mapValueOfType<String>(json, r'description'),
        terminalKey: mapValueOfType<String>(json, r'terminalKey'),
        terminalPassword: mapValueOfType<String>(json, r'terminalPassword'),
        twoStagePayment: mapValueOfType<bool>(json, r'twoStagePayment'),
      );
    }
    return null;
  }

  static List<WashUpdate>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <WashUpdate>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WashUpdate.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, WashUpdate> mapFromJson(dynamic json) {
    final map = <String, WashUpdate>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = WashUpdate.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of WashUpdate-objects as value to a dart map
  static Map<String, List<WashUpdate>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<WashUpdate>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = WashUpdate.listFromJson(entry.value, growable: growable,);
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

