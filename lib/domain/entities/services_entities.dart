class Organization {
  String id;
  String name;
  String description;
  bool isDefault;

  Organization({required this.id, required this.name, required this.description, required this.isDefault});

  Organization copyWith({
    String? id,
    String? name,
    String? description,
    bool? isDefault,
  }) {
    return Organization(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'description': this.description,
      'isDefault': this.isDefault,
    };
  }

  factory Organization.fromMap(Map<String, dynamic> map) {
    return Organization(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] ?? '',
      isDefault: map['isDefault'] ?? false,
    );
  }

  @override
  String toString() {
    return 'Organization{id: $id, name: $name, description: $description, isDefault: $isDefault}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Organization &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          isDefault == other.isDefault;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ description.hashCode ^ isDefault.hashCode;
}

class ServerGroup {
  String id;
  String name;
  String description;
  String organizationId;

  ServerGroup({required this.id, required this.name, required this.description, required this.organizationId});

  ServerGroup copyWith({
    String? id,
    String? name,
    String? description,
    String? organizationId,
  }) {
    return ServerGroup(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      organizationId: organizationId ?? this.organizationId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'description': this.description,
      'organizationId': this.organizationId,
    };
  }

  factory ServerGroup.fromMap(Map<String, dynamic> map) {
    return ServerGroup(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] ?? "",
      organizationId: map['organizationId'] as String,
    );
  }

  @override
  String toString() {
    return 'ServerGroup{id: $id, name: $name, description: $description, organizationId: $organizationId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServerGroup &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          organizationId == other.organizationId;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      organizationId.hashCode;
}

class SbpWashServer {
  String id;
  String name;
  String description;
  String servicePassword;
  bool isTwoStagePayment;
  String groupId;
  String organizationId;

  SbpWashServer({
    required this.id,
    required this.name,
    required this.description,
    required this.servicePassword,
    required this.isTwoStagePayment,
    required this.groupId,
    required this.organizationId,
  });

  SbpWashServer copyWith({
    String? id,
    String? name,
    String? description,
    String? servicePassword,
    bool? isTwoStagePayment,
    String? groupId,
    String? organizationId,
  }) {
    return SbpWashServer(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      servicePassword: servicePassword ?? this.servicePassword,
      isTwoStagePayment: isTwoStagePayment ?? this.isTwoStagePayment,
      groupId: groupId ?? this.groupId,
      organizationId: organizationId ?? this.organizationId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'description': this.description,
      'servicePassword': this.servicePassword,
      'isTwoStagePayment': this.isTwoStagePayment,
      'groupId': this.groupId,
      'organizationId': this.organizationId,
    };
  }

  factory SbpWashServer.fromMap(Map<String, dynamic> map) {
    return SbpWashServer(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      servicePassword: map['servicePassword'] as String,
      isTwoStagePayment: map['isTwoStagePayment'] as bool,
      groupId: map['groupId'] as String,
      organizationId: map['organizationId'] as String,
    );
  }

  @override
  String toString() {
    return 'SbpWashServer{id: $id, name: $name, description: $description, servicePassword: $servicePassword, isTwoStagePayment: $isTwoStagePayment, groupId: $groupId, organizationId: $organizationId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SbpWashServer &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          servicePassword == other.servicePassword &&
          isTwoStagePayment == other.isTwoStagePayment &&
          groupId == other.groupId &&
          organizationId == other.organizationId;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      servicePassword.hashCode ^
      isTwoStagePayment.hashCode ^
      groupId.hashCode ^
      organizationId.hashCode;
}

class WashServer {

  String id;
  String name;
  String description;
  String serviceKey;
  String createdBy;
  String groupId;
  String organizationId;

  WashServer({
    required this.id,
    required this.name,
    required this.description,
    required this.serviceKey,
    required this.createdBy,
    required this.groupId,
    required this.organizationId,
  });

  WashServer copyWith({
    String? id,
    String? name,
    String? description,
    String? serviceKey,
    String? createdBy,
    String? groupId,
    String? organizationId,
  }) {
    return WashServer(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      serviceKey: serviceKey ?? this.serviceKey,
      createdBy: createdBy ?? this.createdBy,
      groupId: groupId ?? this.groupId,
      organizationId: organizationId ?? this.organizationId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'description': this.description,
      'serviceKey': this.serviceKey,
      'createdBy': this.createdBy,
      'groupId': this.groupId,
      'organizationId': this.organizationId,
    };
  }

  factory WashServer.fromMap(Map<String, dynamic> map) {
    return WashServer(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      serviceKey: map['serviceKey'] ?? '',
      createdBy: map['createdBy'] ?? '',
      groupId: map['groupId'] ?? '',
      organizationId: map['organizationId'] ?? '',
    );
  }

  @override
  String toString() {
    return 'BonusWashServer{id: $id, name: $name, description: $description, serviceKey: $serviceKey, createdBy: $createdBy, groupId: $groupId, organizationId: $organizationId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WashServer &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          serviceKey == other.serviceKey &&
          createdBy == other.createdBy &&
          groupId == other.groupId &&
          organizationId == other.organizationId;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      serviceKey.hashCode ^
      createdBy.hashCode ^
      groupId.hashCode ^
      organizationId.hashCode;
}