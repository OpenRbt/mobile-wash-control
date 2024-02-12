//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ReportApi {
  ReportApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'GET /money-report-current' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] organizationId:
  ///
  /// * [String] groupId:
  ///
  /// * [String] washServerId:
  Future<Response> moneyReportCurrentWithHttpInfo({ String? organizationId, String? groupId, String? washServerId, }) async {
    // ignore: prefer_const_declarations
    final path = r'/money-report-current';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (organizationId != null) {
      queryParams.addAll(_queryParams('', 'organizationId', organizationId));
    }
    if (groupId != null) {
      queryParams.addAll(_queryParams('', 'groupId', groupId));
    }
    if (washServerId != null) {
      queryParams.addAll(_queryParams('', 'washServerId', washServerId));
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
  /// * [String] organizationId:
  ///
  /// * [String] groupId:
  ///
  /// * [String] washServerId:
  Future<List<MoneyReportStation>?> moneyReportCurrent({ String? organizationId, String? groupId, String? washServerId, }) async {
    final response = await moneyReportCurrentWithHttpInfo( organizationId: organizationId, groupId: groupId, washServerId: washServerId, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<MoneyReportStation>') as List)
        .cast<MoneyReportStation>()
        .toList();

    }
    return null;
  }

  /// Performs an HTTP 'GET /money-report-dates' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] organizationId:
  ///
  /// * [String] groupId:
  ///
  /// * [String] washServerId:
  ///
  /// * [int] startDate:
  ///   Unix time local
  ///
  /// * [int] endDate:
  ///   Unix time local
  Future<Response> moneyReportDatesWithHttpInfo({ String? organizationId, String? groupId, String? washServerId, int? startDate, int? endDate, }) async {
    // ignore: prefer_const_declarations
    final path = r'/money-report-dates';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (organizationId != null) {
      queryParams.addAll(_queryParams('', 'organizationId', organizationId));
    }
    if (groupId != null) {
      queryParams.addAll(_queryParams('', 'groupId', groupId));
    }
    if (washServerId != null) {
      queryParams.addAll(_queryParams('', 'washServerId', washServerId));
    }
    if (startDate != null) {
      queryParams.addAll(_queryParams('', 'startDate', startDate));
    }
    if (endDate != null) {
      queryParams.addAll(_queryParams('', 'endDate', endDate));
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
  /// * [String] organizationId:
  ///
  /// * [String] groupId:
  ///
  /// * [String] washServerId:
  ///
  /// * [int] startDate:
  ///   Unix time local
  ///
  /// * [int] endDate:
  ///   Unix time local
  Future<List<MoneyReportStation>?> moneyReportDates({ String? organizationId, String? groupId, String? washServerId, int? startDate, int? endDate, }) async {
    final response = await moneyReportDatesWithHttpInfo( organizationId: organizationId, groupId: groupId, washServerId: washServerId, startDate: startDate, endDate: endDate, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<MoneyReportStation>') as List)
        .cast<MoneyReportStation>()
        .toList();

    }
    return null;
  }

  /// Performs an HTTP 'GET /money-report-last-collection' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] organizationId:
  ///
  /// * [String] groupId:
  ///
  /// * [String] washServerId:
  Future<Response> moneyReportLastCollectionWithHttpInfo({ String? organizationId, String? groupId, String? washServerId, }) async {
    // ignore: prefer_const_declarations
    final path = r'/money-report-last-collection';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (organizationId != null) {
      queryParams.addAll(_queryParams('', 'organizationId', organizationId));
    }
    if (groupId != null) {
      queryParams.addAll(_queryParams('', 'groupId', groupId));
    }
    if (washServerId != null) {
      queryParams.addAll(_queryParams('', 'washServerId', washServerId));
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
  /// * [String] organizationId:
  ///
  /// * [String] groupId:
  ///
  /// * [String] washServerId:
  Future<List<MoneyReportStation>?> moneyReportLastCollection({ String? organizationId, String? groupId, String? washServerId, }) async {
    final response = await moneyReportLastCollectionWithHttpInfo( organizationId: organizationId, groupId: groupId, washServerId: washServerId, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<MoneyReportStation>') as List)
        .cast<MoneyReportStation>()
        .toList();

    }
    return null;
  }
}
