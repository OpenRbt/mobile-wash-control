import 'package:mobile_wash_control/wash-admin-client/api.dart';

class Common {
  static WashServersApi? washServersApi;

  static SetAuthToken(String idToken) {
    (Common.washServersApi!.apiClient.authentication as HttpBearerAuth).accessToken = idToken;
  }
}