//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class WashServersApi {
  WashServersApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'POST /server-groups/{groupId}/wash-servers/{serverId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] groupId (required):
  ///
  /// * [String] serverId (required):
  Future<Response> assignServerToGroupWithHttpInfo(String groupId, String serverId,) async {
    // ignore: prefer_const_declarations
    final path = r'/server-groups/{groupId}/wash-servers/{serverId}'
      .replaceAll('{groupId}', groupId)
      .replaceAll('{serverId}', serverId);

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

  /// Parameters:
  ///
  /// * [String] groupId (required):
  ///
  /// * [String] serverId (required):
  Future<void> assignServerToGroup(String groupId, String serverId,) async {
    final response = await assignServerToGroupWithHttpInfo(groupId, serverId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /wash-servers/' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [WashServerCreation] body:
  Future<Response> createWashServerWithHttpInfo({ WashServerCreation? body, }) async {
    // ignore: prefer_const_declarations
    final path = r'/wash-servers/';

    // ignore: prefer_final_locals
    Object? postBody = body;

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
  /// * [WashServerCreation] body:
  Future<WashServer?> createWashServer({ WashServerCreation? body, }) async {
    final response = await createWashServerWithHttpInfo( body: body, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'WashServer',) as WashServer;
    
    }
    return null;
  }

  /// Performs an HTTP 'DELETE /wash-servers/{serverId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] serverId (required):
  Future<Response> deleteWashServerWithHttpInfo(String serverId,) async {
    // ignore: prefer_const_declarations
    final path = r'/wash-servers/{serverId}'
      .replaceAll('{serverId}', serverId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


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
  /// * [String] serverId (required):
  Future<void> deleteWashServer(String serverId,) async {
    final response = await deleteWashServerWithHttpInfo(serverId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /wash-servers/{serverId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] serverId (required):
  Future<Response> getWashServerByIdWithHttpInfo(String serverId,) async {
    // ignore: prefer_const_declarations
    final path = r'/wash-servers/{serverId}'
      .replaceAll('{serverId}', serverId);

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

  /// Parameters:
  ///
  /// * [String] serverId (required):
  Future<WashServer?> getWashServerById(String serverId,) async {
    final response = await getWashServerByIdWithHttpInfo(serverId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'WashServer',) as WashServer;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /wash-servers/' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] offset:
  ///   Number of records to skip for pagination
  ///
  /// * [int] limit:
  ///   Maximum number of records to return
  ///
  /// * [bool] isManagedByMe:
  ///
  /// * [String] organizationId:
  ///
  /// * [String] groupId:
  Future<Response> getWashServersWithHttpInfo({ int? offset, int? limit, bool? isManagedByMe, String? organizationId, String? groupId, }) async {
    // ignore: prefer_const_declarations
    final path = r'/wash-servers/';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (offset != null) {
      queryParams.addAll(_queryParams('', 'offset', offset));
    }
    if (limit != null) {
      queryParams.addAll(_queryParams('', 'limit', limit));
    }
    if (isManagedByMe != null) {
      queryParams.addAll(_queryParams('', 'isManagedByMe', isManagedByMe));
    }
    if (organizationId != null) {
      queryParams.addAll(_queryParams('', 'organizationId', organizationId));
    }
    if (groupId != null) {
      queryParams.addAll(_queryParams('', 'groupId', groupId));
    }

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

  /// Parameters:
  ///
  /// * [int] offset:
  ///   Number of records to skip for pagination
  ///
  /// * [int] limit:
  ///   Maximum number of records to return
  ///
  /// * [bool] isManagedByMe:
  ///
  /// * [String] organizationId:
  ///
  /// * [String] groupId:
  Future<List<WashServer>?> getWashServers({ int? offset, int? limit, bool? isManagedByMe, String? organizationId, String? groupId, }) async {
    final response = await getWashServersWithHttpInfo( offset: offset, limit: limit, isManagedByMe: isManagedByMe, organizationId: organizationId, groupId: groupId, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<WashServer>') as List)
        .cast<WashServer>()
        .toList();

    }
    return null;
  }

  /// Performs an HTTP 'PATCH /wash-servers/{serverId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] serverId (required):
  ///
  /// * [WashServerUpdate] body:
  Future<Response> updateWashServerWithHttpInfo(String serverId, { WashServerUpdate? body, }) async {
    // ignore: prefer_const_declarations
    final path = r'/wash-servers/{serverId}'
      .replaceAll('{serverId}', serverId);

    // ignore: prefer_final_locals
    Object? postBody = body;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'PATCH',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [String] serverId (required):
  ///
  /// * [WashServerUpdate] body:
  Future<WashServer?> updateWashServer(String serverId, { WashServerUpdate? body, }) async {
    final response = await updateWashServerWithHttpInfo(serverId,  body: body, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'WashServer',) as WashServer;
    
    }
    return null;
  }
}
