//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DefaultApi {
  DefaultApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'POST /add-advertising-campaign' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [AdvertisingCampaign] args:
  Future<Response> addAdvertisingCampaignWithHttpInfo({AdvertisingCampaign args}) async {
    // Verify required params are set.

    final path = r'/add-advertising-campaign';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>['pinCode'];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [AdvertisingCampaign] args:
  Future<void> addAdvertisingCampaign({AdvertisingCampaign args}) async {
    final response = await addAdvertisingCampaignWithHttpInfo(args: args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /add-service-amount' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgAddServiceAmount] args (required):
  Future<Response> addServiceAmountWithHttpInfo(ArgAddServiceAmount args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/add-service-amount';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgAddServiceAmount] args (required):
  Future<void> addServiceAmount(ArgAddServiceAmount args) async {
    final response = await addServiceAmountWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /advertising-campaign' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgAdvertisingCampagin] args:
  Future<Response> advertisingCampaignWithHttpInfo({ArgAdvertisingCampagin args}) async {
    // Verify required params are set.

    final path = r'/advertising-campaign';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>['pinCode'];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgAdvertisingCampagin] args:
  Future<List<AdvertisingCampaign>> advertisingCampaign({ArgAdvertisingCampagin args}) async {
    final response = await advertisingCampaignWithHttpInfo(args: args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return (await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'List<AdvertisingCampaign>') as List).cast<AdvertisingCampaign>().toList(growable: false);
    }
    return Future<List<AdvertisingCampaign>>.value(null);
  }

  /// Performs an HTTP 'POST /advertising-campaign-by-id' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgAdvertisingCampaignByID] args:
  Future<Response> advertisingCampaignByIDWithHttpInfo({ArgAdvertisingCampaignByID args}) async {
    // Verify required params are set.

    final path = r'/advertising-campaign-by-id';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>['pinCode'];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgAdvertisingCampaignByID] args:
  Future<AdvertisingCampaign> advertisingCampaignByID({ArgAdvertisingCampaignByID args}) async {
    final response = await advertisingCampaignByIDWithHttpInfo(args: args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'AdvertisingCampaign',
      ) as AdvertisingCampaign;
    }
    return Future<AdvertisingCampaign>.value(null);
  }

  /// Performs an HTTP 'POST /card-reader-config' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgCardReaderConfig] args (required):
  Future<Response> cardReaderConfigWithHttpInfo(ArgCardReaderConfig args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/card-reader-config';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgCardReaderConfig] args (required):
  Future<CardReaderConfig> cardReaderConfig(ArgCardReaderConfig args) async {
    final response = await cardReaderConfigWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'CardReaderConfig',
      ) as CardReaderConfig;
    }
    return Future<CardReaderConfig>.value(null);
  }

  /// Performs an HTTP 'POST /card-reader-config-by-hash' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgCardReaderConfigByCash] args (required):
  Future<Response> cardReaderConfigByHashWithHttpInfo(ArgCardReaderConfigByCash args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/card-reader-config-by-hash';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgCardReaderConfigByCash] args (required):
  Future<CardReaderConfig> cardReaderConfigByHash(ArgCardReaderConfigByCash args) async {
    final response = await cardReaderConfigByHashWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'CardReaderConfig',
      ) as CardReaderConfig;
    }
    return Future<CardReaderConfig>.value(null);
  }

  /// Performs an HTTP 'POST /user' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgUserCreate] args (required):
  Future<Response> createUserWithHttpInfo(ArgUserCreate args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/user';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>['pinCode'];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgUserCreate] args (required):
  Future<ResponseUserCreate> createUser(ArgUserCreate args) async {
    final response = await createUserWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'ResponseUserCreate',
      ) as ResponseUserCreate;
    }
    return Future<ResponseUserCreate>.value(null);
  }

  /// Performs an HTTP 'POST /del-advertising-campaign' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgDelAdvertisingCampagin] args:
  Future<Response> delAdvertisingCampaignWithHttpInfo({ArgDelAdvertisingCampagin args}) async {
    // Verify required params are set.

    final path = r'/del-advertising-campaign';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>['pinCode'];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgDelAdvertisingCampagin] args:
  Future<void> delAdvertisingCampaign({ArgDelAdvertisingCampagin args}) async {
    final response = await delAdvertisingCampaignWithHttpInfo(args: args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /del-station' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgDelStation] args (required):
  Future<Response> delStationWithHttpInfo(ArgDelStation args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/del-station';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgDelStation] args (required):
  Future<void> delStation(ArgDelStation args) async {
    final response = await delStationWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'DELETE /user' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgUserDelete] args (required):
  Future<Response> deleteUserWithHttpInfo(ArgUserDelete args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/user';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>['pinCode'];

    return await apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgUserDelete] args (required):
  Future<void> deleteUser(ArgUserDelete args) async {
    final response = await deleteUserWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /edit-advertising-campaign' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [AdvertisingCampaign] args:
  Future<Response> editAdvertisingCampaignWithHttpInfo({AdvertisingCampaign args}) async {
    // Verify required params are set.

    final path = r'/edit-advertising-campaign';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>['pinCode'];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [AdvertisingCampaign] args:
  Future<void> editAdvertisingCampaign({AdvertisingCampaign args}) async {
    final response = await editAdvertisingCampaignWithHttpInfo(args: args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /ping' operation and returns the [Response].
  Future<Response> getPingWithHttpInfo() async {
    final path = r'/ping';

    Object postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>[];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  Future<void> getPing() async {
    final response = await getPingWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /user' operation and returns the [Response].
  Future<Response> getUserWithHttpInfo() async {
    final path = r'/user';

    Object postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>[];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>['pinCode'];

    return await apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  Future<UserConfig> getUser() async {
    final response = await getUserWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'UserConfig',
      ) as UserConfig;
    }
    return Future<UserConfig>.value(null);
  }

  /// Performs an HTTP 'GET /users' operation and returns the [Response].
  Future<Response> getUsersWithHttpInfo() async {
    final path = r'/users';

    Object postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>[];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>['pinCode'];

    return await apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  Future<UsersReport> getUsers() async {
    final response = await getUsersWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'UsersReport',
      ) as UsersReport;
    }
    return Future<UsersReport>.value(null);
  }

  /// Performs an HTTP 'GET /info' operation and returns the [Response].
  Future<Response> infoWithHttpInfo() async {
    final path = r'/info';

    Object postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>[];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  Future<String> info() async {
    final response = await infoWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'String',
      ) as String;
    }
    return Future<String>.value(null);
  }

  /// Performs an HTTP 'POST /kasse' operation and returns the [Response].
  Future<Response> kasseWithHttpInfo() async {
    final path = r'/kasse';

    Object postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>[];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  Future<KasseConfig> kasse() async {
    final response = await kasseWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'KasseConfig',
      ) as KasseConfig;
    }
    return Future<KasseConfig>.value(null);
  }

  /// Performs an HTTP 'POST /load' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgLoad] args (required):
  Future<Response> loadWithHttpInfo(ArgLoad args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/load';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgLoad] args (required):
  Future<String> load(ArgLoad args) async {
    final response = await loadWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'String',
      ) as String;
    }
    return Future<String>.value(null);
  }

  /// Performs an HTTP 'POST /load-from-station' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgLoadFromStation] args (required):
  Future<Response> loadFromStationWithHttpInfo(ArgLoadFromStation args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/load-from-station';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgLoadFromStation] args (required):
  Future<String> loadFromStation(ArgLoadFromStation args) async {
    final response = await loadFromStationWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'String',
      ) as String;
    }
    return Future<String>.value(null);
  }

  /// Performs an HTTP 'POST /load-money' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgLoadMoney] args (required):
  Future<Response> loadMoneyWithHttpInfo(ArgLoadMoney args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/load-money';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgLoadMoney] args (required):
  Future<MoneyReport> loadMoney(ArgLoadMoney args) async {
    final response = await loadMoneyWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'MoneyReport',
      ) as MoneyReport;
    }
    return Future<MoneyReport>.value(null);
  }

  /// Performs an HTTP 'POST /load-relay' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgLoadRelay] args (required):
  Future<Response> loadRelayWithHttpInfo(ArgLoadRelay args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/load-relay';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgLoadRelay] args (required):
  Future<RelayReport> loadRelay(ArgLoadRelay args) async {
    final response = await loadRelayWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'RelayReport',
      ) as RelayReport;
    }
    return Future<RelayReport>.value(null);
  }

  /// Performs an HTTP 'POST /open-station' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgOpenStation] args (required):
  Future<Response> openStationWithHttpInfo(ArgOpenStation args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/open-station';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgOpenStation] args (required):
  Future<void> openStation(ArgOpenStation args) async {
    final response = await openStationWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /ping' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgPing] args (required):
  Future<Response> pingWithHttpInfo(ArgPing args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/ping';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgPing] args (required):
  Future<ResponsePing> ping(ArgPing args) async {
    final response = await pingWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'ResponsePing',
      ) as ResponsePing;
    }
    return Future<ResponsePing>.value(null);
  }

  /// Performs an HTTP 'POST /press-button' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgPressButton] args (required):
  Future<Response> pressButtonWithHttpInfo(ArgPressButton args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/press-button';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgPressButton] args (required):
  Future<void> pressButton(ArgPressButton args) async {
    final response = await pressButtonWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /programs' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgPrograms] args (required):
  Future<Response> programsWithHttpInfo(ArgPrograms args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/programs';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgPrograms] args (required):
  Future<List<Program>> programs(ArgPrograms args) async {
    final response = await programsWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return (await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'List<Program>') as List).cast<Program>().toList(growable: false);
    }
    return Future<List<Program>>.value(null);
  }

  /// Performs an HTTP 'POST /reset-station-stat' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgResetStationStat] args:
  Future<Response> resetStationStatWithHttpInfo({ArgResetStationStat args}) async {
    // Verify required params are set.

    final path = r'/reset-station-stat';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>['pinCode'];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgResetStationStat] args:
  Future<void> resetStationStat({ArgResetStationStat args}) async {
    final response = await resetStationStatWithHttpInfo(args: args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /run-program' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgRunProgram] args (required):
  Future<Response> runProgramWithHttpInfo(ArgRunProgram args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/run-program';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgRunProgram] args (required):
  Future<void> runProgram(ArgRunProgram args) async {
    final response = await runProgramWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /save' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgSave] args (required):
  Future<Response> saveWithHttpInfo(ArgSave args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/save';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgSave] args (required):
  Future<void> save(ArgSave args) async {
    final response = await saveWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /save-collection' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgSaveCollection] args (required):
  Future<Response> saveCollectionWithHttpInfo(ArgSaveCollection args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/save-collection';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>['pinCode'];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgSaveCollection] args (required):
  Future<void> saveCollection(ArgSaveCollection args) async {
    final response = await saveCollectionWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /save-if-not-exists' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgSaveIfNotExists] args (required):
  Future<Response> saveIfNotExistsWithHttpInfo(ArgSaveIfNotExists args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/save-if-not-exists';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgSaveIfNotExists] args (required):
  Future<void> saveIfNotExists(ArgSaveIfNotExists args) async {
    final response = await saveIfNotExistsWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /save-money' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [MoneyReport] args (required):
  Future<Response> saveMoneyWithHttpInfo(MoneyReport args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/save-money';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [MoneyReport] args (required):
  Future<void> saveMoney(MoneyReport args) async {
    final response = await saveMoneyWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /save-relay' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [RelayReport] args (required):
  Future<Response> saveRelayWithHttpInfo(RelayReport args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/save-relay';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [RelayReport] args (required):
  Future<void> saveRelay(RelayReport args) async {
    final response = await saveRelayWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /set-card-reader-config' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [CardReaderConfig] args (required):
  Future<Response> setCardReaderConfigWithHttpInfo(CardReaderConfig args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/set-card-reader-config';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [CardReaderConfig] args (required):
  Future<void> setCardReaderConfig(CardReaderConfig args) async {
    final response = await setCardReaderConfigWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /set-kasse' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [KasseConfig] args (required):
  Future<Response> setKasseWithHttpInfo(KasseConfig args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/set-kasse';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [KasseConfig] args (required):
  Future<void> setKasse(KasseConfig args) async {
    final response = await setKasseWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /set-program' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [Program] args (required):
  Future<Response> setProgramWithHttpInfo(Program args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/set-program';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [Program] args (required):
  Future<void> setProgram(Program args) async {
    final response = await setProgramWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /set-station' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [StationConfig] args (required):
  Future<Response> setStationWithHttpInfo(StationConfig args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/set-station';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [StationConfig] args (required):
  Future<void> setStation(StationConfig args) async {
    final response = await setStationWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /set-station-button' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgSetStationButton] args (required):
  Future<Response> setStationButtonWithHttpInfo(ArgSetStationButton args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/set-station-button';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgSetStationButton] args (required):
  Future<void> setStationButton(ArgSetStationButton args) async {
    final response = await setStationButtonWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /station' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgStation] args (required):
  Future<Response> stationWithHttpInfo(ArgStation args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/station';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgStation] args (required):
  Future<StationConfig> station(ArgStation args) async {
    final response = await stationWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'StationConfig',
      ) as StationConfig;
    }
    return Future<StationConfig>.value(null);
  }

  /// Performs an HTTP 'POST /station-button' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgStationButton] args (required):
  Future<Response> stationButtonWithHttpInfo(ArgStationButton args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/station-button';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgStationButton] args (required):
  Future<ResponseStationButton> stationButton(ArgStationButton args) async {
    final response = await stationButtonWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'ResponseStationButton',
      ) as ResponseStationButton;
    }
    return Future<ResponseStationButton>.value(null);
  }

  /// Performs an HTTP 'POST /station-by-hash' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgStationByHash] args (required):
  Future<Response> stationByHashWithHttpInfo(ArgStationByHash args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/station-by-hash';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgStationByHash] args (required):
  Future<int> stationByHash(ArgStationByHash args) async {
    final response = await stationByHashWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'int',
      ) as int;
    }
    return Future<int>.value(null);
  }

  /// Performs an HTTP 'POST /station-collection-report-dates' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgCollectionReportDates] args (required):
  Future<Response> stationCollectionReportDatesWithHttpInfo(ArgCollectionReportDates args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/station-collection-report-dates';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>['pinCode'];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgCollectionReportDates] args (required):
  Future<ResponseStationCollectionReportDates> stationCollectionReportDates(ArgCollectionReportDates args) async {
    final response = await stationCollectionReportDatesWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'ResponseStationCollectionReportDates',
      ) as ResponseStationCollectionReportDates;
    }
    return Future<ResponseStationCollectionReportDates>.value(null);
  }

  /// Performs an HTTP 'POST /station-program-by-hash' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgStationProgramByHash] args (required):
  Future<Response> stationProgramByHashWithHttpInfo(ArgStationProgramByHash args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/station-program-by-hash';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgStationProgramByHash] args (required):
  Future<StationPrograms> stationProgramByHash(ArgStationProgramByHash args) async {
    final response = await stationProgramByHashWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'StationPrograms',
      ) as StationPrograms;
    }
    return Future<StationPrograms>.value(null);
  }

  /// Performs an HTTP 'POST /station-report-current-money' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgStationReportCurrentMoney] args (required):
  Future<Response> stationReportCurrentMoneyWithHttpInfo(ArgStationReportCurrentMoney args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/station-report-current-money';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgStationReportCurrentMoney] args (required):
  Future<StationReport> stationReportCurrentMoney(ArgStationReportCurrentMoney args) async {
    final response = await stationReportCurrentMoneyWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'StationReport',
      ) as StationReport;
    }
    return Future<StationReport>.value(null);
  }

  /// Performs an HTTP 'POST /station-report-dates' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgStationReportDates] args (required):
  Future<Response> stationReportDatesWithHttpInfo(ArgStationReportDates args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/station-report-dates';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgStationReportDates] args (required):
  Future<StationReport> stationReportDates(ArgStationReportDates args) async {
    final response = await stationReportDatesWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'StationReport',
      ) as StationReport;
    }
    return Future<StationReport>.value(null);
  }

  /// Performs an HTTP 'POST /station-stat-current' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgStationStat] args:
  Future<Response> stationStatCurrentWithHttpInfo({ArgStationStat args}) async {
    // Verify required params are set.

    final path = r'/station-stat-current';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>['pinCode'];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgStationStat] args:
  Future<List<StationStat>> stationStatCurrent({ArgStationStat args}) async {
    final response = await stationStatCurrentWithHttpInfo(args: args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return (await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'List<StationStat>') as List).cast<StationStat>().toList(growable: false);
    }
    return Future<List<StationStat>>.value(null);
  }

  /// Performs an HTTP 'POST /station-stat-dates' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgStationStatDates] args:
  Future<Response> stationStatDatesWithHttpInfo({ArgStationStatDates args}) async {
    // Verify required params are set.

    final path = r'/station-stat-dates';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>['pinCode'];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgStationStatDates] args:
  Future<List<StationStat>> stationStatDates({ArgStationStatDates args}) async {
    final response = await stationStatDatesWithHttpInfo(args: args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return (await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'List<StationStat>') as List).cast<StationStat>().toList(growable: false);
    }
    return Future<List<StationStat>>.value(null);
  }

  /// Performs an HTTP 'POST /stations-variables' operation and returns the [Response].
  Future<Response> stationsVariablesWithHttpInfo() async {
    final path = r'/stations-variables';

    Object postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>[];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  Future<List<StationsVariables>> stationsVariables() async {
    final response = await stationsVariablesWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return (await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'List<StationsVariables>') as List).cast<StationsVariables>().toList(growable: false);
    }
    return Future<List<StationsVariables>>.value(null);
  }

  /// Performs an HTTP 'GET /status' operation and returns the [Response].
  Future<Response> statusWithHttpInfo() async {
    final path = r'/status';

    Object postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>[];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    return await apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  Future<StatusReport> status() async {
    final response = await statusWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'StatusReport',
      ) as StatusReport;
    }
    return Future<StatusReport>.value(null);
  }

  /// Performs an HTTP 'GET /status-collection' operation and returns the [Response].
  Future<Response> statusCollectionWithHttpInfo() async {
    final path = r'/status-collection';

    Object postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>[];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>['pinCode'];

    return await apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  Future<StatusCollectionReport> statusCollection() async {
    final response = await statusCollectionWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'StatusCollectionReport',
      ) as StatusCollectionReport;
    }
    return Future<StatusCollectionReport>.value(null);
  }

  /// Performs an HTTP 'PUT /user' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgUserUpdate] args (required):
  Future<Response> updateUserWithHttpInfo(ArgUserUpdate args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/user';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>['pinCode'];

    return await apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgUserUpdate] args (required):
  Future<ResponseUserUpdate> updateUser(ArgUserUpdate args) async {
    final response = await updateUserWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'ResponseUserUpdate',
      ) as ResponseUserUpdate;
    }
    return Future<ResponseUserUpdate>.value(null);
  }

  /// Performs an HTTP 'POST /user-password' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArgUserPassword] args (required):
  Future<Response> updateUserPasswordWithHttpInfo(ArgUserPassword args) async {
    // Verify required params are set.
    if (args == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: args');
    }

    final path = r'/user-password';

    Object postBody = args;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>['pinCode'];

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [ArgUserPassword] args (required):
  Future<ResponseUserPassword> updateUserPassword(ArgUserPassword args) async {
    final response = await updateUserPasswordWithHttpInfo(args);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'ResponseUserPassword',
      ) as ResponseUserPassword;
    }
    return Future<ResponseUserPassword>.value(null);
  }
}
