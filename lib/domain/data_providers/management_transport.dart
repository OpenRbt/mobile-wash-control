import 'package:mobile_wash_control/openapi/management-client/api.dart';

import '../../Common/management_common.dart';
import '../entities/services_entities.dart' as srvcEntity;
import '../entities/user_entity.dart' as usrEntity;

class ManagementTransport {
  static Future<srvcEntity.WashServer?> getWashServer(String id) async {

    late srvcEntity.WashServer washServer;

    try {
      final res = await ManagementCommon.configApi!.getWashServerById(id);
      washServer = srvcEntity.WashServer.fromMap(res?.toJson() ?? {});
      washServer.name = res?.title ?? "";
    }
    on ApiException catch (e) {
      throw FormatException("${e.code}: ${e.message}");
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
    return washServer;
  }

  static Future<List<srvcEntity.WashServer>> getWashServers(String groupId) async {

    List<srvcEntity.WashServer> washServers = [];

    try {
      final res = await ManagementCommon.configApi!.getWashServers(offset: 0, limit: 100, groupId: groupId);

      res?.forEach((element) {
        srvcEntity.WashServer washServer = srvcEntity.WashServer.fromMap(element.toJson());
        washServer.name = element.title ?? "";
        washServers.add(washServer);
      });
    }
    on ApiException catch (e) {
      throw FormatException("${e.code}: ${e.message}");
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
    return washServers;
  }

}