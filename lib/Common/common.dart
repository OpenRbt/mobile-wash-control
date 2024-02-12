import 'package:mobile_wash_control/openapi/wash-admin-client/api.dart';

class Common {
  static OrganizationsApi? organizationApi;
  static ServerGroupsApi? serversGroupApi;
  static UsersApi? userApi;
  static WashServersApi? washServerApi;
  static ApplicationsApi? applicationApi;

  static void setAuthToken(String idToken) {
    (Common.organizationApi!.apiClient.authentication as HttpBearerAuth).accessToken = idToken;
    (Common.serversGroupApi!.apiClient.authentication as HttpBearerAuth).accessToken = idToken;
    (Common.userApi!.apiClient.authentication as HttpBearerAuth).accessToken = idToken;
    (Common.washServerApi!.apiClient.authentication as HttpBearerAuth).accessToken = idToken;
    (Common.applicationApi!.apiClient.authentication as HttpBearerAuth).accessToken = idToken;
  }

  static void initializeApis (String url) {
    Common.organizationApi = OrganizationsApi(ApiClient(
        authentication: HttpBearerAuth(),
        basePath: url
    ));
    Common.serversGroupApi = ServerGroupsApi(ApiClient(
        authentication: HttpBearerAuth(),
        basePath: url
    ));
    Common.userApi = UsersApi(ApiClient(
        authentication: HttpBearerAuth(),
        basePath: url
    ));
    Common.washServerApi = WashServersApi(ApiClient(
        authentication: HttpBearerAuth(),
        basePath: url
    ));
    Common.applicationApi = ApplicationsApi(ApiClient(
        authentication: HttpBearerAuth(),
        basePath: url
    ));
  }
}