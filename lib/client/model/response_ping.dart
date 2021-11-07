//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ResponsePing {
  /// Returns a new [ResponsePing] instance.
  ResponsePing({
    @required this.serviceAmount,
    @required this.openStation,
    this.lastUpdate,
    this.lastDiscountUpdate,
    this.buttonID,
  });

  int serviceAmount;

  bool openStation;

  int lastUpdate;

  int lastDiscountUpdate;

  int buttonID;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ResponsePing && other.serviceAmount == serviceAmount && other.openStation == openStation && other.lastUpdate == lastUpdate && other.lastDiscountUpdate == lastDiscountUpdate && other.buttonID == buttonID;

  @override
  int get hashCode =>
      (serviceAmount == null ? 0 : serviceAmount.hashCode) +
      (openStation == null ? 0 : openStation.hashCode) +
      (lastUpdate == null ? 0 : lastUpdate.hashCode) +
      (lastDiscountUpdate == null ? 0 : lastDiscountUpdate.hashCode) +
      (buttonID == null ? 0 : buttonID.hashCode);

  @override
  String toString() => 'ResponsePing[serviceAmount=$serviceAmount, openStation=$openStation, lastUpdate=$lastUpdate, lastDiscountUpdate=$lastDiscountUpdate, buttonID=$buttonID]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'serviceAmount'] = serviceAmount;
    json[r'openStation'] = openStation;
    if (lastUpdate != null) {
      json[r'lastUpdate'] = lastUpdate;
    }
    if (lastDiscountUpdate != null) {
      json[r'lastDiscountUpdate'] = lastDiscountUpdate;
    }
    if (buttonID != null) {
      json[r'ButtonID'] = buttonID;
    }
    return json;
  }

  /// Returns a new [ResponsePing] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ResponsePing fromJson(Map<String, dynamic> json) => json == null
      ? null
      : ResponsePing(
          serviceAmount: json[r'serviceAmount'],
          openStation: json[r'openStation'],
          lastUpdate: json[r'lastUpdate'],
          lastDiscountUpdate: json[r'lastDiscountUpdate'],
          buttonID: json[r'ButtonID'],
        );

  static List<ResponsePing> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <ResponsePing>[]
          : json.map((dynamic value) => ResponsePing.fromJson(value)).toList(growable: true == growable);

  static Map<String, ResponsePing> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ResponsePing>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = ResponsePing.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of ResponsePing-objects as value to a dart map
  static Map<String, List<ResponsePing>> mapListFromJson(
    Map<String, dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<ResponsePing>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = ResponsePing.listFromJson(
          value,
          emptyIsNull: emptyIsNull,
          growable: growable,
        );
      });
    }
    return map;
  }
}
