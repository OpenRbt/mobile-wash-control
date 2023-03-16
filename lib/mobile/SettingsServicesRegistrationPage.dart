import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';

import '../service/authentication.dart' as Auth;
import '../utils/common.dart';

class SettingsServicesRegistrationPage extends StatefulWidget {
  @override
  State<SettingsServicesRegistrationPage> createState() => _SettingsServicesRegistrationPageState();
}

class _SettingsServicesRegistrationPageState extends State<SettingsServicesRegistrationPage> {
  @override
  Widget build(BuildContext context) {
    bool _isSigningIn = false;

    final SessionData sessionData = ModalRoute.of(context)?.settings.arguments as SessionData;

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
        drawer: prepareDrawer(context, Pages.Services, sessionData),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Center(
          child: Column(
            children: [
              FutureBuilder(
                future: Auth.Authentication.initializeFirebase(context: context),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return Expanded(
                      child: Center(
                        child: _isSigningIn
                            ? Column(
                                children: const [
                                  SizedBox(
                                    height: 300,
                                  ),
                                  CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                                  ),
                                ],
                              )
                            : SizedBox(
                                height: 150,
                                width: 300,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 300,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor: const MaterialStatePropertyAll<Color>(Color.fromRGBO(139, 195, 74, 1)),
                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(1),
                                            ))),
                                        onPressed: () async {
                                          setState(() {
                                            _isSigningIn = true;
                                          });

                                          User? user = await Auth.Authentication.signInWithGoogle(context: context);

                                          final idToken = await user!.getIdToken();
                                          print("idToken: " + idToken);

                                          setState(() {
                                            _isSigningIn = false;
                                          });

                                          if (user != null) {
                                            Common.SetAuthToken(await user.getIdToken());
                                            Navigator.pushNamed(context, "/mobile/services", arguments: sessionData);
                                          } else {}
                                        },
                                        child: const Text(
                                          "Войти",
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontFamily: 'RobotoCondensed',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ],
                                )),
                      ),
                    );
                  }
                  return const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.orange,
                    ),
                  );
                },
              ),
            ],
          ),
        )));
  }
}
