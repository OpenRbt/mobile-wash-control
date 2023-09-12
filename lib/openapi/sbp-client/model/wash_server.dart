//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class WashServer {
  /// Returns a new [WashServer] instance.
  WashServer({
    this.id,
    this.name,
    this.description,
    this.serviceKey,
    this.terminalKey,
    this.terminalPassword,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? id;

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
  String? serviceKey;

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

  @override
  bool operator ==(Object other) => identical(this, other) || other is WashServer &&
     other.id == id &&
     other.name == name &&
     other.description == description &&
     other.serviceKey == serviceKey &&
     other.terminalKey == terminalKey &&
     other.terminalPassword == terminalPassword;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (description == null ? 0 : description!.hashCode) +
    (serviceKey == null ? 0 : serviceKey!.hashCode) +
    (terminalKey == null ? 0 : terminalKey!.hashCode) +
    (terminalPassword == null ? 0 : terminalPassword!.hashCode);

  @override
  String toString() => 'WashServer[id=$id, name=$name, description=$description, serviceKey=$serviceKey, terminalKey=$terminalKey, terminalPassword=$terminalPassword]';

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
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
    if (this.serviceKey != null) {
      json[r'service_key'] = this.serviceKey;
    } else {
      json[r'service_key'] = null;
    }
    if (this.terminalKey != null) {
      json[r'terminal_key'] = this.terminalKey;
    } else {
      json[r'terminal_key'] = null;
    }
    if (this.terminalPassword != null) {
      json[r'terminal_password'] = this.terminalPassword;
    } else {
      json[r'terminal_password'] = null;
    }
    return json;
  }

  /// Returns a new [WashServer] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static WashServer? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "WashServer[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "WashServer[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return WashServer(
        id: mapValueOfType<String>(json, r'id'),
        name: mapValueOfType<String>(json, r'name'),
        description: mapValueOfType<String>(json, r'description'),
        serviceKey: mapValueOfType<String>(json, r'service_key'),
        terminalKey: mapValueOfType<String>(json, r'terminal_key'),
        terminalPassword: mapValueOfType<String>(json, r'terminal_password'),
      );
    }
    return null;
  }

  static List<WashServer>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <WashServer>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WashServer.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, WashServer> mapFromJson(dynamic json) {
    final map = <String, WashServer>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = WashServer.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of WashServer-objects as value to a dart map
  static Map<String, List<WashServer>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<WashServer>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = WashServer.listFromJson(entry.value, growable: growable,);
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

