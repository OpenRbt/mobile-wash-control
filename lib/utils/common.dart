import 'package:mobile_wash_control/openapi/wash-admin-client/api.dart';

class Common {
  static OrganizationsApi? organizationApi;
  static ServerGroupsApi? serversGroupApi;
  static SessionsApi? sessionApi;
  static StandardApi? standardApi;
  static UsersApi? userApi;
  static WalletsApi? walletApi;
  static WashServersApi? washServerApi;

  static void setAuthToken(String idToken) {
    (Common.organizationApi!.apiClient.authentication as HttpBearerAuth).accessToken = idToken;
    (Common.serversGroupApi!.apiClient.authentication as HttpBearerAuth).accessToken = idToken;
    (Common.sessionApi!.apiClient.authentication as HttpBearerAuth).accessToken = idToken;
    (Common.standardApi!.apiClient.authentication as HttpBearerAuth).accessToken = idToken;
    (Common.userApi!.apiClient.authentication as HttpBearerAuth).accessToken = idToken;
    (Common.walletApi!.apiClient.authentication as HttpBearerAuth).accessToken = idToken;
    (Common.washServerApi!.apiClient.authentication as HttpBearerAuth).accessToken = idToken;
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
    Common.sessionApi = SessionsApi(ApiClient(
        authentication: HttpBearerAuth(),
        basePath: url
    ));
    Common.standardApi = StandardApi(ApiClient(
        authentication: HttpBearerAuth(),
        basePath: url
    ));
    Common.userApi = UsersApi(ApiClient(
        authentication: HttpBearerAuth(),
        basePath: url
    ));
    Common.walletApi = WalletsApi(ApiClient(
        authentication: HttpBearerAuth(),
        basePath: url
    ));
    Common.washServerApi = WashServersApi(ApiClient(
        authentication: HttpBearerAuth(),
        basePath: url
    ));
  }

}