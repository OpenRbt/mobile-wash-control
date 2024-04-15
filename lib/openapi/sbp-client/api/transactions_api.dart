//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class TransactionsApi {
  TransactionsApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'GET /transactions' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] page:
  ///
  /// * [int] pageSize:
  ///
  /// * [String] status:
  ///
  /// * [String] organizationId:
  ///
  /// * [String] groupId:
  ///
  /// * [String] washId:
  ///
  /// * [int] postId:
  ///
  /// * [DateTime] dateFrom:
  ///
  /// * [DateTime] dateBefore:
  Future<Response> getTransactionsWithHttpInfo({ int? page, int? pageSize, String? status, String? organizationId, String? groupId, String? washId, int? postId, DateTime? dateFrom, DateTime? dateBefore, }) async {
    // ignore: prefer_const_declarations
    final path = r'/transactions';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (page != null) {
      queryParams.addAll(_queryParams('', 'page', page));
    }
    if (pageSize != null) {
      queryParams.addAll(_queryParams('', 'pageSize', pageSize));
    }
    if (status != null) {
      queryParams.addAll(_queryParams('', 'status', status));
    }
    if (organizationId != null) {
      queryParams.addAll(_queryParams('', 'organizationId', organizationId));
    }
    if (groupId != null) {
      queryParams.addAll(_queryParams('', 'groupId', groupId));
    }
    if (washId != null) {
      queryParams.addAll(_queryParams('', 'washId', washId));
    }
    if (postId != null) {
      queryParams.addAll(_queryParams('', 'postId', postId));
    }
    if (dateFrom != null) {
      queryParams.addAll(_queryParams('', 'dateFrom', dateFrom));
    }
    if (dateBefore != null) {
      queryParams.addAll(_queryParams('', 'dateBefore', dateBefore));
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
  /// * [int] page:
  ///
  /// * [int] pageSize:
  ///
  /// * [String] status:
  ///
  /// * [String] organizationId:
  ///
  /// * [String] groupId:
  ///
  /// * [String] washId:
  ///
  /// * [int] postId:
  ///
  /// * [DateTime] dateFrom:
  ///
  /// * [DateTime] dateBefore:
  Future<TransactionPage?> getTransactions({ int? page, int? pageSize, String? status, String? organizationId, String? groupId, String? washId, int? postId, DateTime? dateFrom, DateTime? dateBefore, }) async {
    final response = await getTransactionsWithHttpInfo( page: page, pageSize: pageSize, status: status, organizationId: organizationId, groupId: groupId, washId: washId, postId: postId, dateFrom: dateFrom, dateBefore: dateBefore, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'TransactionPage',) as TransactionPage;
    
    }
    return null;
  }
}
