import 'package:mobile_wash_control/entity/entity.dart' as entity;

import '../../openapi/wash-admin-client/api.dart';
import '../../utils/common.dart';


class WashAdminRepository {
  static Future<List<entity.Organization>?> getOrganizations() async {
    try {


      final res = await Common.organizationApi!.getOrganizations(body: Pagination(limit: 100, offset: 0));

      var organizations = <entity.Organization>[];
      for(int i = 0; i < res!.length; i++){
        organizations.add(entity.Organization(
          id: res[i].id,
          name: res[i].name,
          description: res[i].description,
          isDefault: res[i].isDefault,
        ));
      }

      /*
      var organizations = <entity.Organization>[];
      for(int i = 0; i < 12; i++){
        organizations.add(entity.Organization(
          id: "$i",
          name: "Organization$i",
          description: "Описание$i",
        ));
      }

       */

      return organizations;

    }
    on ApiException catch (e) {
      switch (e.code){
        default:
          print("Не удалось получить список организаций, Ошибка: ${e.code}");
          break;
      }
      return null;
    } catch (e) {
      print("Произошла неизвестная ошибка: $e");
    }
    return null;
  }

  static Future<entity.Organization?> getOrganization(String id) async {
    try {

      final res = await Common.organizationApi!.getOrganizationById(id);

      var organization = entity.Organization(
        id: res?.id,
        name: res?.name,
        description: res?.description,
      );

       /*
      var organization = entity.Organization(
        id: "1",
        name: "Organization2",
        description: "Описание3",
      );

        */

      return organization;

    }
    on ApiException catch (e) {
      switch (e.code){
        default:
          print("Не удалось получить параметры организации, Ошибка: ${e.code}");
          break;
      }
      return null;
    } catch (e) {
      print("Произошла неизвестная ошибка: $e");
    }
    return null;
  }

  static Future<void> createOrganization(entity.Organization newOrganization) async {
    try {
      final res = await Common.organizationApi!.createOrganization(
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
          print("Не удалось создать новую организацию, Ошибка: ${e.code}");
          break;
      }
      return;
    } catch (e) {
      print("Произошла неизвестная ошибка: $e");
    }
    return;
  }

  static Future<void> updateOrganization(entity.Organization updatedOrganization) async {
    try {
      final res = await Common.organizationApi!.updateOrganization(
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
          print("Не удалось обновить параметры организации, Ошибка: ${e.code}");
          break;
      }
      return;
    } catch (e) {
      print("Произошла неизвестная ошибка: $e");
    }
    return;
  }

  static Future<void> deleteOrganization(String id) async {
    try {

      final res = await Common.organizationApi!.deleteOrganization(id);

      return;

    }
    on ApiException catch (e) {
      switch (e.code){
        default:
          print("Не удалось удалить организацию, Ошибка: ${e.code}");
          break;
      }
      return;
    } catch (e) {
      print("Произошла неизвестная ошибка: $e");
    }
    return;
  }

  static Future<List<entity.ServerGroup>?> getServerGroups(String organizationId) async {
    try{

      final res = await Common.serversGroupApi!.getServerGroups(organizationId: organizationId, body: Pagination(limit: 100));

      var serverGroups = <entity.ServerGroup>[];
      for(int i = 0; i < res!.length; i++) {
        serverGroups.add(entity.ServerGroup(
            id: res[i].id,
            name: res[i].name,
            description: res[i].description,
            organizationId: res[i].organizationId
        ));
      }
      /*
      var serverGroups = <entity.ServerGroup>[];
      for(int i = 0; i < 5; i++){
        serverGroups.add(entity.ServerGroup(
          id: "$i",
          name: "Группа$i",
          description: "Описание$i",
          organizationId: "organizationId$i",
        ));
      }
       */
      return serverGroups;

    } on ApiException catch (e) {
      switch (e.code){
        default:
          print("Не удалось получить список групп, Ошибка: ${e.code}");
          break;
      }
      return null;
    } catch (e) {
      print("Произошла неизвестная ошибка: $e");
    }
    return null;
  }

