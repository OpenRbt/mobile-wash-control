// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArgListStationConfigVar {
  ArgListStationConfigVar({
    required this.stationID,
  });

  int stationID;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArgListStationConfigVar && other.stationID == stationID;

  @override
  int get hashCode => stationID.hashCode;

  @override
  String toString() => 'ArgListStationConfigVar[stationID=$stationID]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'stationID'] = stationID;
    return json;
  }

  static ArgListStationConfigVar? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();
      return ArgListStationConfigVar(
        stationID: mapValueOfType<int>(json, r'stationID')!,
      );
    }
    return null;
  }

  static const requiredKeys = <String>{
    'stationID',
  };
}
