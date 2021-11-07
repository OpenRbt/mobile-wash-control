//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ButtonDiscount {
  /// Returns a new [ButtonDiscount] instance.
  ButtonDiscount({
    this.buttonID,
    this.discount,
  });

  int buttonID;

  int discount;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ButtonDiscount && other.buttonID == buttonID && other.discount == discount;

  @override
  int get hashCode => (buttonID == null ? 0 : buttonID.hashCode) + (discount == null ? 0 : discount.hashCode);

  @override
  String toString() => 'ButtonDiscount[buttonID=$buttonID, discount=$discount]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (buttonID != null) {
      json[r'buttonID'] = buttonID;
    }
    if (discount != null) {
      json[r'discount'] = discount;
    }
    return json;
  }

  /// Returns a new [ButtonDiscount] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ButtonDiscount fromJson(Map<String, dynamic> json) => json == null
      ? null
      : ButtonDiscount(
          buttonID: json[r'buttonID'],
          discount: json[r'discount'],
        );

  static List<ButtonDiscount> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <ButtonDiscount>[]
          : json.map((dynamic value) => ButtonDiscount.fromJson(value)).toList(growable: true == growable);

  static Map<String, ButtonDiscount> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ButtonDiscount>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ButtonDiscount.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ButtonDiscount-objects as value to a dart map
  static Map<String, List<ButtonDiscount>> mapListFromJson(
    Map<String, dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<ButtonDiscount>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ButtonDiscount.listFromJson(
          value,
          emptyIsNull: emptyIsNull,
          growable: growable,
        );
      });
    }
    return map;
  }
}
