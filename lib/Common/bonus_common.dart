import 'package:mobile_wash_control/openapi/wash-admin-client/api.dart';

class BonusCommon {
  static OrganizationsApi? organizationApi;
  static ServerGroupsApi? serversGroupApi;
  static UsersApi? userApi;
  static WashServersApi? washServerApi;
  static ApplicationsApi? applicationApi;

  static void setAuthToken(String idToken) {
    (BonusCommon.organizationApi!.apiClient.authentication as HttpBearerAuth).accessToken = idToken;
    (BonusCommon.serversGroupApi!.apiClient.authentication as HttpBearerAuth).accessToken = idToken;
    (BonusCommon.userApi!.apiClient.authentication as HttpBearerAuth).accessToken = idToken;
    (BonusCommon.washServerApi!.apiClient.authentication as HttpBearerAuth).accessToken = idToken;
    (BonusCommon.applicationApi!.apiClient.authentication as HttpBearerAuth).accessToken = idToken;
  }

  static void initializeApis (String url) {
    BonusCommon.organizationApi = OrganizationsApi(ApiClient(
        authentication: HttpBearerAuth(),
        basePath: url
    ));
    BonusCommon.serversGroupApi = ServerGroupsApi(ApiClient(
        authentication: HttpBearerAuth(),
        basePath: url
    ));
    BonusCommon.userApi = UsersApi(ApiClient(
        authentication: HttpBearerAuth(),
        basePath: url
    ));
    BonusCommon.washServerApi = WashServersApi(ApiClient(
        authentication: HttpBearerAuth(),
        basePath: url
    ));
    BonusCommon.applicationApi = ApplicationsApi(ApiClient(
        authentication: HttpBearerAuth(),
        basePath: url
    ));
  }
}