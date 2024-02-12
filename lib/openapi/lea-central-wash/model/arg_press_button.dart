//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgPressButton {
  /// Returns a new [ArgPressButton] instance.
  ArgPressButton({
    required this.hash,
    required this.buttonID,
  });

  String hash;

  int buttonID;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgPressButton &&
     other.hash == hash &&
     other.buttonID == buttonID;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (hash.hashCode) +
    (buttonID.hashCode);

  @override
  String toString() => 'ArgPressButton[hash=$hash, buttonID=$buttonID]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'hash'] = this.hash;
      json[r'buttonID'] = this.buttonID;
    return json;
  }

  /// Returns a new [ArgPressButton] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ArgPressButton? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ArgPressButton[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ArgPressButton[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ArgPressButton(
        hash: mapValueOfType<String>(json, r'hash')!,
        buttonID: mapValueOfType<int>(json, r'buttonID')!,
      );
    }
    return null;
  }

  static List<ArgPressButton>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ArgPressButton>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ArgPressButton.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ArgPressButton> mapFromJson(dynamic json) {
    final map = <String, ArgPressButton>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgPressButton.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ArgPressButton-objects as value to a dart map
  static Map<String, List<ArgPressButton>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ArgPressButton>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgPressButton.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'hash',
    'buttonID',
  };
}

