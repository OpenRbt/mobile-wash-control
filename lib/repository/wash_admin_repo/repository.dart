import 'package:mobile_wash_control/entity/entity.dart' as entity;
import 'package:easy_localization/easy_localization.dart';

import '../../openapi/wash-admin-client/api.dart';
import '../../Common/bonus_common.dart';


class WashAdminRepository {
  static Future<List<entity.Organization>?> getOrganizations() async {
    try {


      final res = await BonusCommon.organizationApi!.getOrganizations(limit: 100, offset: 0);

      var organizations = <entity.Organization>[];
      for(int i = 0; i < res!.length; i++){
        organizations.add(entity.Organization(
          id: res[i].id,
          name: res[i].name,
          description: res[i].description,
          isDefault: res[i].isDefault,
        ));
      }

      return organizations;

    }
    on ApiException catch (e) {
      switch (e.code){
        default:
          print("${'failed'.tr()} ${'to_get'.tr()} ${'organizations_list'.tr()}, ${'error'.tr()}: ${e.code}");
          break;
      }
      return null;
    } catch (e) {
      print("${'an_unknown_error_has_occurred'.tr()}: $e");
    }
    return null;
  }

  static Future<entity.Organization?> getOrganization(String id) async {
    try {

      final res = await BonusCommon.organizationApi!.getOrganizationById(id);

      var organization = entity.Organization(
        id: res?.id,
        name: res?.name,
        description: res?.description,
      );

      return organization;

    }
    on ApiException catch (e) {
      switch (e.code){
        default:
          print("${'failed'.tr()} ${'to_get'.tr()} ${'organization_parameters'.tr()}, ${'error'.tr()}: ${e.code}");
          break;
      }
      return null;
    } catch (e) {
      print("${'an_unknown_error_has_occurred'.tr()}: $e");
    }
    return null;
  }

  static Future<void> createOrganization(entity.Organization newOrganization) async {
    try {
      final res = await BonusCommon.organizationApi!.createOrganization(
          body: OrganizationCreation(
            name: newOrganization.name ?? "",
            description: newOrganization.description ?? "",
          )
      );

      print("Организация успешно создана");

      return;

    }
    on ApiException catch (e) {
      switch (e.code){
        default:
          print("${'failed'.tr()} ${'to_create_new_organization'.tr()}, ${'error'.tr()}: ${e.code}");
          break;
      }
      return;
    } catch (e) {
      print("${'an_unknown_error_has_occurred'.tr()}: $e");
    }
    return;
  }

  static Future<void> updateOrganization(entity.Organization updatedOrganization) async {
    try {
      final res = await BonusCommon.organizationApi!.updateOrganization(
          updatedOrganization.id ?? "",
          body: OrganizationUpdate(
            name: updatedOrganization.name,
            description: updatedOrganization.description,
          )
      );

      print("Параметры рганизации успешно обновлены");
      return;

    }
    on ApiException catch (e) {
      switch (e.code){
        default:
          print("${'failed'.tr()} обновить параметры организации, ${'error'.tr()}: ${e.code}");
          break;
      }
      return;
    } catch (e) {
      print("${'an_unknown_error_has_occurred'.tr()}: $e");
    }
    return;
  }

  static Future<void> deleteOrganization(String id) async {
    try {

      final res = await BonusCommon.organizationApi!.deleteOrganization(id);

      return;

    }
    on ApiException catch (e) {
      switch (e.code){
        default:
          print("${'failed'.tr()} удалить организацию, ${'error'.tr()}: ${e.code}");
          break;
      }
      return;
    } catch (e) {
      print("${'an_unknown_error_has_occurred'.tr()}: $e");
    }
    return;
  }

