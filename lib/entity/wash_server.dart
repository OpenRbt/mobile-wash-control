part of 'entity.dart';

class WashServer {
  String? id;
  String? name;
  String? description;
  String? serviceKey;
  String? organizationId;
  String? groupId;
  String? createdBy;

  WashServer({this.id, this.name, this.description, this.serviceKey, this.organizationId, this.groupId, this.createdBy});

  WashServer copyWith({String? id, String? name, String? description, String? serviceKey, String? organizationId, String? groupId, String? createdBy}) {
    return WashServer(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      serviceKey: serviceKey ?? this.serviceKey,
        organizationId: organizationId ?? this.organizationId,
        groupId: groupId ?? this.groupId,
        createdBy: createdBy ?? this.createdBy
    );
  }
}

class SbpWashServer {
  String? id;
  String? name;
  String? description;
  String? servicePassword;

  SbpWashServer({this.id, this.name, this.description, this.servicePassword});
}

