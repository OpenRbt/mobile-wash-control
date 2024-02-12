//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ApplicationsApi {
  ApplicationsApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'POST /users/applications' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [CreateAdminApplicationRequest] body (required):
  Future<Response> createAdminApplicationWithHttpInfo(CreateAdminApplicationRequest body,) async {
    // ignore: prefer_const_declarations
    final path = r'/users/applications';

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
  /// * [CreateAdminApplicationRequest] body (required):
  Future<AdminApplication?> createAdminApplication(CreateAdminApplicationRequest body,) async {
    final response = await createAdminApplicationWithHttpInfo(body,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AdminApplication',) as AdminApplication;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /users/applications/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getAdminApplicationByIdWithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/users/applications/{id}'
      .replaceAll('{id}', id);

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
  /// * [String] id (required):
  Future<AdminApplication?> getAdminApplicationById(String id,) async {
    final response = await getAdminApplicationByIdWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AdminApplication',) as AdminApplication;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /users/applications' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] offset:
  ///   Number of records to skip for pagination
  ///
  /// * [int] limit:
  ///   Maximum number of records to return
  ///
  /// * [String] status:
  Future<Response> getAdminApplicationsWithHttpInfo({ int? offset, int? limit, String? status, }) async {
    // ignore: prefer_const_declarations
    final path = r'/users/applications';

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
    if (status != null) {
      queryParams.addAll(_queryParams('', 'status', status));
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
  /// * [String] status:
  Future<GetAdminApplications200Response?> getAdminApplications({ int? offset, int? limit, String? status, }) async {
    final response = await getAdminApplicationsWithHttpInfo( offset: offset, limit: limit, status: status, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetAdminApplications200Response',) as GetAdminApplications200Response;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /users/applications/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [AdminApplicationReview] body (required):
  Future<Response> reviewAdminApplicationWithHttpInfo(String id, AdminApplicationReview body,) async {
    // ignore: prefer_const_declarations
    final path = r'/users/applications/{id}'
      .replaceAll('{id}', id);

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
  /// * [String] id (required):
  ///
  /// * [AdminApplicationReview] body (required):
  Future<void> reviewAdminApplication(String id, AdminApplicationReview body,) async {
    final response = await reviewAdminApplicationWithHttpInfo(id, body,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
