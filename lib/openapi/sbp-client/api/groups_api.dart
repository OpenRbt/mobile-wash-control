//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class GroupsApi {
  GroupsApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'POST /groups/{groupId}/washes/{washId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] groupId (required):
  ///
  /// * [String] washId (required):
  Future<Response> assignWashToGroupWithHttpInfo(String groupId, String washId,) async {
    // ignore: prefer_const_declarations
    final path = r'/groups/{groupId}/washes/{washId}'
      .replaceAll('{groupId}', groupId)
      .replaceAll('{washId}', washId);

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
  /// * [String] washId (required):
  Future<void> assignWashToGroup(String groupId, String washId,) async {
    final response = await assignWashToGroupWithHttpInfo(groupId, washId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
