import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mobile_wash_control/domain/blocs/services_cubit.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/common/washNavigationDrawer.dart';
import 'package:mobile_wash_control/repository/repository.dart';
import 'package:mobile_wash_control/presentation/segments/services_segments/services_bonus_program_segment.dart';
import 'package:mobile_wash_control/presentation/segments/services_segments/services_server_binding_segment.dart';

import '../segments/services_segments/services_sbp_segment.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<ServicesPageCubit> (
      create: (_) => ServicesPageCubit(),
      child: const _ServicesPageView(),
      dispose: (context, value) => value.close(),
    );
  }
}

class _ServicesPageView extends StatelessWidget {
  const _ServicesPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final Repository repository = args[PageArgCode.repository];

    final cubit = context.watch<ServicesPageCubit>();

    return StreamBuilder<ServicesPageState>(
      initialData: cubit.state,
      stream: cubit.stream,
      builder: (context, snapshot) {

        final firebaseUser = snapshot.requireData.servicesPageEntity.firebaseUser;
        final serviceUser = snapshot.requireData.servicesPageEntity.serviceUser;

        return Scaffold(
          appBar: AppBar(title: Text("Сервисы")),
          drawer: WashNavigationDrawer(selected: SelectedPage.Services, repository: repository),
          body: SafeArea(
            child: firebaseUser == null ? Center(
              child: CircularProgressIndicator(),
            ) :
            ListView(
              physics: BouncingScrollPhysics(),
              children: serviceUser == null ? [
                Center(
                  child: Text("Вы не зарегистрированы в админ-панели"),
                ),
                Center(
                  child: ElevatedButton(
                    child: Text("Подать заявку"),
                    onPressed: snapshot.requireData.servicesPageEntity.sendApplicationButtonPressed ? null :
                        () async { await cubit.sendApplication();},
                  ),
                ),
                Center(
                  child: snapshot.requireData.servicesPageEntity.applicationDelivered ?
                  Text("Ваша заявка находится на рассмотрении") :
                  Text(""),
                )
              ] :
              [
                ServicesBonusProgramSegment(
                  serviceUser: snapshot.requireData.servicesPageEntity.serviceUser!,
                ),
                ServicesSbpSegment(
                  serviceUser: snapshot.requireData.servicesPageEntity.serviceUser!,
                ),
                ServicesServerBindingSegment(
                  serviceUser: snapshot.requireData.servicesPageEntity.serviceUser!,
                )
              ],
            )
          ),
        );
      },
    );
  }
}
