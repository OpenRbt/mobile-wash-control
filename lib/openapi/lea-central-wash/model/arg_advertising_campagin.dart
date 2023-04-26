//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgAdvertisingCampagin {
  /// Returns a new [ArgAdvertisingCampagin] instance.
  ArgAdvertisingCampagin({
    this.startDate,
    this.endDate,
  });

  /// Unix time local
  int? startDate;

  /// Unix time local
  int? endDate;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgAdvertisingCampagin &&
     other.startDate == startDate &&
     other.endDate == endDate;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (startDate == null ? 0 : startDate!.hashCode) +
    (endDate == null ? 0 : endDate!.hashCode);

  @override
  String toString() => 'ArgAdvertisingCampagin[startDate=$startDate, endDate=$endDate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.startDate != null) {
      json[r'startDate'] = this.startDate;
    } else {
      json[r'startDate'] = null;
    }
    if (this.endDate != null) {
      json[r'endDate'] = this.endDate;
    } else {
      json[r'endDate'] = null;
    }
    return json;
  }

  /// Returns a new [ArgAdvertisingCampagin] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ArgAdvertisingCampagin? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ArgAdvertisingCampagin[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ArgAdvertisingCampagin[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ArgAdvertisingCampagin(
        startDate: mapValueOfType<int>(json, r'startDate'),
        endDate: mapValueOfType<int>(json, r'endDate'),
      );
    }
    return null;
  }

  static List<ArgAdvertisingCampagin>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ArgAdvertisingCampagin>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ArgAdvertisingCampagin.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ArgAdvertisingCampagin> mapFromJson(dynamic json) {
    final map = <String, ArgAdvertisingCampagin>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgAdvertisingCampagin.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ArgAdvertisingCampagin-objects as value to a dart map
  static Map<String, List<ArgAdvertisingCampagin>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ArgAdvertisingCampagin>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArgAdvertisingCampagin.listFromJson(entry.value, growable: growable,);
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

