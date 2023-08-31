//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ServerGroupsApi {
  ServerGroupsApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'POST /server-groups' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ServerGroupCreation] body:
  Future<Response> createServerGroupWithHttpInfo({ ServerGroupCreation? body, }) async {
    // ignore: prefer_const_declarations
    final path = r'/server-groups';

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
  /// * [ServerGroupCreation] body:
  Future<ServerGroup?> createServerGroup({ ServerGroupCreation? body, }) async {
    final response = await createServerGroupWithHttpInfo( body: body, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ServerGroup',) as ServerGroup;
    
    }
    return null;
  }

  /// Performs an HTTP 'DELETE /server-groups/{groupId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] groupId (required):
  Future<Response> deleteServerGroupWithHttpInfo(String groupId,) async {
    // ignore: prefer_const_declarations
    final path = r'/server-groups/{groupId}'
      .replaceAll('{groupId}', groupId);

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
  /// * [String] groupId (required):
  Future<void> deleteServerGroup(String groupId,) async {
    final response = await deleteServerGroupWithHttpInfo(groupId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /server-groups/{groupId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] groupId (required):
  Future<Response> getServerGroupByIdWithHttpInfo(String groupId,) async {
    // ignore: prefer_const_declarations
    final path = r'/server-groups/{groupId}'
      .replaceAll('{groupId}', groupId);

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
  /// * [String] groupId (required):
  Future<ServerGroup?> getServerGroupById(String groupId,) async {
    final response = await getServerGroupByIdWithHttpInfo(groupId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ServerGroup',) as ServerGroup;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /server-groups' operation and returns the [Response].
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
  Future<Response> getServerGroupsWithHttpInfo({ int? offset, int? limit, bool? isManagedByMe, String? organizationId, }) async {
    // ignore: prefer_const_declarations
    final path = r'/server-groups';

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
  Future<List<ServerGroup>?> getServerGroups({ int? offset, int? limit, bool? isManagedByMe, String? organizationId, }) async {
    final response = await getServerGroupsWithHttpInfo( offset: offset, limit: limit, isManagedByMe: isManagedByMe, organizationId: organizationId, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<ServerGroup>') as List)
        .cast<ServerGroup>()
        .toList();

    }
    return null;
  }

  /// Performs an HTTP 'PATCH /server-groups/{groupId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] groupId (required):
  ///
  /// * [ServerGroupUpdate] body:
  Future<Response> updateServerGroupWithHttpInfo(String groupId, { ServerGroupUpdate? body, }) async {
    // ignore: prefer_const_declarations
    final path = r'/server-groups/{groupId}'
      .replaceAll('{groupId}', groupId);

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
  /// * [String] groupId (required):
  ///
  /// * [ServerGroupUpdate] body:
  Future<ServerGroup?> updateServerGroup(String groupId, { ServerGroupUpdate? body, }) async {
    final response = await updateServerGroupWithHttpInfo(groupId,  body: body, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ServerGroup',) as ServerGroup;
    
    }
    return null;
  }
}
