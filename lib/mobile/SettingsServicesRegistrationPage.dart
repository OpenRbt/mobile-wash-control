import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';

class SettingsServicesRegistrationPage extends StatefulWidget {

  @override
  State<SettingsServicesRegistrationPage> createState() => _SettingsServicesRegistrationPageState();
}

class _SettingsServicesRegistrationPageState extends State<SettingsServicesRegistrationPage>{

  @override
  Widget build(BuildContext context) {

    final arguments = ModalRoute.of(context).settings.arguments as Map;
    SessionData sessionData = arguments['sessionData'];

    return Scaffold(
        appBar: AppBar(
            title: Text("Регистрация в сервисах")
        ),
        drawer: prepareDrawer(context, Pages.Settings, sessionData),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Center(
              child: Column(
                children: [
              Padding(
              padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: ()  {
                      Navigator.pushNamed(
                          context, "/mobile/settings/services",
                          arguments: {'sessionData': sessionData});
                    },
                    child: const Text("Войти"),
                  )
              ),

                ],
              ),
            )
        )
    );
  }
}
