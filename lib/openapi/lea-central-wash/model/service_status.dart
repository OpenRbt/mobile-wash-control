//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ServiceStatus {
  /// Returns a new [ServiceStatus] instance.
  ServiceStatus({
    this.available,
    this.disabledOnServer,
    this.isConnected,
    this.lastErr,
    this.dateLastErrUTC,
    this.unpaidStations = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? available;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? disabledOnServer;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? isConnected;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? lastErr;

  /// Unix time
  int? dateLastErrUTC;

  List<int> unpaidStations;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ServiceStatus &&
     other.available == available &&
     other.disabledOnServer == disabledOnServer &&
     other.isConnected == isConnected &&
     other.lastErr == lastErr &&
     other.dateLastErrUTC == dateLastErrUTC &&
     other.unpaidStations == unpaidStations;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (available == null ? 0 : available!.hashCode) +
    (disabledOnServer == null ? 0 : disabledOnServer!.hashCode) +
    (isConnected == null ? 0 : isConnected!.hashCode) +
    (lastErr == null ? 0 : lastErr!.hashCode) +
    (dateLastErrUTC == null ? 0 : dateLastErrUTC!.hashCode) +
    (unpaidStations.hashCode);

  @override
  String toString() => 'ServiceStatus[available=$available, disabledOnServer=$disabledOnServer, isConnected=$isConnected, lastErr=$lastErr, dateLastErrUTC=$dateLastErrUTC, unpaidStations=$unpaidStations]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.available != null) {
      json[r'available'] = this.available;
    } else {
      json[r'available'] = null;
    }
    if (this.disabledOnServer != null) {
      json[r'disabledOnServer'] = this.disabledOnServer;
    } else {
      json[r'disabledOnServer'] = null;
    }
    if (this.isConnected != null) {
      json[r'isConnected'] = this.isConnected;
    } else {
      json[r'isConnected'] = null;
    }
    if (this.lastErr != null) {
      json[r'lastErr'] = this.lastErr;
    } else {
      json[r'lastErr'] = null;
    }
    if (this.dateLastErrUTC != null) {
      json[r'dateLastErrUTC'] = this.dateLastErrUTC;
    } else {
      json[r'dateLastErrUTC'] = null;
    }
      json[r'unpaidStations'] = this.unpaidStations;
    return json;
  }

  /// Returns a new [ServiceStatus] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ServiceStatus? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ServiceStatus[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ServiceStatus[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ServiceStatus(
        available: mapValueOfType<bool>(json, r'available'),
        disabledOnServer: mapValueOfType<bool>(json, r'disabledOnServer'),
        isConnected: mapValueOfType<bool>(json, r'isConnected'),
        lastErr: mapValueOfType<String>(json, r'lastErr'),
        dateLastErrUTC: mapValueOfType<int>(json, r'dateLastErrUTC'),
        unpaidStations: json[r'unpaidStations'] is List
            ? (json[r'unpaidStations'] as List).cast<int>()
            : const [],
      );
    }
    return null;
  }

  static List<ServiceStatus>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ServiceStatus>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ServiceStatus.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ServiceStatus> mapFromJson(dynamic json) {
    final map = <String, ServiceStatus>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ServiceStatus.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ServiceStatus-objects as value to a dart map
  static Map<String, List<ServiceStatus>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ServiceStatus>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ServiceStatus.listFromJson(entry.value, growable: growable,);
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