  static Future<entity.ServerGroup?> getServerGroup(String id) async {
    try{
      final res = await Common.serversGroupApi!.getServerGroupById(id);

      var serverGroup = entity.ServerGroup(
          id: res?.id,
          name: res?.name,
          description: res?.description,
          organizationId: res?.organizationId
      );

/*
      var serverGroup = entity.ServerGroup(
        id: "1",
        name: "Группа2",
        description: "Описание3",
        organizationId: "organizationId4",
      );

 */

      return serverGroup;

    } on ApiException catch (e) {
      switch (e.code){
        default:
          print("Не удалось получить параметры группы, Ошибка: ${e.code}");
          break;
      }
      return null;
    } catch (e) {
      print("Произошла неизвестная ошибка: $e");
    }
    return null;
  }

  static Future<void> createServerGroup(String organizationId, entity.ServerGroup newServerGroup) async {
    try {
      final res = await Common.serversGroupApi!.createServerGroup(
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
          print("Не удалось создать группу серверов, Ошибка: ${e.code}");
          break;
      }
      return;
    } catch (e) {
      print("Произошла неизвестная ошибка: $e");
    }
    return;
  }

  static Future<void> updateServerGroup(entity.ServerGroup updatedServerGroup) async {
    try {
      final res = await Common.serversGroupApi!.updateServerGroup(
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
          print("Не удалось обновить параметры группы серверов, Ошибка: ${e.code}");
          break;
      }
      return;
    } catch (e) {
      print("Произошла неизвестная ошибка: $e");
    }
    return;
  }

  static Future<void> deleteServerGroup(String id) async {
    try {

      final res = await Common.serversGroupApi!.deleteServerGroup(id);

      return;

    }
    on ApiException catch (e) {
      switch (e.code){
        default:
          print("Не удалось удалить группу серверов, Ошибка: ${e.code}");
          break;
      }
      return;
    } catch (e) {
      print("Произошла неизвестная ошибка: $e");
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
          description: "Описание$i",
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
          print("Не удалось получить список серверов, Ошибка: ${e.code}");
          break;
      }
      return null;
    } catch (e) {
      print("Произошла неизвестная ошибка: $e");
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
        description: "Описание3",
        organizationId: "organizationId4",
        createdBy: "Создан5",
      );

      return washServer;

    } on ApiException catch (e) {
      switch (e.code){
        default:
          print("Не удалось получить сервера, Ошибка: ${e.code}");
          break;
      }
      return null;
    } catch (e) {
      print("Произошла неизвестная ошибка: $e");
    }
    return null;
  }

  static Future<void> createWashServer(String groupId, entity.WashServer newWashServer) async {
    try {
      final res = await Common.washServerApi!.createWashServer(
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
          print("Не удалось создать Сервер, Ошибка: ${e.code}");
          break;
      }
      return;
    } catch (e) {
      print("Произошла неизвестная ошибка: $e");
    }
    return;
  }

  //static Future

  static Future<void> updateWashServer(entity.WashServer updatedWashServer) async {
    try {
      final res = await Common.washServerApi!.updateWashServer(
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
          print("Не удалось обновить параметры сервера, Ошибка: ${e.code}");
          break;
      }
      return;
    } catch (e) {
      print("Произошла неизвестная ошибка: $e");
    }
    return;
  }

  static Future<void> deleteWashServer(String id) async {
    try {

      final res = await Common.washServerApi!.deleteWashServer(id);

      return;

    }
    on ApiException catch (e) {
      switch (e.code){
        default:
          print("Не удалось удалить сервер, Ошибка: ${e.code}");
          break;
      }
      return;
    } catch (e) {
      print("Произошла неизвестная ошибка: $e");
    }
    return;
  }
}