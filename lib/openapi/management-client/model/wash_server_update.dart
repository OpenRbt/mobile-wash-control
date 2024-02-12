//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class WashServerUpdate {
  /// Returns a new [WashServerUpdate] instance.
  WashServerUpdate({
    this.title,
    this.description,
    this.groupId,
  });

  String? title;

  String? description;

  String? groupId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is WashServerUpdate &&
     other.title == title &&
     other.description == description &&
     other.groupId == groupId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (title == null ? 0 : title!.hashCode) +
    (description == null ? 0 : description!.hashCode) +
    (groupId == null ? 0 : groupId!.hashCode);

  @override
  String toString() => 'WashServerUpdate[title=$title, description=$description, groupId=$groupId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.title != null) {
      json[r'title'] = this.title;
    } else {
      json[r'title'] = null;
    }
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
    if (this.groupId != null) {
      json[r'groupId'] = this.groupId;
    } else {
      json[r'groupId'] = null;
    }
    return json;
  }

  /// Returns a new [WashServerUpdate] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static WashServerUpdate? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "WashServerUpdate[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "WashServerUpdate[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return WashServerUpdate(
        title: mapValueOfType<String>(json, r'title'),
        description: mapValueOfType<String>(json, r'description'),
        groupId: mapValueOfType<String>(json, r'groupId'),
      );
    }
    return null;
  }

  static List<WashServerUpdate>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <WashServerUpdate>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WashServerUpdate.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, WashServerUpdate> mapFromJson(dynamic json) {
    final map = <String, WashServerUpdate>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = WashServerUpdate.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of WashServerUpdate-objects as value to a dart map
  static Map<String, List<WashServerUpdate>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<WashServerUpdate>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = WashServerUpdate.listFromJson(entry.value, growable: growable,);
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