  static Future<List<entity.ServerGroup>?> getServerGroups(String organizationId) async {
    try{

      final res = await BonusCommon.serversGroupApi!.getServerGroups(limit: 100, offset: 0);

      var serverGroups = <entity.ServerGroup>[];
      for(int i = 0; i < res!.length; i++) {
        serverGroups.add(entity.ServerGroup(
            id: res[i].id,
            name: res[i].name,
            description: res[i].description,
            organizationId: res[i].organizationId
        ));
      }
      return serverGroups;

    } on ApiException catch (e) {
      switch (e.code){
        default:
          print("${'failed'.tr()} ${'to_get'.tr()} список групп, ${'error'.tr()}: ${e.code}");
          print(e.message);
          break;
      }
      return null;
    } catch (e) {
      print("${'an_unknown_error_has_occurred'.tr()}: $e");
    }
    return null;
  }

  static Future<entity.ServerGroup?> getServerGroup(String id) async {
    try{
      final res = await BonusCommon.serversGroupApi!.getServerGroupById(id);

      var serverGroup = entity.ServerGroup(
          id: res?.id,
          name: res?.name,
          description: res?.description,
          organizationId: res?.organizationId
      );

      return serverGroup;

    } on ApiException catch (e) {
      switch (e.code){
        default:
          print("${'failed'.tr()} ${'to_get'.tr()} параметры группы, ${'error'.tr()}: ${e.code}");
          break;
      }
      return null;
    } catch (e) {
      print("${'an_unknown_error_has_occurred'.tr()}: $e");
    }
    return null;
  }

  static Future<void> createServerGroup(String organizationId, entity.ServerGroup newServerGroup) async {
    try {
      final res = await BonusCommon.serversGroupApi!.createServerGroup(
          body: ServerGroupCreation(
            name: newServerGroup.name ?? "",
            description: newServerGroup.description ?? "",
            organizationId: organizationId,
          )
      );

      print("Группа серверов успешно создана");
      return;

    }
    on ApiException catch (e) {
      switch (e.code){
        default:
          print("${'failed'.tr()} создать группу серверов, ${'error'.tr()}: ${e.code}");
          break;
      }
      return;
    } catch (e) {
      print("${'an_unknown_error_has_occurred'.tr()}: $e");
    }
    return;
  }

  static Future<void> updateServerGroup(entity.ServerGroup updatedServerGroup) async {
    try {
      final res = await BonusCommon.serversGroupApi!.updateServerGroup(
          updatedServerGroup.id ?? "",
          body: ServerGroupUpdate(
            name: updatedServerGroup.name,
            description: updatedServerGroup.description,
          )
      );

      print("Параметры группы серверов успешно обновлены");
      return;

    }
    on ApiException catch (e) {
      switch (e.code){
        default:
          print("${'failed'.tr()} обновить параметры группы серверов, ${'error'.tr()}: ${e.code}");
          break;
      }
      return;
    } catch (e) {
      print("${'an_unknown_error_has_occurred'.tr()}: $e");
    }
    return;
  }

  static Future<void> deleteServerGroup(String id) async {
    try {

      final res = await BonusCommon.serversGroupApi!.deleteServerGroup(id);

      return;

    }
    on ApiException catch (e) {
      switch (e.code){
        default:
          print("${'failed'.tr()} удалить группу серверов, ${'error'.tr()}: ${e.code}");
          break;
      }
      return;
    } catch (e) {
      print("${'an_unknown_error_has_occurred'.tr()}: $e");
    }
    return;
  }

  static Future<List<entity.WashServer>?> getWashServers(String groupId) async {
    try{
      /*
      final res = await Common.washServerApi!.getWashServers(groupId: groupId, body: Pagination(limit: 100));

      var washServers = <entity.WashServer>[];
      for(int i = 0; i < 7; i++){
        washServers.add(entity.WashServer(
          id: res![i].id,
          name: res[i].name,
          description: res[i].description,
          serviceKey: res[i].serviceKey,
          createdBy: res[i].createdBy,
          groupId: res[i].groupId,
          organizationId: res[i].organizationId,
        ));
      }

       */
      var washServers = <entity.WashServer>[];
      for(int i = 0; i < 7; i++){
        washServers.add(entity.WashServer(
          id: "$i",
          name: "Сервер$i",
          description: "${'description'.tr()}$i",
          serviceKey: "ServiceKey $i",
          createdBy: "Кем создано $i",
          groupId: "Номер группы$i",
          organizationId: "organizationId$i",
        ));
      }

      return washServers;

    } on ApiException catch (e) {
      switch (e.code){
        default:
          print("${'failed'.tr()} ${'to_get'.tr()} список серверов, ${'error'.tr()}: ${e.code}");
          break;
      }
      return null;
    } catch (e) {
      print("${'an_unknown_error_has_occurred'.tr()}: $e");
    }
    return null;
  }

