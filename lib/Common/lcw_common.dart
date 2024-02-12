import 'package:mobile_wash_control/openapi/lea-central-wash/api.dart';

class LcwCommon {
  static DefaultApi? defaultApi;

  static void initializeApis (String url, String pin) {
    LcwCommon.defaultApi = DefaultApi(ApiClient(
        basePath: url
    ));

    defaultApi?.apiClient.addDefaultHeader("Pin", pin);

  }
}