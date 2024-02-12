//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class UsersApi {
  UsersApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'DELETE /users/{userId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] userId (required):
  Future<Response> blockAdminUserWithHttpInfo(String userId,) async {
    // ignore: prefer_const_declarations
    final path = r'/users/{userId}'
      .replaceAll('{userId}', userId);

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
  /// * [String] userId (required):
  Future<void> blockAdminUser(String userId,) async {
    final response = await blockAdminUserWithHttpInfo(userId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /users/{userId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] userId (required):
  Future<Response> getAdminUserByIdWithHttpInfo(String userId,) async {
    // ignore: prefer_const_declarations
    final path = r'/users/{userId}'
      .replaceAll('{userId}', userId);

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
  /// * [String] userId (required):
  Future<AdminUser?> getAdminUserById(String userId,) async {
    final response = await getAdminUserByIdWithHttpInfo(userId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AdminUser',) as AdminUser;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /users' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] offset:
  ///   Number of records to skip for pagination
  ///
  /// * [int] limit:
  ///   Maximum number of records to return
  ///
  /// * [String] role:
  ///
  /// * [bool] isBlocked:
  Future<Response> getAdminUsersWithHttpInfo({ int? offset, int? limit, String? role, bool? isBlocked, }) async {
    // ignore: prefer_const_declarations
    final path = r'/users';

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
    if (role != null) {
      queryParams.addAll(_queryParams('', 'role', role));
    }
    if (isBlocked != null) {
      queryParams.addAll(_queryParams('', 'isBlocked', isBlocked));
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
  /// * [String] role:
  ///
  /// * [bool] isBlocked:
  Future<List<AdminUser>?> getAdminUsers({ int? offset, int? limit, String? role, bool? isBlocked, }) async {
    final response = await getAdminUsersWithHttpInfo( offset: offset, limit: limit, role: role, isBlocked: isBlocked, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<AdminUser>') as List)
        .cast<AdminUser>()
        .toList();

    }
    return null;
  }

  /// Performs an HTTP 'PATCH /users/{userId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] userId (required):
  ///
  /// * [UpdateAdminUserRoleRequest] body (required):
  Future<Response> updateAdminUserRoleWithHttpInfo(String userId, UpdateAdminUserRoleRequest body,) async {
    // ignore: prefer_const_declarations
    final path = r'/users/{userId}'
      .replaceAll('{userId}', userId);

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
  /// * [String] userId (required):
  ///
  /// * [UpdateAdminUserRoleRequest] body (required):
  Future<void> updateAdminUserRole(String userId, UpdateAdminUserRoleRequest body,) async {
    final response = await updateAdminUserRoleWithHttpInfo(userId, body,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
