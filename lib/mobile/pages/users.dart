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
      body: FutureBuilder(
        future: repository.updateUsers(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
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
                              Navigator.pushNamed(context, "/mobile/users/edit", arguments: args).then((value) => repository.updateUsers());
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
                    Navigator.pushNamed(context, "/mobile/users/edit", arguments: args).then((value) => repository.updateUsers());
                  },
                  child: Text("добавить пользователя"),
                ),
              ],
            ),
            onRefresh: () async {
              await repository.updateUsers();
            },
          );
        },
      ),
    );
  }
}
