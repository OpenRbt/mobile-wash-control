import 'package:mobile_wash_control/openapi/sbp-client/api.dart';

import '../../Common/bonus_common.dart';
import '../../Common/sbp_common.dart';
import '../entities/services_entities.dart' as srvcEntity;
import '../entities/user_entity.dart' as usrEntity;

class SbpTransport {

  static Future<usrEntity.ServiceUser?> getServiceUser(String firebaseId) async {

    usrEntity.ServiceUser serviceUser;

    try {
      final res = await BonusCommon.userApi!.getAdminUserById(firebaseId);
      serviceUser = usrEntity.ServiceUser.fromMap(res?.toJson() ?? {});
      serviceUser.organizationId = res?.organization?.id ?? "";
    }
    on ApiException catch (e) {
      if(e.code == 404) {
        return null;
      }
      throw FormatException("${e.code}: ${e.message}");
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
    return serviceUser;
  }

  static Future<srvcEntity.WashServer> getSbpWashServer(String id) async {

    late srvcEntity.WashServer sbpWashServer;

    try {
      final res = await SbpCommon.washApi!.getWashById(id);
      sbpWashServer = srvcEntity.WashServer.fromSbpWash(res?.toJson() ?? {});
    }
    on ApiException catch (e) {
      throw FormatException("${e.code}: ${e.message}");
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
    return sbpWashServer;
  }

  static Future<srvcEntity.WashServer> registerSbpWashServer(srvcEntity.WashServer washServer, String terminalKey, String terminalPassword) async {

    late srvcEntity.WashServer sbpWashServer;

    try {
      final res = await SbpCommon.washApi!.createWash(
        body: WashCreation(
            name: washServer.name,
            description: washServer.description,
            terminalKey: terminalKey,
            terminalPassword: terminalPassword,
            groupId: washServer.groupId
        )
      );
      sbpWashServer = srvcEntity.WashServer.fromSbpWash(res?.toJson() ?? {});
    }
    on ApiException catch (e) {
      throw FormatException("${e.code}: ${e.message}");
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
    return sbpWashServer;
  }

  static Future<void> updateSbpWashServer(srvcEntity.WashServer washServer) async {
    try {
      await SbpCommon.washApi!.updateWash(
          washServer.id,
        body: WashUpdate(
          name: washServer.name,
          description: washServer.description
        )
      );
      SbpCommon.washApi!.assignWashToGroup(washServer.groupId, washServer.id);
    }
    on ApiException catch (e) {
      throw FormatException("${e.code}: ${e.message}");
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

}