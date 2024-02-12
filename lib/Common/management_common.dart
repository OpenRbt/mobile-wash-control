import 'package:mobile_wash_control/openapi/management-client/api.dart';

class ManagementCommon {
  static ConfigApi? configApi;
  static ReportApi? reportApi;

  static void setAuthToken(String idToken) {
    (ManagementCommon.configApi!.apiClient.authentication as HttpBearerAuth).accessToken = idToken;
    (ManagementCommon.reportApi!.apiClient.authentication as HttpBearerAuth).accessToken = idToken;
  }

  static void initializeApis (String url) {
    ManagementCommon.configApi = ConfigApi(ApiClient(
        authentication: HttpBearerAuth(),
        basePath: url
    ));
    ManagementCommon.reportApi = ReportApi(ApiClient(
        authentication: HttpBearerAuth(),
        basePath: url
    ));
  }

}