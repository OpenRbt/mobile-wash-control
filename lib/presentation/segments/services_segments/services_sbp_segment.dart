import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:mobile_wash_control/domain/blocs/services_sbp_cubit.dart';
import 'package:mobile_wash_control/domain/entities/user_entity.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/common/ProgressButton.dart';
import 'package:mobile_wash_control/repository/repository.dart';
import 'package:mobile_wash_control/utils/validators.dart';
import 'package:mobile_wash_control/presentation/widgets/drop_downs/drop_down_by_name.dart';

class ServicesSbpSegment extends StatelessWidget {

  final ServiceUser serviceUser;

  const ServicesSbpSegment({super.key, required this.serviceUser});

  @override
  Widget build(BuildContext context) {
    return Provider<ServicesSbpSegmentCubit>(
      create: (_) => ServicesSbpSegmentCubit(serviceUser),
      child: _ServicesSbpSegmentView(),
      dispose: (context, value) => value.close(),
    );
  }
}

class _ServicesSbpSegmentView extends StatefulWidget {
  const _ServicesSbpSegmentView({super.key});

  @override
  State<_ServicesSbpSegmentView> createState() => _ServicesSbpSegmentViewState();
}

class _ServicesSbpSegmentViewState extends State<_ServicesSbpSegmentView> {

  late TextEditingController _serverNameController;
  late TextEditingController _serverDescriptionController;
  late TextEditingController _terminalKeyController;
  late TextEditingController _terminalPasswordController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _serverNameController = TextEditingController();
    _serverDescriptionController = TextEditingController();
    _terminalKeyController = TextEditingController();
    _terminalPasswordController = TextEditingController();

    final cubit = context.read<ServicesSbpSegmentCubit>();
    cubit.stream.listen((state) {
      _updateTextControllers(state);
    });
  }

  void _updateTextControllers(ServicesSbpSegmentState state) {
    final newName = state.servicesSbpEntity.sbpWashServer?.name ?? "";
    if (_serverNameController.text != newName) {
      _serverNameController.text = newName;
      _serverNameController.selection = TextSelection.fromPosition(TextPosition(offset: _serverNameController.text.length));
    }

    final newDescription = state.servicesSbpEntity.sbpWashServer?.description ?? "";
    if (_serverDescriptionController.text != newDescription) {
      _serverDescriptionController.text = newDescription;
      _serverDescriptionController.selection = TextSelection.fromPosition(TextPosition(offset: _serverDescriptionController.text.length));
    }

    final newTerminalKey = state.servicesSbpEntity.terminalKey;
    if (_terminalKeyController.text != newTerminalKey) {
      _terminalKeyController.text = newTerminalKey;
      _terminalKeyController.selection = TextSelection.fromPosition(TextPosition(offset: _terminalKeyController.text.length));
    }

    final newTerminalPassword = state.servicesSbpEntity.terminalPassword;
    if (_terminalPasswordController.text != newTerminalPassword) {
      _terminalPasswordController.text = newTerminalPassword;
      _terminalPasswordController.selection = TextSelection.fromPosition(TextPosition(offset: _terminalPasswordController.text.length));
    }
  }

  @override
  void dispose() {
    _serverNameController.dispose();
    _serverDescriptionController.dispose();
    _terminalKeyController.dispose();
    _terminalPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(context.tr('SBP')),
        children: [
          Form(
            key: _formKey,
            child: Wrap(
              children: [
                _BaseInfoView(
                  serverNameController: _serverNameController,
                  serverDescriptionController: _serverDescriptionController,
                  terminalKeyController: _terminalKeyController,
                  terminalPasswordController: _terminalPasswordController,
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

class _BaseInfoView extends StatelessWidget {
  const _BaseInfoView({
    Key? key,
    required this.serverNameController,
    required this.serverDescriptionController,
    required this.terminalKeyController,
    required this.terminalPasswordController
  }) : super(key: key);

  final TextEditingController serverNameController;
  final TextEditingController serverDescriptionController;
  final TextEditingController terminalKeyController;
  final TextEditingController terminalPasswordController;

  @override
  Widget build(BuildContext context) {

    final cubit = context.watch<ServicesSbpSegmentCubit>();

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
                        context.tr('name'),
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
                        "${context.tr('description')}",
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding:const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                        controller: serverDescriptionController,
                        validator: textValidator,
                        onChanged: (val) { cubit.onDescriptionChanged(val); },
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
                        "Terminal Key",
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding:const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                        controller: terminalKeyController,
                        validator: textValidator,
                        onChanged: (val) { cubit.onTerminalKeyChanged(val); },
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
                        "Terminal Password",
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding:const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                        controller: terminalPasswordController,
                        validator: textValidator,
                        onChanged: (val) { cubit.onTerminalPasswordChanged(val); },
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

    final cubit = context.watch<ServicesSbpSegmentCubit>();

    return StreamBuilder(
        initialData: cubit.state,
        stream: cubit.stream,
        builder: (context, snapshot) {

          bool interactionBlocked = snapshot.requireData.servicesSbpEntity.interactionBlocked;

          return Column(
            children: [
              snapshot.requireData.servicesSbpEntity.serviceUser?.role == ServiceUserRole.admin ?
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
                          context.tr('organization'),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding:const EdgeInsets.symmetric(horizontal: 8.0),
                        child: DropDownByName(
                          values: snapshot.requireData.servicesSbpEntity.organizations,
                          currentValue: snapshot.requireData.servicesSbpEntity.currentOrganization,
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
                          context.tr('group'),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding:const EdgeInsets.symmetric(horizontal: 8.0),
                        child: DropDownByName(
                            values: snapshot.requireData.servicesSbpEntity.serverGroups,
                            currentValue: snapshot.requireData.servicesSbpEntity.currentServerGroup,
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

    final cubit = context.watch<ServicesSbpSegmentCubit>();

    return StreamBuilder(
        initialData: cubit.state,
        stream: cubit.stream,
        builder: (context, snapshot) {

          String id = (snapshot.requireData.servicesSbpEntity.sbpWashServer?.id ?? '').isEmpty ? context.tr('not_registered') :  snapshot.requireData.servicesSbpEntity.sbpWashServer!.id;

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

    final cubit = context.watch<ServicesSbpSegmentCubit>();

    final args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final Repository repository = args[PageArgCode.repository];

    return StreamBuilder(
        initialData: cubit.state,
        stream: cubit.stream,
        builder: (context, snapshot) {

          bool interactionBlocked = snapshot.requireData.servicesSbpEntity.interactionBlocked;
          bool isRegistered = snapshot.requireData.servicesSbpEntity.sbpWashServer?.id.isNotEmpty ?? false;

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
                          context.tr('service_status'),
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
                            cubit.updateSbpWashServer();
                          }
                        },
                        child: Text(
                          "${context.tr('save')} ${context.tr('changes')}",
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
                            cubit.registerSbpWashServer();
                          }
                        },
                        child: Text(
                          context.tr('register_wash'),
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