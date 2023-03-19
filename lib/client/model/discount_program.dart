//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DiscountProgram {
  /// Returns a new [DiscountProgram] instance.
  DiscountProgram({
    this.programID,
    this.discount,
  });

  int programID;

  int discount;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DiscountProgram &&
     other.programID == programID &&
     other.discount == discount;

  @override
  int get hashCode =>
    (programID == null ? 0 : programID.hashCode) +
    (discount == null ? 0 : discount.hashCode);

  @override
  String toString() => 'DiscountProgram[programID=$programID, discount=$discount]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (programID != null) {
      json[r'programID'] = programID;
    }
    if (discount != null) {
      json[r'discount'] = discount;
    }
    return json;
  }

  /// Returns a new [DiscountProgram] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static DiscountProgram fromJson(Map<String, dynamic> json) => json == null
    ? null
    : DiscountProgram(
        programID: json[r'programID'],
        discount: json[r'discount'],
    );

  static List<DiscountProgram> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <DiscountProgram>[]
      : json.map((dynamic value) => DiscountProgram.fromJson(value)).toList(growable: true == growable);

  static Map<String, DiscountProgram> mapFromJson(Map<String, dynamic> json) {
    final map = <String, DiscountProgram>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = DiscountProgram.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of DiscountProgram-objects as value to a dart map
  static Map<String, List<DiscountProgram>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<DiscountProgram>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = DiscountProgram.listFromJson(value, emptyIsNull: emptyIsNull, growable: growable,);
      });
    }
    return map;
  }
}

