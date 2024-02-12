import '../../openapi/wash-admin-client/api.dart';
import '../../Common/common.dart';
import '../entities/services_entities.dart' as srvcEntity;

class WashAdminTransport {

  static Future<List<srvcEntity.Organization>> getOrganizations() async {

    List<srvcEntity.Organization> organizations = [];

    try {
      final res = await Common.organizationApi!.getOrganizations(limit: 100, offset: 0);
      res?.forEach((element) {
        organizations.add(srvcEntity.Organization.fromMap(element.toJson()));
      });

    }
    on ApiException catch (e) {
      throw FormatException("${e.code}: ${e.message}");
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }

    return organizations;
  }

  static Future<srvcEntity.Organization?> getOrganization(String id) async {

    srvcEntity.Organization? organization;

    try {

      final res = await Common.organizationApi!.getOrganizationById(id);
      organization = srvcEntity.Organization.fromMap(res?.toJson() ?? {});

    }
    on ApiException catch (e) {
      throw FormatException("${e.code}: ${e.message}");
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }

    return organization;
  }

  static Future<List<srvcEntity.ServerGroup>> getServerGroups(String? organizationId) async {

    List<srvcEntity.ServerGroup> serverGroups = [];

    try{

      final res = await Common.serversGroupApi!.getServerGroups(
          limit: 100,
          offset: 0,
          organizationId : organizationId
      );

      res?.forEach((element) {
        serverGroups.add(srvcEntity.ServerGroup.fromMap(element.toJson()));
      });

    } on ApiException catch (e) {
      throw FormatException("${e.code}: ${e.message}");
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }

    return serverGroups;
  }

  static Future<srvcEntity.ServerGroup?> getServerGroup(String id) async {

    srvcEntity.ServerGroup? serverGroup;

    try{
      final res = await Common.serversGroupApi!.getServerGroupById(id);

      serverGroup = srvcEntity.ServerGroup.fromMap(res?.toJson() ?? {});

    } on ApiException catch (e) {
      throw FormatException("${e.code}: ${e.message}");
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }

    return serverGroup;
  }

  static Future<void> sendApplication(String id, String name, String email) async {
    try {
      await Common.applicationApi!.createAdminApplication(
          CreateAdminApplicationRequest(
              application: AdminApplicationCreation(
                  user: FirebaseUser(
                    id: id,
                    name: name,
                    email: email,
                  )
              )
          )
      );
    } on ApiException catch (e) {
      throw FormatException("${e.code}: ${e.message}");
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

}