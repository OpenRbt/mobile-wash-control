import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'package:mobile_wash_control/domain/entities/pages_entities.dart';
import 'package:mobile_wash_control/domain/entities/user_entity.dart';

import '../data_providers/bonus_transport.dart';
import '../data_providers/wash_admin_transport.dart';


class ServicesPageState {
  final ServicesPageEntity servicesPageEntity;

  const ServicesPageState({
    required this.servicesPageEntity,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServicesPageState &&
          runtimeType == other.runtimeType &&
          servicesPageEntity == other.servicesPageEntity;

  @override
  int get hashCode => servicesPageEntity.hashCode;

  @override
  String toString() {
    return 'ServicesPageState{servicesPageEntity: $servicesPageEntity}';
  }

  ServicesPageState copyWith({
    ServicesPageEntity? servicesPageEntity,
  }) {
    return ServicesPageState(
      servicesPageEntity: servicesPageEntity ?? this.servicesPageEntity,
    );
  }
}

class ServicesPageCubit extends Cubit<ServicesPageState> {

  ServicesPageCubit() : super(
      ServicesPageState(
          servicesPageEntity: ServicesPageEntity(
            serviceUser: null,
            firebaseUser: null,
            sendApplicationButtonPressed: false,
            applicationDelivered: false,
          )
      )
  ) {
    _initialize();
  }

  Future<void> _initialize() async {

    late final auth.User? firebaseUser;
    late final ServiceUser? serviceUser;

    try {
      firebaseUser = await auth.FirebaseAuth.instanceFor(app: Firebase.app("openwashing")).currentUser;
      serviceUser = await BonusTransport.getServiceUser(firebaseUser?.uid ?? "");
    } on FormatException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }


    final servicesPageEntity = await ServicesPageEntity(
      firebaseUser: firebaseUser,
      serviceUser: serviceUser,
      sendApplicationButtonPressed: false,
      applicationDelivered: false,
    );

    final newState = state.copyWith(servicesPageEntity: servicesPageEntity);

    emit(newState);
  }

  Future<void> sendApplication() async {

    var servicesPageEntity = state.servicesPageEntity;
    servicesPageEntity = servicesPageEntity.copyWith(sendApplicationButtonPressed: true, applicationDelivered: false);
    emit(state.copyWith(servicesPageEntity: servicesPageEntity));

    String uid = this.state.servicesPageEntity.firebaseUser?.uid ?? "";
    String displayName = this.state.servicesPageEntity.firebaseUser?.displayName ?? "";
    String email = this.state.servicesPageEntity.firebaseUser?.email ?? "";

    try {
      await WashAdminTransport.sendApplication(uid, displayName, email);

      servicesPageEntity = state.servicesPageEntity;
      servicesPageEntity = servicesPageEntity.copyWith(sendApplicationButtonPressed: false, applicationDelivered: true);
      emit(state.copyWith(servicesPageEntity: servicesPageEntity));

    } on FormatException catch (e) {
      servicesPageEntity = state.servicesPageEntity;
      servicesPageEntity = servicesPageEntity.copyWith(sendApplicationButtonPressed: false, applicationDelivered: false);
      emit(state.copyWith(servicesPageEntity: servicesPageEntity));
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

}