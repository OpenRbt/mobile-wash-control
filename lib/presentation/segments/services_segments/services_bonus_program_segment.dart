import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mobile_wash_control/domain/blocs/services_bonus_program_cubit.dart';
import 'package:mobile_wash_control/domain/entities/user_entity.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/common/ProgressButton.dart';
import 'package:mobile_wash_control/repository/repository.dart';
import 'package:mobile_wash_control/utils/validators.dart';
import 'package:mobile_wash_control/presentation/widgets/drop_downs/drop_down_by_id_and_name.dart';

class ServicesBonusProgramSegment extends StatelessWidget {

  final ServiceUser serviceUser;

  const ServicesBonusProgramSegment({Key? key, required this.serviceUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<ServicesBonusProgramSegmentCubit>(
      create: (_) => ServicesBonusProgramSegmentCubit(serviceUser),
      child: _ServicesBonusProgramSegmentView(),
      dispose: (context, value) => value.close(),
    );
  }
}

class _ServicesBonusProgramSegmentView extends StatefulWidget {
  const _ServicesBonusProgramSegmentView({Key? key}) : super(key: key);

  @override
  State<_ServicesBonusProgramSegmentView> createState() => _ServicesBonusProgramSegmentViewState();
}

class _ServicesBonusProgramSegmentViewState extends State<_ServicesBonusProgramSegmentView> {

  late TextEditingController _serverNameController;
  late TextEditingController _serverDescriptionController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _serverNameController = TextEditingController();
    _serverDescriptionController = TextEditingController();

    final cubit = context.read<ServicesBonusProgramSegmentCubit>();
    cubit.stream.listen((state) {
      _updateTextControllers(state);
    });
  }

  void _updateTextControllers(ServicesBonusProgramSegmentState state) {
    final newName = state.servicesBonusProgramEntity.bonusWashServer?.name ?? "";
    if (_serverNameController.text != newName) {
      _serverNameController.text = newName;
      _serverNameController.selection = TextSelection.fromPosition(TextPosition(offset: _serverNameController.text.length));
    }

    final newDescription = state.servicesBonusProgramEntity.bonusWashServer?.description ?? "";
    if (_serverDescriptionController.text != newDescription) {
      _serverDescriptionController.text = newDescription;
      _serverDescriptionController.selection = TextSelection.fromPosition(TextPosition(offset: _serverDescriptionController.text.length));
    }
  }

  @override
  void dispose() {
    _serverNameController.dispose();
    _serverDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text("Бонусная программа"),
        children: [
          Form(
            key: _formKey,
            child: Wrap(
              children: [
                _NameAndDescriptionView(
                  serverNameController: _serverNameController,
                  serverDescriptionController: _serverDescriptionController,
                ),
                const _ChooseGroupView(),
                const Divider(height: 10,),
                const _DisplayWashDataView(),
                const Divider(height: 10,),
                _InteractionView(formKey: _formKey,)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _NameAndDescriptionView extends StatelessWidget {
  const _NameAndDescriptionView({
    Key? key,
    required this.serverNameController,
    required this.serverDescriptionController
  }) : super(key: key);

  final TextEditingController serverNameController;
  final TextEditingController serverDescriptionController;

  @override
  Widget build(BuildContext context) {

    final cubit = context.watch<ServicesBonusProgramSegmentCubit>();

    return StreamBuilder(
        initialData: cubit.state,
        stream: cubit.stream,
        builder: (context, snapshot) {

          return Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                      child: Text(
                        "Имя",
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding:const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                        controller: serverNameController,
                        validator: textValidator,
                        onChanged: (val) { cubit.onNameChanged(val); },
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                      child: Text(
                        "Описание",
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding:const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                        controller: serverDescriptionController,
                        onChanged: (val) { cubit.onDescriptionChanged(val); },
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        }
    );
  }
}

class _ChooseGroupView extends StatelessWidget {
  const _ChooseGroupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final cubit = context.watch<ServicesBonusProgramSegmentCubit>();

    return StreamBuilder(
        initialData: cubit.state,
        stream: cubit.stream,
        builder: (context, snapshot) {

          bool interactionBlocked = snapshot.requireData.servicesBonusProgramEntity.interactionBlocked;

          return Column(
            children: [
              snapshot.requireData.servicesBonusProgramEntity.serviceUser?.role == ServiceUserRole.admin ?
              Container() :
              Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                        child: Text(
                          "Организация",
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding:const EdgeInsets.symmetric(horizontal: 8.0),
                        child: DropDownByIdAndName(
                          values: snapshot.requireData.servicesBonusProgramEntity.organizations,
                          currentValue: snapshot.requireData.servicesBonusProgramEntity.currentOrganization,
                          onChanged: (value) async { await cubit.onChangeOrganization(value); },
                          canEdit: !interactionBlocked,
                        ),
                      ),
                    )
                  ]
              ),
              Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                        child: Text(
                          "Группа",
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding:const EdgeInsets.symmetric(horizontal: 8.0),
                        child: DropDownByIdAndName(
                          values: snapshot.requireData.servicesBonusProgramEntity.serverGroups,
                          currentValue: snapshot.requireData.servicesBonusProgramEntity.currentServerGroup,
                          onChanged: (value) async { await cubit.onChangeServerGroup(value); },
                            canEdit: !interactionBlocked
                        ),
                      ),
                    )
                  ]
              ),
            ],
          );
        }
    );
  }
}

class _DisplayWashDataView extends StatelessWidget {
  const _DisplayWashDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final cubit = context.watch<ServicesBonusProgramSegmentCubit>();

