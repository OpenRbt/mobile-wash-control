import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/common/washNavigationDrawer.dart';
import 'package:mobile_wash_control/repository/repository.dart';

import '../../service/authentication.dart' as Auth;
import '../../utils/common.dart';

class SettingsServicesRegistrationPage extends StatefulWidget {
  @override
  State<SettingsServicesRegistrationPage> createState() => _SettingsServicesRegistrationPageState();
}

class _SettingsServicesRegistrationPageState extends State<SettingsServicesRegistrationPage> {
  FirebaseAuth auth = FirebaseAuth.instanceFor(app: Firebase.app("openwashing"));
  @override
  Widget build(BuildContext context) {
    bool _isSigningIn = false;

    final theme = Theme.of(context);

    final args = ModalRoute.of(context)!.settings.arguments as Map<PageArgCode, dynamic>;
    final repository = args[PageArgCode.repository] as Repository;

    StreamBuilder(
      stream: auth.userChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (auth.currentUser != null) {
          return ElevatedButton(
            onPressed: () async {
              Common.SetAuthToken(await snapshot.data!.getIdToken());

              var args = Map<PageArgCode, dynamic>();
              args[PageArgCode.repository] = repository;

              Navigator.pushReplacementNamed(
                context,
                "/mobile/services",
                arguments: args,
              );
            },
            child: Text("Продолжить"),
          );
        }

        return ElevatedButton(
          onPressed: () async {
            setState(() {
              _isSigningIn = true;
            });
            await Auth.Authentication.authorize(context: context);
            setState(() {
              _isSigningIn = false;
            });
          },
          child: Text("Войти с помощью Google"),
        );
      },
    );

    return Scaffold(
      appBar: AppBar(title: Text("Авторизация в сервисах")),
      drawer: WashNavigationDrawer(selected: SelectedPage.Services, repository: repository),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () async {
              setState(() {
                _isSigningIn = true;
              });

              User? user = await Auth.Authentication.authorize(context: context);
              setState(() {
                _isSigningIn = false;
              });
              if (user != null) {
                Common.SetAuthToken(await user.getIdToken());

                var args = Map<PageArgCode, dynamic>();
                args[PageArgCode.repository] = repository;

                Navigator.pushReplacementNamed(
                  context,
                  "/mobile/services",
                  arguments: args,
                );
              }
            },
            child: Text("Войти с помощью Google"),
          ),
        ),
      ),
    );
  }
}
