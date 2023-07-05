import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/common/washNavigationDrawer.dart';
import 'package:mobile_wash_control/mobile/widgets/users/userCard.dart';
import 'package:mobile_wash_control/repository/repository.dart';

class UsersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {

  final ValueNotifier<int> _updateNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final Repository repository = args[PageArgCode.repository];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Пользователи",
        ),
      ),
      drawer: WashNavigationDrawer(
        selected: SelectedPage.Accounts,
        repository: repository,
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: _updateNotifier,
        builder: (BuildContext context, int value, Widget? child){
          return FutureBuilder(
            future: _updateData(repository),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              log("update");
              return RefreshIndicator(
                child: Column(
                  children: [
                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: repository.getUsersNotifier(),
                        builder: (BuildContext context, List<User>? value, Widget? child) {
                          final users = value;
                          return ListView.builder(
                            itemCount: users?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return UserCard(
                                user: users![index],
                                onPress: () {
                                  var args = Map<PageArgCode, dynamic>();
                                  args[PageArgCode.repository] = repository;
                                  args[PageArgCode.user] = users![index];
                                  Navigator.pushNamed(context, "/mobile/users/edit", arguments: args).then((value) {_updateNotifier.value++;});
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        var args = Map<PageArgCode, dynamic>();
                        args[PageArgCode.repository] = repository;
                        args[PageArgCode.user] = null;
                        Navigator.pushNamed(context, "/mobile/users/edit", arguments: args).then((value) => repository.updateUsers(context: context));
                      },
                      child: Text("добавить пользователя"),
                    ),
                  ],
                ),
                onRefresh: () async {
                  _updateNotifier.value++;
                  await repository.updateUsers(context: context);
                },
              );
            },
          );
        }
      )
    );
  }
  Future<void> _updateData(Repository repository) async {
    await repository.updateUsers(context: context);
  }
}

/*
FutureBuilder(
                    future: repository.getUsers(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if(snapshot.hasData){
                        final users = snapshot.data;
                        return ListView.builder(
                          itemCount: users?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return UserCard(
                              user: users![index],
                              onPress: () {
                                var args = Map<PageArgCode, dynamic>();
                                args[PageArgCode.repository] = repository;
                                args[PageArgCode.user] = users![index];
                                Navigator.pushNamed(context, "/mobile/users/edit", arguments: args).then((value) => repository.updateUsers(context: context));
                              },
                            );
                          },
                        );
                      }
                      else if(snapshot.hasError){
                        return Container();
                      }
                      else{
                        return Container();
                      }
                    },
                  ),
 */