    return StreamBuilder(
        initialData: cubit.state,
        stream: cubit.stream,
        builder: (context, snapshot) {

          String id = (snapshot.requireData.servicesBonusProgramEntity.bonusWashServer?.id ?? '').isEmpty ? "Не зарегистрирована" :  snapshot.requireData.servicesBonusProgramEntity.bonusWashServer!.id;
          String serviceKey = (snapshot.requireData.servicesBonusProgramEntity.bonusWashServer?.serviceKey ?? '').isEmpty ? "Не зарегистрирована" :  snapshot.requireData.servicesBonusProgramEntity.bonusWashServer!.serviceKey;

          return Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ID",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding:  const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextButton(
                        onPressed: null,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              id,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "KEY",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding:  const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextButton(
                        onPressed: null,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              serviceKey,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
    );
  }
}

class _InteractionView extends StatelessWidget {

  final GlobalKey<FormState> formKey;

  const _InteractionView({Key? key, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final cubit = context.watch<ServicesBonusProgramSegmentCubit>();

    final args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final Repository repository = args[PageArgCode.repository];

    return StreamBuilder(
        initialData: cubit.state,
        stream: cubit.stream,
        builder: (context, snapshot) {

          bool interactionBlocked = snapshot.requireData.servicesBonusProgramEntity.interactionBlocked;
          bool isRegistered = snapshot.requireData.servicesBonusProgramEntity.bonusWashServer?.id.isNotEmpty ?? false;

          return Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                      child: ProgressButton(
                        onPressed: (interactionBlocked || !isRegistered)
                            ? null :
                            () {
                              var args = Map<PageArgCode, dynamic>();
                              args[PageArgCode.repository] = repository;
                              Navigator.pushNamed(context, "/mobile/home/bonus-status", arguments: args);
                        },
                        child: Text(
                          "Статус сервиса",
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                      child: ProgressButton(
                        onPressed: (interactionBlocked || !isRegistered)
                            ? null :
                            () async {
                              if (formKey.currentState!.validate()) {
                                cubit.updateBonusWashServer();
                              }
                        },
                        child: Text(
                          "Сохранить изменения",
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                      child: ProgressButton(
                        onPressed: (interactionBlocked || isRegistered )
                            ? null :
                            () async {
                          if (formKey.currentState!.validate()) {
                            cubit.registerBonusWashServer();
                          }
                        },
                        child: Text(
                          "Зарегистрировать мойку",
                          maxLines: 2,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        }
    );
  }
}
