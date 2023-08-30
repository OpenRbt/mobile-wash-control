//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class SessionsApi {
  SessionsApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'POST /sessions/{sessionId}/assign-user' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] sessionId (required):
  Future<Response> assignUserToSessionWithHttpInfo(String sessionId,) async {
    // ignore: prefer_const_declarations
    final path = r'/sessions/{sessionId}/assign-user'
      .replaceAll('{sessionId}', sessionId);

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
  /// * [String] sessionId (required):
  Future<void> assignUserToSession(String sessionId,) async {
    final response = await assignUserToSessionWithHttpInfo(sessionId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /sessions/{sessionId}/bonuses' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] sessionId (required):
  ///
  /// * [BonusCharge] body:
  Future<Response> chargeBonusesOnSessionWithHttpInfo(String sessionId, { BonusCharge? body, }) async {
    // ignore: prefer_const_declarations
    final path = r'/sessions/{sessionId}/bonuses'
      .replaceAll('{sessionId}', sessionId);

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
  /// * [String] sessionId (required):
  ///
  /// * [BonusCharge] body:
  Future<BonusCharge?> chargeBonusesOnSession(String sessionId, { BonusCharge? body, }) async {
    final response = await chargeBonusesOnSessionWithHttpInfo(sessionId,  body: body, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'BonusCharge',) as BonusCharge;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /sessions/{sessionId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] sessionId (required):
  Future<Response> getSessionByIdWithHttpInfo(String sessionId,) async {
    // ignore: prefer_const_declarations
    final path = r'/sessions/{sessionId}'
      .replaceAll('{sessionId}', sessionId);

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
  /// * [String] sessionId (required):
  Future<Session?> getSessionById(String sessionId,) async {
    final response = await getSessionByIdWithHttpInfo(sessionId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Session',) as Session;
    
    }
    return null;
  }
}
