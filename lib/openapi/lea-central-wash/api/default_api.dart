//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DefaultApi {
  DefaultApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'POST /add-advertising-campaign' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [DiscountCampaign] args (required):
  Future<Response> addAdvertisingCampaignWithHttpInfo(
    DiscountCampaign args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/add-advertising-campaign';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [DiscountCampaign] args (required):
  Future<void> addAdvertisingCampaign(
    DiscountCampaign args,
  ) async {
    final response = await addAdvertisingCampaignWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /add-service-amount' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgAddServiceAmount] args (required):
  Future<Response> addServiceAmountWithHttpInfo(
    ArgAddServiceAmount args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/add-service-amount';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgAddServiceAmount] args (required):
  Future<void> addServiceAmount(
    ArgAddServiceAmount args,
  ) async {
    final response = await addServiceAmountWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /advertising-campaign' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgAdvertisingCampagin] args:
  Future<Response> advertisingCampaignWithHttpInfo({
    ArgAdvertisingCampagin? args,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/advertising-campaign';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgAdvertisingCampagin] args:
  Future<List<DiscountCampaign>?> advertisingCampaign({
    ArgAdvertisingCampagin? args,
  }) async {
    final response = await advertisingCampaignWithHttpInfo(
      args: args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<AdvertisingCampaign>') as List).cast<DiscountCampaign>().toList();
    }
    return null;
  }

  /// Performs an HTTP 'POST /advertising-campaign-by-id' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgAdvertisingCampaignByID] args (required):
  Future<Response> advertisingCampaignByIDWithHttpInfo(
    ArgAdvertisingCampaignByID args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/advertising-campaign-by-id';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgAdvertisingCampaignByID] args (required):
  Future<DiscountCampaign?> advertisingCampaignByID(
    ArgAdvertisingCampaignByID args,
  ) async {
    final response = await advertisingCampaignByIDWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'AdvertisingCampaign',
      ) as DiscountCampaign;
    }
    return null;
  }

  /// Performs an HTTP 'POST /card-reader-config' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgCardReaderConfig] args (required):
  Future<Response> cardReaderConfigWithHttpInfo(
    ArgCardReaderConfig args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/card-reader-config';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgCardReaderConfig] args (required):
  Future<CardReaderConfig?> cardReaderConfig(
    ArgCardReaderConfig args,
  ) async {
    final response = await cardReaderConfigWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'CardReaderConfig',
      ) as CardReaderConfig;
    }
    return null;
  }

  /// Performs an HTTP 'POST /card-reader-config-by-hash' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgCardReaderConfigByCash] args (required):
  Future<Response> cardReaderConfigByHashWithHttpInfo(
    ArgCardReaderConfigByCash args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/card-reader-config-by-hash';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgCardReaderConfigByCash] args (required):
  Future<CardReaderConfig?> cardReaderConfigByHash(
    ArgCardReaderConfigByCash args,
  ) async {
    final response = await cardReaderConfigByHashWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'CardReaderConfig',
      ) as CardReaderConfig;
    }
    return null;
  }

  /// Performs an HTTP 'POST /create-session' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [CreateSession] args (required):
  Future<Response> createSessionWithHttpInfo(
    CreateSession args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/create-session';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [CreateSession] args (required):
  Future<Session?> createSession(
    CreateSession args,
  ) async {
    final response = await createSessionWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'Session',
      ) as Session;
    }
    return null;
  }

  /// Performs an HTTP 'POST /user' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgUserCreate] args (required):
  Future<Response> createUserWithHttpInfo(
    ArgUserCreate args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/user';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgUserCreate] args (required):
  Future<ResponseUserCreate?> createUser(
    ArgUserCreate args,
  ) async {
    final response = await createUserWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'ResponseUserCreate',
      ) as ResponseUserCreate;
    }
    return null;
  }

  /// Performs an HTTP 'POST /del-advertising-campaign' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgDelAdvertisingCampagin] args (required):
  Future<Response> delAdvertisingCampaignWithHttpInfo(
    ArgDelAdvertisingCampagin args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/del-advertising-campaign';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgDelAdvertisingCampagin] args (required):
  Future<void> delAdvertisingCampaign(
    ArgDelAdvertisingCampagin args,
  ) async {
    final response = await delAdvertisingCampaignWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /del-station' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgDelStation] args (required):
  Future<Response> delStationWithHttpInfo(
    ArgDelStation args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/del-station';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgDelStation] args (required):
  Future<void> delStation(
    ArgDelStation args,
  ) async {
    final response = await delStationWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'DELETE /user' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgUserDelete] args (required):
  Future<Response> deleteUserWithHttpInfo(
    ArgUserDelete args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/user';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgUserDelete] args (required):
  Future<void> deleteUser(
    ArgUserDelete args,
  ) async {
    final response = await deleteUserWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /edit-advertising-campaign' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [DiscountCampaign] args (required):
  Future<Response> editAdvertisingCampaignWithHttpInfo(
    DiscountCampaign args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/edit-advertising-campaign';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [DiscountCampaign] args (required):
  Future<void> editAdvertisingCampaign(
    DiscountCampaign args,
  ) async {
    final response = await editAdvertisingCampaignWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /end-session' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgEndSession] args (required):
  Future<Response> endhSessionWithHttpInfo(
    ArgEndSession args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/end-session';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgEndSession] args (required):
  Future<void> endhSession(
    ArgEndSession args,
  ) async {
    final response = await endhSessionWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /get-config-var-bool' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgGetConfigVar] args (required):
  Future<Response> getConfigVarBoolWithHttpInfo(
    ArgGetConfigVar args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/get-config-var-bool';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgGetConfigVar] args (required):
  Future<ConfigVarBool?> getConfigVarBool(
    ArgGetConfigVar args,
  ) async {
    final response = await getConfigVarBoolWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'ConfigVarBool',
      ) as ConfigVarBool;
    }
    return null;
  }

  /// Performs an HTTP 'POST /get-config-var-int' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgGetConfigVar] args (required):
  Future<Response> getConfigVarIntWithHttpInfo(
    ArgGetConfigVar args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/get-config-var-int';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgGetConfigVar] args (required):
  Future<ConfigVarInt?> getConfigVarInt(
    ArgGetConfigVar args,
  ) async {
    final response = await getConfigVarIntWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'ConfigVarInt',
      ) as ConfigVarInt;
    }
    return null;
  }

  /// Performs an HTTP 'POST /get-config-var-string' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgGetConfigVar] args (required):
  Future<Response> getConfigVarStringWithHttpInfo(
    ArgGetConfigVar args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/get-config-var-string';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgGetConfigVar] args (required):
  Future<ConfigVarString?> getConfigVarString(
    ArgGetConfigVar args,
  ) async {
    final response = await getConfigVarStringWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'ConfigVarString',
      ) as ConfigVarString;
    }
    return null;
  }

  /// Performs an HTTP 'POST /getLevel' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgGetLevel] args (required):
  Future<Response> getLevelWithHttpInfo(
    ArgGetLevel args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/getLevel';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgGetLevel] args (required):
  Future<ResponseGetLevel?> getLevel(
    ArgGetLevel args,
  ) async {
    final response = await getLevelWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'ResponseGetLevel',
      ) as ResponseGetLevel;
    }
    return null;
  }

  /// Performs an HTTP 'GET /ping' operation and returns the [Response].
  Future<Response> getPingWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/ping';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  Future<void> getPing() async {
    final response = await getPingWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /get-station-discounts' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgGetStationDiscounts] args (required):
  Future<Response> getStationDiscountsWithHttpInfo(
    ArgGetStationDiscounts args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/get-station-discounts';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgGetStationDiscounts] args (required):
  Future<List<ButtonDiscount>?> getStationDiscounts(
    ArgGetStationDiscounts args,
  ) async {
    final response = await getStationDiscountsWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<ButtonDiscount>') as List).cast<ButtonDiscount>().toList();
    }
    return null;
  }

  /// Performs an HTTP 'GET /user' operation and returns the [Response].
  Future<Response> getUserWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/user';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  Future<UserConfig?> getUser() async {
    final response = await getUserWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'UserConfig',
      ) as UserConfig;
    }
    return null;
  }

  /// Performs an HTTP 'GET /users' operation and returns the [Response].
  Future<Response> getUsersWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/users';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  Future<UsersReport?> getUsers() async {
    final response = await getUsersWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'UsersReport',
      ) as UsersReport;
    }
    return null;
  }

  /// Performs an HTTP 'GET /info' operation and returns the [Response].
  Future<Response> infoWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/info';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  Future<String?> info() async {
    final response = await infoWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'String',
      ) as String;
    }
    return null;
  }

  /// Performs an HTTP 'POST /is-authorized' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgIsAuthorized] args (required):
  Future<Response> isAuthorizedWithHttpInfo(
    ArgIsAuthorized args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/is-authorized';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgIsAuthorized] args (required):
  Future<IsAuthorized?> isAuthorized(
    ArgIsAuthorized args,
  ) async {
    final response = await isAuthorizedWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'IsAuthorized',
      ) as IsAuthorized;
    }
    return null;
  }

  /// Performs an HTTP 'POST /kasse' operation and returns the [Response].
  Future<Response> kasseWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/kasse';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  Future<KasseConfig?> kasse() async {
    final response = await kasseWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'KasseConfig',
      ) as KasseConfig;
    }
    return null;
  }

  /// Performs an HTTP 'POST /load' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgLoad] args (required):
  Future<Response> loadWithHttpInfo(
    ArgLoad args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/load';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgLoad] args (required):
  Future<String?> load(
    ArgLoad args,
  ) async {
    final response = await loadWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'String',
      ) as String;
    }
    return null;
  }

  /// Performs an HTTP 'POST /load-from-station' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgLoadFromStation] args (required):
  Future<Response> loadFromStationWithHttpInfo(
    ArgLoadFromStation args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/load-from-station';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgLoadFromStation] args (required):
  Future<String?> loadFromStation(
    ArgLoadFromStation args,
  ) async {
    final response = await loadFromStationWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'String',
      ) as String;
    }
    return null;
  }

  /// Performs an HTTP 'POST /load-money' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgLoadMoney] args (required):
  Future<Response> loadMoneyWithHttpInfo(
    ArgLoadMoney args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/load-money';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgLoadMoney] args (required):
  Future<MoneyReport?> loadMoney(
    ArgLoadMoney args,
  ) async {
    final response = await loadMoneyWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'MoneyReport',
      ) as MoneyReport;
    }
    return null;
  }

  /// Performs an HTTP 'POST /load-relay' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [LoadRelayRequest] args (required):
  Future<Response> loadRelayWithHttpInfo(
    LoadRelayRequest args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/load-relay';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [LoadRelayRequest] args (required):
  Future<RelayReport?> loadRelay(
    LoadRelayRequest args,
  ) async {
    final response = await loadRelayWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'RelayReport',
      ) as RelayReport;
    }
    return null;
  }

  /// Performs an HTTP 'POST /run-dispenser' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgMeasureVolumeMilliliters] args (required):
  Future<Response> measureVolumeMillilitersWithHttpInfo(
    ArgMeasureVolumeMilliliters args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/run-dispenser';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgMeasureVolumeMilliliters] args (required):
  Future<void> measureVolumeMilliliters(
    ArgMeasureVolumeMilliliters args,
  ) async {
    final response = await measureVolumeMillilitersWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /open-station' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgOpenStation] args (required):
  Future<Response> openStationWithHttpInfo(
    ArgOpenStation args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/open-station';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgOpenStation] args (required):
  Future<void> openStation(
    ArgOpenStation args,
  ) async {
    final response = await openStationWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /ping' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgPing] args (required):
  Future<Response> pingWithHttpInfo(
    ArgPing args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/ping';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgPing] args (required):
  Future<ResponsePing?> ping(
    ArgPing args,
  ) async {
    final response = await pingWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'ResponsePing',
      ) as ResponsePing;
    }
    return null;
  }

  /// Performs an HTTP 'POST /press-button' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgPressButton] args (required):
  Future<Response> pressButtonWithHttpInfo(
    ArgPressButton args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/press-button';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgPressButton] args (required):
  Future<void> pressButton(
    ArgPressButton args,
  ) async {
    final response = await pressButtonWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /programs' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgPrograms] args (required):
  Future<Response> programsWithHttpInfo(
    ArgPrograms args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/programs';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgPrograms] args (required):
  Future<List<Program>?> programs(
    ArgPrograms args,
  ) async {
    final response = await programsWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<Program>') as List).cast<Program>().toList();
    }
    return null;
  }

  /// Performs an HTTP 'POST /refresh-session' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [RefreshSession] args (required):
  Future<Response> refreshSessionWithHttpInfo(
    RefreshSession args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/refresh-session';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [RefreshSession] args (required):
  Future<SessionRefresh?> refreshSession(
    RefreshSession args,
  ) async {
    final response = await refreshSessionWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'SessionRefresh',
      ) as SessionRefresh;
    }
    return null;
  }

  /// Performs an HTTP 'POST /reset-station-stat' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgResetStationStat] args:
  Future<Response> resetStationStatWithHttpInfo({
    ArgResetStationStat? args,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/reset-station-stat';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgResetStationStat] args:
  Future<void> resetStationStat({
    ArgResetStationStat? args,
  }) async {
    final response = await resetStationStatWithHttpInfo(
      args: args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /run-2program' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgRun2Program] args (required):
  Future<Response> run2ProgramWithHttpInfo(
    ArgRun2Program args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/run-2program';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgRun2Program] args (required):
  Future<void> run2Program(
    ArgRun2Program args,
  ) async {
    final response = await run2ProgramWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /run-program' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgRunProgram] args (required):
  Future<Response> runProgramWithHttpInfo(
    ArgRunProgram args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/run-program';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgRunProgram] args (required):
  Future<void> runProgram(
    ArgRunProgram args,
  ) async {
    final response = await runProgramWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /save' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgSave] args (required):
  Future<Response> saveWithHttpInfo(
    ArgSave args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/save';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgSave] args (required):
  Future<void> save(
    ArgSave args,
  ) async {
    final response = await saveWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /save-collection' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [StationRequest] args (required):
  Future<Response> saveCollectionWithHttpInfo(
    StationRequest args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/save-collection';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [StationRequest] args (required):
  Future<void> saveCollection(
    StationRequest args,
  ) async {
    final response = await saveCollectionWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /save-if-not-exists' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgSaveIfNotExists] args (required):
  Future<Response> saveIfNotExistsWithHttpInfo(
    ArgSaveIfNotExists args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/save-if-not-exists';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgSaveIfNotExists] args (required):
  Future<void> saveIfNotExists(
    ArgSaveIfNotExists args,
  ) async {
    final response = await saveIfNotExistsWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /save-money' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [MoneyReport] args (required):
  Future<Response> saveMoneyWithHttpInfo(
    MoneyReport args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/save-money';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [MoneyReport] args (required):
  Future<void> saveMoney(
    MoneyReport args,
  ) async {
    final response = await saveMoneyWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /save-relay' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [RelayReport] args (required):
  Future<Response> saveRelayWithHttpInfo(
    RelayReport args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/save-relay';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [RelayReport] args (required):
  Future<void> saveRelay(
    RelayReport args,
  ) async {
    final response = await saveRelayWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /set-bonuses' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgSetBonuses] args (required):
  Future<Response> setBonusesWithHttpInfo(
    ArgSetBonuses args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/set-bonuses';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgSetBonuses] args (required):
  Future<void> setBonuses(
    ArgSetBonuses args,
  ) async {
    final response = await setBonusesWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /set-card-reader-config' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [CardReaderConfig] args (required):
  Future<Response> setCardReaderConfigWithHttpInfo(
    CardReaderConfig args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/set-card-reader-config';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [CardReaderConfig] args (required):
  Future<void> setCardReaderConfig(
    CardReaderConfig args,
  ) async {
    final response = await setCardReaderConfigWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /set-config-var-bool' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ConfigVarBool] args (required):
  Future<Response> setConfigVarBoolWithHttpInfo(
    ConfigVarBool args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/set-config-var-bool';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ConfigVarBool] args (required):
  Future<void> setConfigVarBool(
    ConfigVarBool args,
  ) async {
    final response = await setConfigVarBoolWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /set-config-var-int' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ConfigVarInt] args (required):
  Future<Response> setConfigVarIntWithHttpInfo(
    ConfigVarInt args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/set-config-var-int';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ConfigVarInt] args (required):
  Future<void> setConfigVarInt(
    ConfigVarInt args,
  ) async {
    final response = await setConfigVarIntWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /set-config-var-string' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ConfigVarString] args (required):
  Future<Response> setConfigVarStringWithHttpInfo(
    ConfigVarString args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/set-config-var-string';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ConfigVarString] args (required):
  Future<void> setConfigVarString(
    ConfigVarString args,
  ) async {
    final response = await setConfigVarStringWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /set-kasse' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [KasseConfig] args (required):
  Future<Response> setKasseWithHttpInfo(
    KasseConfig args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/set-kasse';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [KasseConfig] args (required):
  Future<void> setKasse(
    KasseConfig args,
  ) async {
    final response = await setKasseWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /set-program' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [Program] args (required):
  Future<Response> setProgramWithHttpInfo(
    Program args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/set-program';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [Program] args (required):
  Future<void> setProgram(
    Program args,
  ) async {
    final response = await setProgramWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /set-station' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [StationConfig] args (required):
  Future<Response> setStationWithHttpInfo(
    StationConfig args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/set-station';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [StationConfig] args (required):
  Future<void> setStation(
    StationConfig args,
  ) async {
    final response = await setStationWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /set-station-button' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgSetStationButton] args (required):
  Future<Response> setStationButtonWithHttpInfo(
    ArgSetStationButton args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/set-station-button';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgSetStationButton] args (required):
  Future<void> setStationButton(
    ArgSetStationButton args,
  ) async {
    final response = await setStationButtonWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /station' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [StationRequest] args (required):
  Future<Response> stationWithHttpInfo(
    StationRequest args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/station';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [StationRequest] args (required):
  Future<StationConfig?> station(
    StationRequest args,
  ) async {
    final response = await stationWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'StationConfig',
      ) as StationConfig;
    }
    return null;
  }

  /// Performs an HTTP 'POST /station-button' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgStationButton] args (required):
  Future<Response> stationButtonWithHttpInfo(
    ArgStationButton args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/station-button';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgStationButton] args (required):
  Future<ResponseStationButton?> stationButton(
    ArgStationButton args,
  ) async {
    final response = await stationButtonWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'ResponseStationButton',
      ) as ResponseStationButton;
    }
    return null;
  }

  /// Performs an HTTP 'POST /station-by-hash' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgStationByHash] args (required):
  Future<Response> stationByHashWithHttpInfo(
    ArgStationByHash args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/station-by-hash';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgStationByHash] args (required):
  Future<int?> stationByHash(
    ArgStationByHash args,
  ) async {
    final response = await stationByHashWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'int',
      ) as int;
    }
    return null;
  }

  /// Performs an HTTP 'POST /station-collection-report-dates' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgCollectionReportDates] args (required):
  Future<Response> stationCollectionReportDatesWithHttpInfo(
    ArgCollectionReportDates args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/station-collection-report-dates';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgCollectionReportDates] args (required):
  Future<ResponseStationCollectionReportDates?> stationCollectionReportDates(
    ArgCollectionReportDates args,
  ) async {
    final response = await stationCollectionReportDatesWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'ResponseStationCollectionReportDates',
      ) as ResponseStationCollectionReportDates;
    }
    return null;
  }

  /// Performs an HTTP 'POST /station-program-by-hash' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgStationProgramByHash] args (required):
  Future<Response> stationProgramByHashWithHttpInfo(
    ArgStationProgramByHash args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/station-program-by-hash';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgStationProgramByHash] args (required):
  Future<StationPrograms?> stationProgramByHash(
    ArgStationProgramByHash args,
  ) async {
    final response = await stationProgramByHashWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'StationPrograms',
      ) as StationPrograms;
    }
    return null;
  }

  /// Performs an HTTP 'POST /station-report-current-money' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgStationReportCurrentMoney] args (required):
  Future<Response> stationReportCurrentMoneyWithHttpInfo(
    ArgStationReportCurrentMoney args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/station-report-current-money';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgStationReportCurrentMoney] args (required):
  Future<StationReport?> stationReportCurrentMoney(
    ArgStationReportCurrentMoney args,
  ) async {
    final response = await stationReportCurrentMoneyWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'StationReport',
      ) as StationReport;
    }
    return null;
  }

  /// Performs an HTTP 'POST /station-report-dates' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgStationReportDates] args (required):
  Future<Response> stationReportDatesWithHttpInfo(
    ArgStationReportDates args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/station-report-dates';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgStationReportDates] args (required):
  Future<StationReport?> stationReportDates(
    ArgStationReportDates args,
  ) async {
    final response = await stationReportDatesWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'StationReport',
      ) as StationReport;
    }
    return null;
  }

  /// Performs an HTTP 'POST /station-stat-current' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgStationStat] args:
  Future<Response> stationStatCurrentWithHttpInfo({
    ArgStationStat? args,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/station-stat-current';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgStationStat] args:
  Future<List<StationStat>?> stationStatCurrent({
    ArgStationStat? args,
  }) async {
    final response = await stationStatCurrentWithHttpInfo(
      args: args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<StationStat>') as List).cast<StationStat>().toList();
    }
    return null;
  }

  /// Performs an HTTP 'POST /station-stat-dates' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgStationStatDates] args:
  Future<Response> stationStatDatesWithHttpInfo({
    ArgStationStatDates? args,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/station-stat-dates';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgStationStatDates] args:
  Future<List<StationStat>?> stationStatDates({
    ArgStationStatDates? args,
  }) async {
    final response = await stationStatDatesWithHttpInfo(
      args: args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<StationStat>') as List).cast<StationStat>().toList();
    }
    return null;
  }

  /// Performs an HTTP 'POST /stations-variables' operation and returns the [Response].
  Future<Response> stationsVariablesWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/stations-variables';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  Future<List<StationsVariables>?> stationsVariables() async {
    final response = await stationsVariablesWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<StationsVariables>') as List).cast<StationsVariables>().toList();
    }
    return null;
  }

  /// Performs an HTTP 'GET /status' operation and returns the [Response].
  Future<Response> statusWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/status';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  Future<StatusReport?> status() async {
    final response = await statusWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'StatusReport',
      ) as StatusReport;
    }
    return null;
  }

  /// Performs an HTTP 'GET /status-collection' operation and returns the [Response].
  Future<Response> statusCollectionWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/status-collection';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  Future<StatusCollectionReport?> statusCollection() async {
    final response = await statusCollectionWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'StatusCollectionReport',
      ) as StatusCollectionReport;
    }
    return null;
  }

  /// Performs an HTTP 'PUT /user' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgUserUpdate] args (required):
  Future<Response> updateUserWithHttpInfo(
    ArgUserUpdate args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/user';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgUserUpdate] args (required):
  Future<ResponseUserUpdate?> updateUser(
    ArgUserUpdate args,
  ) async {
    final response = await updateUserWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'ResponseUserUpdate',
      ) as ResponseUserUpdate;
    }
    return null;
  }

  /// Performs an HTTP 'POST /user-password' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgUserPassword] args (required):
  Future<Response> updateUserPasswordWithHttpInfo(
    ArgUserPassword args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/user-password';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ArgUserPassword] args (required):
  Future<ResponseUserPassword?> updateUserPassword(
    ArgUserPassword args,
  ) async {
    final response = await updateUserPasswordWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'ResponseUserPassword',
      ) as ResponseUserPassword;
    }
    return null;
  }

  /// Performs an HTTP 'POST /volume-dispenser' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [VolumeDispenser] args (required):
  Future<Response> volumeDispenserWithHttpInfo(
    VolumeDispenser args,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/volume-dispenser';

    // ignore: prefer_final_locals
    Object? postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [VolumeDispenser] args (required):
  Future<ResponseVolumeDispenser?> volumeDispenser(
    VolumeDispenser args,
  ) async {
    final response = await volumeDispenserWithHttpInfo(
      args,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'ResponseVolumeDispenser',
      ) as ResponseVolumeDispenser;
    }
    return null;
  }
}
