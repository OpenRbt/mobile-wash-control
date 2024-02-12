//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgSetStationButton {
  /// Returns a new [ArgSetStationButton] instance.
  ArgSetStationButton({
    required this.stationID,
    this.buttons = const [],
  });

  /// Minimum value: 1
  int stationID;

  List<ResponseStationButtonButtonsInner> buttons;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgSetStationButton &&
     other.stationID == stationID &&
     other.buttons == buttons;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (stationID.hashCode) +
    (buttons.hashCode);

  @override
  String toString() => 'ArgSetStationButton[stationID=$stationID, buttons=$buttons]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'stationID'] = this.stationID;
      json[r'buttons'] = this.buttons;
    return json;
  }

  /// Returns a new [ArgSetStationButton] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ArgSetStationButton? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ArgSetStationButton[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ArgSetStationButton[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ArgSetStationButton(
        stationID: mapValueOfType<int>(json, r'stationID')!,
        buttons: ResponseStationButtonButtonsInner.listFromJson(json[r'buttons']) ?? const [],
      );
    }
    return null;
  }

  static List<ArgSetStationButton>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ArgSetStationButton>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ArgSetStationButton.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ArgSetStationButton> mapFromJson(dynamic json) {
    final map = <String, ArgSetStationButton>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgSetStationButton.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ArgSetStationButton-objects as value to a dart map
  static Map<String, List<ArgSetStationButton>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ArgSetStationButton>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgSetStationButton.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'stationID',
  };
}

