import '../../openapi/wash-admin-client/api.dart';

class ServiceUser {
  String id;
  String name;
  String email;
  ServiceUserRole role;
  String organizationId;

  ServiceUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.organizationId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'email': this.email,
      'role': this.role,
      'organizationId': this.organizationId,
    };
  }

  factory ServiceUser.fromMap(Map<String, dynamic> map) {

    var adminUserRole = map['role'] as AdminUserRole;
    var serviceUserRole = convertAdminUserRoleToServiceUserRole(adminUserRole) ?? ServiceUserRole.admin;

    return ServiceUser(
      id: map['id'] as String,
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      role: serviceUserRole,
      organizationId: map['organizationId'] ?? "",
    );
  }

  ServiceUser copyWith({
    String? id,
    String? name,
    String? email,
    ServiceUserRole? role,
    String? organizationId,
  }) {
    return ServiceUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      organizationId: organizationId ?? this.organizationId,
    );
  }

  @override
  String toString() {
    return 'ServiceUser{id: $id, name: $name, email: $email, role: $role, organizationId: $organizationId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceUser &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          role == other.role &&
          organizationId == other.organizationId;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      role.hashCode ^
      organizationId.hashCode;
}

class SystemUser {

}


enum ServiceUserRole {
  systemManager,
  admin
}


ServiceUserRole? convertAdminUserRoleToServiceUserRole(AdminUserRole? adminRole) {
  switch (adminRole?.value) {
    case r'systemManager':
      return ServiceUserRole.systemManager;
    case r'admin':
      return ServiceUserRole.admin;
    default:
      return null; // или throw Exception, если неожиданное значение
  }
}