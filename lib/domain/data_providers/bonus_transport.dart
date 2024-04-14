import 'package:mobile_wash_control/openapi/wash-admin-client/api.dart';

import '../../Common/bonus_common.dart';
import '../entities/services_entities.dart' as srvcEntity;
import '../entities/user_entity.dart' as usrEntity;

class BonusTransport {

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

  static Future<srvcEntity.WashServer> getBonusWashServer(String id) async {

    late srvcEntity.WashServer bonusWashServer;

    try {
      final res = await BonusCommon.washServerApi!.getWashServerById(id);
      bonusWashServer = srvcEntity.WashServer.fromMap(res?.toJson() ?? {});
    }
    on ApiException catch (e) {
      throw FormatException("${e.code}: ${e.message}");
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
    return bonusWashServer;
  }

  static Future<srvcEntity.WashServer> registerBonusWashServer(srvcEntity.WashServer bonusWashServer) async {

    late srvcEntity.WashServer registeredBonusWashServer;

    try {
      final res = await BonusCommon.washServerApi!.createWashServer(
          body: WashServerCreation(
              name: bonusWashServer.name,
              description: bonusWashServer.description,
              groupId: bonusWashServer.groupId
          )
      );
      registeredBonusWashServer = srvcEntity.WashServer.fromMap(res?.toJson() ?? {});
    }
    on ApiException catch (e) {
      throw FormatException("${e.code}: ${e.message}");
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
    return registeredBonusWashServer;
  }

  static Future<void> updateBonusWashServer(srvcEntity.WashServer bonusWashServer) async {

    try {
      await BonusCommon.washServerApi!.updateWashServer(
          bonusWashServer.id,
          body: WashServerUpdate(name: bonusWashServer.name, description: bonusWashServer.description)
      );
      await BonusCommon.washServerApi!.assignServerToGroup(bonusWashServer.groupId, bonusWashServer.id);
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