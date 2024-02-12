import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:mobile_wash_control/domain/entities/user_entity.dart';

class ServicesPageEntity {

  final auth.User? firebaseUser;
  final ServiceUser? serviceUser;
  final bool sendApplicationButtonPressed;
  final bool applicationDelivered;

  ServicesPageEntity({
    required this.serviceUser,
    this.firebaseUser,
    required this.sendApplicationButtonPressed,
    required this.applicationDelivered,
  });

  ServicesPageEntity copyWith({
    auth.User? firebaseUser,
    ServiceUser? serviceUser,
    bool? sendApplicationButtonPressed,
    bool? applicationDelivered,
  }) {
    return ServicesPageEntity(
      firebaseUser: firebaseUser ?? this.firebaseUser,
      serviceUser: serviceUser ?? this.serviceUser,
      sendApplicationButtonPressed:
          sendApplicationButtonPressed ?? this.sendApplicationButtonPressed,
      applicationDelivered: applicationDelivered ?? this.applicationDelivered,
    );
  }

  @override
  String toString() {
    return 'ServicesPageEntity{firebaseUser: $firebaseUser, serviceUser: $serviceUser, sendApplicationButtonPressed: $sendApplicationButtonPressed, applicationDelivered: $applicationDelivered}';
  }
}