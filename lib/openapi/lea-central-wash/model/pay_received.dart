//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PayReceived {
  /// Returns a new [PayReceived] instance.
  PayReceived({
    required this.hash,
    required this.qrOrderId,
  });

  String hash;

  String qrOrderId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PayReceived &&
     other.hash == hash &&
     other.qrOrderId == qrOrderId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (hash.hashCode) +
    (qrOrderId.hashCode);

  @override
  String toString() => 'PayReceived[hash=$hash, qrOrderId=$qrOrderId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'hash'] = this.hash;
      json[r'qrOrderId'] = this.qrOrderId;
    return json;
  }

  /// Returns a new [PayReceived] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PayReceived? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PayReceived[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PayReceived[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PayReceived(
        hash: mapValueOfType<String>(json, r'hash')!,
        qrOrderId: mapValueOfType<String>(json, r'qrOrderId')!,
      );
    }
    return null;
  }

  static List<PayReceived>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PayReceived>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PayReceived.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PayReceived> mapFromJson(dynamic json) {
    final map = <String, PayReceived>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PayReceived.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PayReceived-objects as value to a dart map
  static Map<String, List<PayReceived>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PayReceived>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PayReceived.listFromJson(entry.value, growable: growable,);
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
    'qrOrderId',
  };
}

