import 'package:firebase_auth/firebase_auth.dart';
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
  @override
  Widget build(BuildContext context) {
    bool _isSigningIn = false;

    final args = ModalRoute.of(context)!.settings.arguments as Map<PageArgCode, dynamic>;
    final repository = args[PageArgCode.repository] as Repository;

    /*
    FirebaseAuth.instance.idTokenChanges().listen((User? user) async {
      if (user == null) {
        Common.SetAuthToken("");
      } else {

      }
    });
*/

    return Scaffold(
      appBar: AppBar(title: Text("Авторизация в сервисах")),
      drawer: WashNavigationDrawer(selected: SelectedPage.Services, repository: repository),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
            future: Auth.Authentication.initializeFirebase(context: context),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }

              if (snapshot.connectionState == ConnectionState.done) {
                if (_isSigningIn) {
                  return CircularProgressIndicator();
                }

                return ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isSigningIn = true;
                    });

                    User? user = await Auth.Authentication.signInWithGoogle(context: context);

                    setState(() {
                      _isSigningIn = false;
                    });

                    if (user != null) {
                      Common.SetAuthToken(await user.getIdToken());

                      var args = Map<PageArgCode, dynamic>();
                      args[PageArgCode.repository] = repository;

                      Navigator.pushNamed(
                        context,
                        "/mobile/services",
                        arguments: args,
                      );
                    }
                  },
                  child: Text("Войти с помощью Google"),
                );
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
