//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgCopyStationConfig {
  /// Returns a new [ArgCopyStationConfig] instance.
  ArgCopyStationConfig({
    required this.fromStationID,
    required this.toStationID,
    this.copyButtons = false,
  });

  /// Minimum value: 1
  int fromStationID;

  /// Minimum value: 1
  int toStationID;

  bool copyButtons;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArgCopyStationConfig &&
     other.fromStationID == fromStationID &&
     other.toStationID == toStationID &&
     other.copyButtons == copyButtons;

  @override
  int get hashCode =>
    (fromStationID.hashCode) +
    (toStationID.hashCode) +
    (copyButtons.hashCode);

  @override
  String toString() => 'ArgCopyStationConfig[fromStationID=$fromStationID, toStationID=$toStationID, copyButtons=$copyButtons]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'fromStationID'] = this.fromStationID;
    json[r'toStationID'] = this.toStationID;
    json[r'copyButtons'] = this.copyButtons;
    return json;
  }

  static ArgCopyStationConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();
      return ArgCopyStationConfig(
        fromStationID: mapValueOfType<int>(json, r'fromStationID')!,
        toStationID: mapValueOfType<int>(json, r'toStationID')!,
        copyButtons: mapValueOfType<bool>(json, r'copyButtons') ?? false,
      );
    }
    return null;
  }

  static List<ArgCopyStationConfig>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ArgCopyStationConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ArgCopyStationConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ArgCopyStationConfig> mapFromJson(dynamic json) {
    final map = <String, ArgCopyStationConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        final value = ArgCopyStationConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  static Map<String, List<ArgCopyStationConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ArgCopyStationConfig>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        final value = ArgCopyStationConfig.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  static const requiredKeys = <String>{
    'fromStationID',
    'toStationID',
  };
}
