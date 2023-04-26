part of 'entity.dart';

class WashServer {
  String? id;
  String? name;
  String? description;
  String? serviceKey;

  WashServer({this.id, this.name, this.description, this.serviceKey});

  WashServer copyWith({String? id, String? name, String? description, String? serviceKey}) {
    return WashServer(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      serviceKey: serviceKey ?? this.serviceKey,
    );
  }
}