  static Future<entity.WashServer?> getWashServer(String id) async {
    try{
      /*
      final res = await Common.washServerApi!.getWashServerById(id);

      var washServer = entity.WashServer(
          id: res?.id,
          name: res?.name,
          description: res?.description,
          serviceKey: res?.serviceKey,
          createdBy: res?.createdBy,
          groupId: res?.groupId,
          organizationId: res?.organizationId
      );

       */
      var washServer = entity.WashServer(
        id: "1",
        name: "Группа2",
        description: "${'description'.tr()}3",
        organizationId: "organizationId4",
        createdBy: "Создан5",
      );

      return washServer;

    } on ApiException catch (e) {
      switch (e.code){
        default:
          print("${'failed'.tr()} ${'to_get'.tr()} сервера, ${'error'.tr()}: ${e.code}");
          break;
      }
      return null;
    } catch (e) {
      print("${'an_unknown_error_has_occurred'.tr()}: $e");
    }
    return null;
  }

  static Future<void> createWashServer(String groupId, entity.WashServer newWashServer) async {
    try {
      final res = await BonusCommon.washServerApi!.createWashServer(
          body: WashServerCreation(
            name: newWashServer.name ?? "",
            description: newWashServer.description ?? "",
            groupId: groupId,
          )
      );

      print("Cервер успешно создана");
      return;

    }
    on ApiException catch (e) {
      switch (e.code){
        default:
          print("${'failed'.tr()} создать Сервер, ${'error'.tr()}: ${e.code}");
          break;
      }
      return;
    } catch (e) {
      print("${'an_unknown_error_has_occurred'.tr()}: $e");
    }
    return;
  }

  //static Future

  static Future<void> updateWashServer(entity.WashServer updatedWashServer) async {
    try {
      final res = await BonusCommon.washServerApi!.updateWashServer(
          updatedWashServer.id ?? "",
          body: WashServerUpdate(
            name: updatedWashServer.name,
            description: updatedWashServer.description,
          )
      );

      print("Параметры сервера успешно обновлены");
      return;

    }
    on ApiException catch (e) {
      switch (e.code){
        default:
          print("${'failed'.tr()} обновить параметры сервера, ${'error'.tr()}: ${e.code}");
          break;
      }
      return;
    } catch (e) {
      print("${'an_unknown_error_has_occurred'.tr()}: $e");
    }
    return;
  }

  static Future<void> deleteWashServer(String id) async {
    try {

      final res = await BonusCommon.washServerApi!.deleteWashServer(id);

      return;

    }
    on ApiException catch (e) {
      switch (e.code){
        default:
          print("${'failed'.tr()} удалить сервер, ${'error'.tr()}: ${e.code}");
          break;
      }
      return;
    } catch (e) {
      print("${'an_unknown_error_has_occurred'.tr()}: $e");
    }
    return;
  }

  static Future<AdminApplication?> sendApplication(entity.FirebaseUser firebaseUser) async { //запрос на отправку заявки юзером
    try {
      final res = await BonusCommon.applicationApi!.createAdminApplication(
          CreateAdminApplicationRequest(
              application: AdminApplicationCreation(
                  user: FirebaseUser(
                    id: firebaseUser.id ?? "",
                    name: firebaseUser.name ?? "",
                    email: firebaseUser.email ?? "",
                  )
              )
          )
      );

      return res;
    }
    on ApiException catch (e) {
      switch (e.code){
        default:
          print("${'failed'.tr()} отправить заявку, ${'error'.tr()}: ${e.code}");
          break;
      }
      return null;
    } catch (e) {
      print("${'an_unknown_error_has_occurred'.tr()}: $e");
    }
    return null;
  }


}