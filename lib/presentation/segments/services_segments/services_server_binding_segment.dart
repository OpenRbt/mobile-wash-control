import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mobile_wash_control/domain/entities/user_entity.dart';
import 'package:mobile_wash_control/domain/blocs/services_server_binding_cubit.dart';

import '../../../mobile/widgets/common/ProgressButton.dart';
import '../../widgets/drop_downs/drop_down_by_id_and_name.dart';


class ServicesServerBindingSegment extends StatelessWidget {
  final ServiceUser serviceUser;

  const ServicesServerBindingSegment({Key? key, required this.serviceUser, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<ServicesServerBindingSegmentCubit>(
      create: (_) => ServicesServerBindingSegmentCubit(serviceUser),
      child: _ServicesServerBindingSegmentView(),
      dispose: (context, value) => value.close(),
    );
  }
}

class _ServicesServerBindingSegmentView extends StatefulWidget {
  const _ServicesServerBindingSegmentView({Key? key}) : super(key: key);

  @override
  State<_ServicesServerBindingSegmentView> createState() => _ServicesServerBindingSegmentViewState();
}

class _ServicesServerBindingSegmentViewState extends State<_ServicesServerBindingSegmentView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text("Привязка сервера"),
        children: [
          Wrap(
            children: [
              const _ChooseServerView(),
              const Divider(height: 10,),
              const _DisplayWashDataView(),
              const Divider(height: 10,),
              const _InteractionView()
            ],
          )
        ],
      ),
    );
  }
}

class _ChooseServerView extends StatelessWidget {
  const _ChooseServerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final cubit = context.watch<ServicesServerBindingSegmentCubit>();

    return StreamBuilder(
        initialData: cubit.state,
        stream: cubit.stream,
        builder: (context, snapshot) {

          bool interactionBlocked = snapshot.requireData.servicesServerBindingEntity.interactionBlocked;

          return Column(
            children: [
              snapshot.requireData.servicesServerBindingEntity.serviceUser?.role == ServiceUserRole.admin ?
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
                          values: snapshot.requireData.servicesServerBindingEntity.organizations,
                          currentValue: snapshot.requireData.servicesServerBindingEntity.currentOrganization,
                          onChanged: (value) async {
                            await cubit.onChangeOrganization(value);
                            },
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
                            values: snapshot.requireData.servicesServerBindingEntity.serverGroups,
                            currentValue: snapshot.requireData.servicesServerBindingEntity.currentServerGroup,
                            onChanged: (value) async {
                              await cubit.onChangeServerGroup(value);
                              },
                            canEdit: !interactionBlocked
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
                          "Сервер",
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding:const EdgeInsets.symmetric(horizontal: 8.0),
                        child: DropDownByIdAndName(
                            values: snapshot.requireData.servicesServerBindingEntity.washServers,
                            currentValue: snapshot.requireData.servicesServerBindingEntity.currentWashServer,
                            onChanged: (value) async {
                              await cubit.onChangeWashServer(value);
                            },
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

    final cubit = context.watch<ServicesServerBindingSegmentCubit>();

    return StreamBuilder(
        initialData: cubit.state,
        stream: cubit.stream,
        builder: (context, snapshot) {

          String id = snapshot.requireData.servicesServerBindingEntity.currentId;
          String serviceKey = snapshot.requireData.servicesServerBindingEntity.currentServiceKey;

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

  const _InteractionView({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final cubit = context.watch<ServicesServerBindingSegmentCubit>();

    return StreamBuilder(
        initialData: cubit.state,
        stream: cubit.stream,
        builder: (context, snapshot) {

          bool interactionBlocked = snapshot.requireData.servicesServerBindingEntity.interactionBlocked;
          bool washExists = (snapshot.requireData.servicesServerBindingEntity.currentWashServer?.id ?? '').isNotEmpty;

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
                        onPressed: (interactionBlocked || !washExists )
                            ? null :
                            () async {
                          cubit.bindWashServer();
                        },
                        child: Text(
                          "Привязать мойку",
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