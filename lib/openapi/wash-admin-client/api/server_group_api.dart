//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ServerGroupApi {
  ServerGroupApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

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
}
