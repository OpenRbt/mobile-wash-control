//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ApiClient {
  ApiClient({
    this.basePath = 'http://localhost',
    this.authentication,
  });

  final String basePath;
  final Authentication? authentication;

  var _client = Client();
  final _defaultHeaderMap = <String, String>{};

  /// Returns the current HTTP [Client] instance to use in this class.
  ///
  /// The return value is guaranteed to never be null.
  Client get client => _client;

  /// Requests to use a new HTTP [Client] in this class.
  set client(Client newClient) {
    _client = newClient;
  }

  Map<String, String> get defaultHeaderMap => _defaultHeaderMap;

  void addDefaultHeader(String key, String value) {
    _defaultHeaderMap[key] = value;
  }

  // We don't use a Map<String, String> for queryParams.
  // If collectionFormat is 'multi', a key might appear multiple times.
  Future<Response> invokeAPI(
    String path,
    String method,
    List<QueryParam> queryParams,
    Object? body,
    Map<String, String> headerParams,
    Map<String, String> formParams,
    String? contentType,
  ) async {
    await authentication?.applyToParams(queryParams, headerParams);

    headerParams.addAll(_defaultHeaderMap);
    if (contentType != null) {
      headerParams['Content-Type'] = contentType;
    }

    final urlEncodedQueryParams = queryParams.map((param) => '$param');
    final queryString = urlEncodedQueryParams.isNotEmpty ? '?${urlEncodedQueryParams.join('&')}' : '';
    final uri = Uri.parse('$basePath$path$queryString');

    try {
      // Special case for uploading a single file which isn't a 'multipart/form-data'.
      if (body is MultipartFile && (contentType == null || !contentType.toLowerCase().startsWith('multipart/form-data'))) {
        final request = StreamedRequest(method, uri);
        request.headers.addAll(headerParams);
        request.contentLength = body.length;
        body.finalize().listen(
              request.sink.add,
              onDone: request.sink.close,
              // ignore: avoid_types_on_closure_parameters
              onError: (Object error, StackTrace trace) => request.sink.close(),
              cancelOnError: true,
            );
        final response = await _client.send(request);
        return Response.fromStream(response);
      }

      if (body is MultipartRequest) {
        final request = MultipartRequest(method, uri);
        request.fields.addAll(body.fields);
        request.files.addAll(body.files);
        request.headers.addAll(body.headers);
        request.headers.addAll(headerParams);
        final response = await _client.send(request);
        return Response.fromStream(response);
      }

      final msgBody = contentType == 'application/x-www-form-urlencoded' ? formParams : await serializeAsync(body);
      final nullableHeaderParams = headerParams.isEmpty ? null : headerParams;

      switch (method) {
        case 'POST':
          return await post(
            uri,
            headers: nullableHeaderParams,
            body: msgBody,
          );
        case 'PUT':
          return await put(
            uri,
            headers: nullableHeaderParams,
            body: msgBody,
          );
        case 'DELETE':
          return await delete(
            uri,
            headers: nullableHeaderParams,
            body: msgBody,
          );
        case 'PATCH':
          return await patch(
            uri,
            headers: nullableHeaderParams,
            body: msgBody,
          );
        case 'HEAD':
          return await head(
            uri,
            headers: nullableHeaderParams,
          );
        case 'GET':
          return await get(
            uri,
            headers: nullableHeaderParams,
          );
      }
    } on SocketException catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'Socket operation failed: $method $path',
        error,
        trace,
      );
    } on TlsException catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'TLS/SSL communication failed: $method $path',
        error,
        trace,
      );
    } on IOException catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'I/O operation failed: $method $path',
        error,
        trace,
      );
    } on ClientException catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'HTTP connection failed: $method $path',
        error,
        trace,
      );
    } on Exception catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'Exception occurred: $method $path',
        error,
        trace,
      );
    }

    throw ApiException(
      HttpStatus.badRequest,
      'Invalid HTTP operation: $method $path',
    );
  }

  Future<dynamic> deserializeAsync(
    String json,
    String targetType, {
    bool growable = false,
  }) async =>
      // ignore: deprecated_member_use_from_same_package
      deserialize(json, targetType, growable: growable);

  @Deprecated('Scheduled for removal in OpenAPI Generator 6.x. Use deserializeAsync() instead.')
  dynamic deserialize(
    String json,
    String targetType, {
    bool growable = false,
  }) {
    // Remove all spaces. Necessary for regular expressions as well.
    targetType = targetType.replaceAll(' ', ''); // ignore: parameter_assignments

    // If the expected target type is String, nothing to do...
    return targetType == 'String' ? json : _deserialize(jsonDecode(json), targetType, growable: growable);
  }

  // ignore: deprecated_member_use_from_same_package
  Future<String> serializeAsync(Object? value) async => serialize(value);

  @Deprecated('Scheduled for removal in OpenAPI Generator 6.x. Use serializeAsync() instead.')
  String serialize(Object? value) => value == null ? '' : json.encode(value);

  static dynamic _deserialize(dynamic value, String targetType, {bool growable = false}) {
    try {
      switch (targetType) {
        case 'String':
          return value is String ? value : value.toString();
        case 'int':
          return value is int ? value : int.parse('$value');
        case 'double':
          return value is double ? value : double.parse('$value');
        case 'bool':
          if (value is bool) {
            return value;
          }
          final valueString = '$value'.toLowerCase();
          return valueString == 'true' || valueString == '1';
        case 'DateTime':
          return value is DateTime ? value : DateTime.tryParse(value);
        case 'AdvertisingCampaign':
          return AdvertisingCampaign.fromJson(value);
        case 'ArgAddServiceAmount':
          return ArgAddServiceAmount.fromJson(value);
        case 'ArgAdvertisingCampagin':
          return ArgAdvertisingCampagin.fromJson(value);
        case 'ArgAdvertisingCampaignByID':
          return ArgAdvertisingCampaignByID.fromJson(value);
        case 'ArgCardReaderConfig':
          return ArgCardReaderConfig.fromJson(value);
        case 'ArgCardReaderConfigByCash':
          return ArgCardReaderConfigByCash.fromJson(value);
        case 'ArgCollectionReportDates':
          return ArgCollectionReportDates.fromJson(value);
        case 'ArgDelAdvertisingCampagin':
          return ArgDelAdvertisingCampagin.fromJson(value);
        case 'ArgDelStation':
          return ArgDelStation.fromJson(value);
        case 'ArgEndSession':
          return ArgEndSession.fromJson(value);
        case 'ArgGetConfigVar':
          return ArgGetConfigVar.fromJson(value);
        case 'ArgGetLevel':
          return ArgGetLevel.fromJson(value);
        case 'ArgGetStationDiscounts':
          return ArgGetStationDiscounts.fromJson(value);
        case 'ArgIsAuthorized':
          return ArgIsAuthorized.fromJson(value);
        case 'ArgLoad':
          return ArgLoad.fromJson(value);
        case 'ArgLoadFromStation':
          return ArgLoadFromStation.fromJson(value);
        case 'ArgLoadMoney':
          return ArgLoadMoney.fromJson(value);
        case 'ArgMeasureVolumeMilliliters':
          return ArgMeasureVolumeMilliliters.fromJson(value);
        case 'ArgOpenStation':
          return ArgOpenStation.fromJson(value);
        case 'ArgPing':
          return ArgPing.fromJson(value);
        case 'ArgPressButton':
          return ArgPressButton.fromJson(value);
        case 'ArgPrograms':
          return ArgPrograms.fromJson(value);
        case 'ArgResetStationStat':
          return ArgResetStationStat.fromJson(value);
        case 'ArgRun2Program':
          return ArgRun2Program.fromJson(value);
        case 'ArgRunProgram':
          return ArgRunProgram.fromJson(value);
        case 'ArgSave':
          return ArgSave.fromJson(value);
        case 'ArgSaveIfNotExists':
          return ArgSaveIfNotExists.fromJson(value);
        case 'ArgSetBonuses':
          return ArgSetBonuses.fromJson(value);
        case 'ArgSetStationButton':
          return ArgSetStationButton.fromJson(value);
        case 'ArgStationButton':
          return ArgStationButton.fromJson(value);
        case 'ArgStationByHash':
          return ArgStationByHash.fromJson(value);
        case 'ArgStationProgramByHash':
          return ArgStationProgramByHash.fromJson(value);
        case 'ArgStationReportCurrentMoney':
          return ArgStationReportCurrentMoney.fromJson(value);
        case 'ArgStationReportDates':
          return ArgStationReportDates.fromJson(value);
        case 'ArgStationStat':
          return ArgStationStat.fromJson(value);
        case 'ArgStationStatDates':
          return ArgStationStatDates.fromJson(value);
        case 'ArgUserCreate':
          return ArgUserCreate.fromJson(value);
        case 'ArgUserDelete':
          return ArgUserDelete.fromJson(value);
        case 'ArgUserPassword':
          return ArgUserPassword.fromJson(value);
        case 'ArgUserUpdate':
          return ArgUserUpdate.fromJson(value);
        case 'ButtonDiscount':
          return ButtonDiscount.fromJson(value);
        case 'CardReaderConfig':
          return CardReaderConfig.fromJson(value);
        case 'CollectionReport':
          return CollectionReport.fromJson(value);
        case 'CollectionReportWithUser':
          return CollectionReportWithUser.fromJson(value);
        case 'ConfigVarBool':
          return ConfigVarBool.fromJson(value);
        case 'ConfigVarInt':
          return ConfigVarInt.fromJson(value);
        case 'ConfigVarString':
          return ConfigVarString.fromJson(value);
        case 'CreateSession':
          return CreateSession.fromJson(value);
        case 'DeleteUser409Response':
          return DeleteUser409Response.fromJson(value);
        case 'DiscountProgram':
          return DiscountProgram.fromJson(value);
        case 'IsAuthorized':
          return IsAuthorized.fromJson(value);
        case 'KasseConfig':
          return KasseConfig.fromJson(value);
        case 'KeyPair':
          return KeyPair.fromJson(value);
        case 'LoadRelayRequest':
          return LoadRelayRequest.fromJson(value);
        case 'MoneyReport':
          return MoneyReport.fromJson(value);
        case 'Program':
          return Program.fromJson(value);
        case 'ProgramStat':
          return ProgramStat.fromJson(value);
        case 'RefreshSession':
          return RefreshSession.fromJson(value);
        case 'RelayBoard':
          return RelayBoardTypeTransformer().decode(value);
        case 'RelayConfig':
          return RelayConfig.fromJson(value);
        case 'RelayReport':
          return RelayReport.fromJson(value);
        case 'RelayStat':
          return RelayStat.fromJson(value);
        case 'ResponseGetLevel':
          return ResponseGetLevel.fromJson(value);
        case 'ResponsePing':
          return ResponsePing.fromJson(value);
        case 'ResponseStationButton':
          return ResponseStationButton.fromJson(value);
        case 'ResponseStationButtonButtonsInner':
          return ResponseStationButtonButtonsInner.fromJson(value);
        case 'ResponseStationCollectionReportDates':
          return ResponseStationCollectionReportDates.fromJson(value);
        case 'ResponseUserCreate':
          return ResponseUserCreate.fromJson(value);
        case 'ResponseUserCreateConflict':
          return ResponseUserCreateConflict.fromJson(value);
        case 'ResponseUserPassword':
          return ResponseUserPassword.fromJson(value);
        case 'ResponseUserUpdate':
          return ResponseUserUpdate.fromJson(value);
        case 'ResponseVolumeDispenser':
          return ResponseVolumeDispenser.fromJson(value);
        case 'Session':
          return Session.fromJson(value);
        case 'SessionRefresh':
          return SessionRefresh.fromJson(value);
        case 'StationConfig':
          return StationConfig.fromJson(value);
        case 'StationPrograms':
          return StationPrograms.fromJson(value);
        case 'StationProgramsProgramsInner':
          return StationProgramsProgramsInner.fromJson(value);
        case 'StationReport':
          return StationReport.fromJson(value);
        case 'StationRequest':
          return StationRequest.fromJson(value);
        case 'StationStat':
          return StationStat.fromJson(value);
        case 'StationStatus':
          return StationStatus.fromJson(value);
        case 'StationsVariables':
          return StationsVariables.fromJson(value);
        case 'Status':
          return StatusTypeTransformer().decode(value);
        case 'StatusCollectionReport':
          return StatusCollectionReport.fromJson(value);
        case 'StatusReport':
          return StatusReport.fromJson(value);
        case 'UserConfig':
          return UserConfig.fromJson(value);
        case 'UsersReport':
          return UsersReport.fromJson(value);
        case 'VolumeDispenser':
          return VolumeDispenser.fromJson(value);
        default:
          dynamic match;
          if (value is List && (match = _regList.firstMatch(targetType)?.group(1)) != null) {
            return value
                .map<dynamic>((dynamic v) => _deserialize(
                      v,
                      match,
                      growable: growable,
                    ))
                .toList(growable: growable);
          }
          if (value is Set && (match = _regSet.firstMatch(targetType)?.group(1)) != null) {
            return value
                .map<dynamic>((dynamic v) => _deserialize(
                      v,
                      match,
                      growable: growable,
                    ))
                .toSet();
          }
          if (value is Map && (match = _regMap.firstMatch(targetType)?.group(1)) != null) {
            return Map<String, dynamic>.fromIterables(
              value.keys.cast<String>(),
              value.values.map<dynamic>((dynamic v) => _deserialize(
                    v,
                    match,
                    growable: growable,
                  )),
            );
          }
      }
    } on Exception catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.internalServerError,
        'Exception during deserialization.',
        error,
        trace,
      );
    }
    throw ApiException(
      HttpStatus.internalServerError,
      'Could not find a suitable class for deserialization',
    );
  }
}

/// Primarily intended for use in an isolate.
class DeserializationMessage {
  const DeserializationMessage({
    required this.json,
    required this.targetType,
    this.growable = false,
  });

  /// The JSON value to deserialize.
  final String json;

  /// Target type to deserialize to.
  final String targetType;

  /// Whether to make deserialized lists or maps growable.
  final bool growable;
}

/// Primarily intended for use in an isolate.
Future<dynamic> deserializeAsync(DeserializationMessage message) async {
  // Remove all spaces. Necessary for regular expressions as well.
  final targetType = message.targetType.replaceAll(' ', '');

  // If the expected target type is String, nothing to do...
  return targetType == 'String'
      ? message.json
      : ApiClient._deserialize(
          jsonDecode(message.json),
          targetType,
          growable: message.growable,
        );
}

/// Primarily intended for use in an isolate.
Future<String> serializeAsync(Object? value) async => value == null ? '' : json.encode(value);
