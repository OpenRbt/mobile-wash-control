import 'package:mobile_wash_control/domain/entities/services_entities.dart';
import 'package:mobile_wash_control/openapi/lea-central-wash/api.dart';

import '../../Common/lcw_common.dart';

class LcwTransport {
  static Future<void> setConfigVarString(String key, String value) async {

    try {
      final response = await LcwCommon.defaultApi?.setConfigVarString(
          ConfigVarString(
              name: key,
              value: value
          )
      );
    }
    on ApiException catch (e) {
      throw FormatException("${e.code}: ${e.message}");
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> getConfigVarString(String key) async {

    String configVarStringValue = '';

    try {
      final response = await LcwCommon.defaultApi?.getConfigVarString(
          ArgGetConfigVar(
              name: key,
          )
      );
      configVarStringValue = response?.value ?? '';
    }
    on ApiException catch (e) {
      if(e.code == 404) {
        return '';
      }
      throw FormatException("${e.code}: ${e.message}");
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
    return configVarStringValue;
  }

}