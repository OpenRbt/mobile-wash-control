import 'package:mobile_wash_control/openapi/sbp-client/api.dart';

class SbpCommon {
  static StandardApi? standardApi;
  static WashApi? washApi;

  static void setAuthToken(String idToken) {
    (SbpCommon.standardApi!.apiClient.authentication as HttpBearerAuth).accessToken = idToken;
    (SbpCommon.washApi!.apiClient.authentication as HttpBearerAuth).accessToken = idToken;
  }

  static void initializeApis (String url) {
    SbpCommon.standardApi = StandardApi(ApiClient(
        authentication: HttpBearerAuth(),
        basePath: url
    ));
    SbpCommon.washApi = WashApi(ApiClient(
        authentication: HttpBearerAuth(),
        basePath: url
    ));
  }

}