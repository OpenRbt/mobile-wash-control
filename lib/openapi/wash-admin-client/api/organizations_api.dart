//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class OrganizationsApi {
  OrganizationsApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'POST /organizations/{organizationId}/users/{userId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] organizationId (required):
  ///
  /// * [String] userId (required):
  Future<Response> assignUserToOrganizationWithHttpInfo(String organizationId, String userId,) async {
    // ignore: prefer_const_declarations
    final path = r'/organizations/{organizationId}/users/{userId}'
      .replaceAll('{organizationId}', organizationId)
      .replaceAll('{userId}', userId);

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
  /// * [String] organizationId (required):
  ///
  /// * [String] userId (required):
  Future<void> assignUserToOrganization(String organizationId, String userId,) async {
    final response = await assignUserToOrganizationWithHttpInfo(organizationId, userId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /organizations' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [OrganizationCreation] body:
  Future<Response> createOrganizationWithHttpInfo({ OrganizationCreation? body, }) async {
    // ignore: prefer_const_declarations
    final path = r'/organizations';

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
  /// * [OrganizationCreation] body:
  Future<Organization?> createOrganization({ OrganizationCreation? body, }) async {
    final response = await createOrganizationWithHttpInfo( body: body, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Organization',) as Organization;
    
    }
    return null;
  }

  /// Performs an HTTP 'DELETE /organizations/{organizationId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] organizationId (required):
  Future<Response> deleteOrganizationWithHttpInfo(String organizationId,) async {
    // ignore: prefer_const_declarations
    final path = r'/organizations/{organizationId}'
      .replaceAll('{organizationId}', organizationId);

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
  /// * [String] organizationId (required):
  Future<void> deleteOrganization(String organizationId,) async {
    final response = await deleteOrganizationWithHttpInfo(organizationId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /organizations/{organizationId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] organizationId (required):
  Future<Response> getOrganizationByIdWithHttpInfo(String organizationId,) async {
    // ignore: prefer_const_declarations
    final path = r'/organizations/{organizationId}'
      .replaceAll('{organizationId}', organizationId);

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
  /// * [String] organizationId (required):
  Future<Organization?> getOrganizationById(String organizationId,) async {
    final response = await getOrganizationByIdWithHttpInfo(organizationId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Organization',) as Organization;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /organizations' operation and returns the [Response].
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
  /// * [List<String>] ids:
  Future<Response> getOrganizationsWithHttpInfo({ int? offset, int? limit, bool? isManagedByMe, List<String>? ids, }) async {
    // ignore: prefer_const_declarations
    final path = r'/organizations';

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
    if (ids != null) {
      queryParams.addAll(_queryParams('csv', 'ids', ids));
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
  /// * [List<String>] ids:
  Future<List<Organization>?> getOrganizations({ int? offset, int? limit, bool? isManagedByMe, List<String>? ids, }) async {
    final response = await getOrganizationsWithHttpInfo( offset: offset, limit: limit, isManagedByMe: isManagedByMe, ids: ids, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<Organization>') as List)
        .cast<Organization>()
        .toList();

    }
    return null;
  }

  /// Performs an HTTP 'DELETE /organizations/{organizationId}/users/{userId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] organizationId (required):
  ///
  /// * [String] userId (required):
  Future<Response> removeUserFromOrganizationWithHttpInfo(String organizationId, String userId,) async {
    // ignore: prefer_const_declarations
    final path = r'/organizations/{organizationId}/users/{userId}'
      .replaceAll('{organizationId}', organizationId)
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
  /// * [String] organizationId (required):
  ///
  /// * [String] userId (required):
  Future<void> removeUserFromOrganization(String organizationId, String userId,) async {
    final response = await removeUserFromOrganizationWithHttpInfo(organizationId, userId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'PATCH /organizations/{organizationId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] organizationId (required):
  ///
  /// * [OrganizationUpdate] body:
  Future<Response> updateOrganizationWithHttpInfo(String organizationId, { OrganizationUpdate? body, }) async {
    // ignore: prefer_const_declarations
    final path = r'/organizations/{organizationId}'
      .replaceAll('{organizationId}', organizationId);

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
  /// * [String] organizationId (required):
  ///
  /// * [OrganizationUpdate] body:
  Future<Organization?> updateOrganization(String organizationId, { OrganizationUpdate? body, }) async {
    final response = await updateOrganizationWithHttpInfo(organizationId,  body: body, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Organization',) as Organization;
    
    }
    return null;
  }
}
