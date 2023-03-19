import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/SharedData.dart';
import 'package:mobile_wash_control/client/api.dart';
import 'package:mobile_wash_control/mobile/widgets/auth/authButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends StatefulWidget {
  final String host;

  const Auth({super.key, required this.host});

  @override
  State<StatefulWidget> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  List<String> labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "+", "0", "-"];

  late TextEditingController pinController;

  @override
  void initState() {
    pinController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  late SessionData _sessionData;

  Future<void> _tryAuth() async {
    try {
      _sessionData = new SessionData(DefaultApi(ApiClient(basePath: widget.host)));
      _sessionData.client.apiClient.addDefaultHeader("Pin", pinController.text);
      var res = await _sessionData.client.getUser();
      SharedData.sessionData = _sessionData;
      if (!await SharedData.StartTimers()) {
        print("Failed to start Timers");
      }
      _loadPage();
    } catch (e) {}
  }

  void _loadPage() async {
    final prefs = await SharedPreferences.getInstance();
    final int addServiceValue = prefs.getInt("AddServiceValue") ?? 0;
    GlobalData.AddServiceValue = addServiceValue;
    SystemChrome.setPreferredOrientations([]);
    Navigator.pushReplacementNamed(
      context,
      "/mobile/home",
      arguments: _sessionData,
    );
  }

  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Авторизация",
                  style: theme.textTheme.headlineMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.host,
                  style: theme.textTheme.labelMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: pinController,
                  readOnly: true,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall,
                  obscureText: true,
                  maxLength: 16,
                ),
              )
            ],
          ),
          GridView.count(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 3,
            childAspectRatio: 2,
            children: List.generate(
              labels.length ?? 0,
              (index) {
                return AuthButton(
                  label: labels[index],
                  onPressed: () {
                    setState(() {
                      switch (labels[index]) {
                        case "+":
                          _tryAuth();
                          break;
                        case "-":
                          var tmp = pinController.text;
                          if (tmp.length > 1) {
                            tmp = tmp.substring(0, tmp.length - 1);
                          } else {
                            tmp = "";
                          }
                          pinController.text = tmp;
                          break;
                        default:
                          var tmp = pinController.text;
                          if (tmp.length == 16) {
                            break;
                          }

                          tmp += labels[index];
                          pinController.text = tmp;
                          break;
                      }
                      print(pinController.text);
                    });
                  },
                  onLongPressed: (labels[index] == "-")
                      ? () {
                          pinController.text = "";
                        }
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
