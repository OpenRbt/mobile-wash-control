import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/auth/authButton.dart';
import 'package:mobile_wash_control/openapi/lea-central-wash/api.dart' as lcw;
import 'package:mobile_wash_control/repository/lea_central_wash_repo/repository.dart';
import 'package:mobile_wash_control/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends StatefulWidget {
  final String host;

  const Auth({super.key, required this.host});

  @override
  State<StatefulWidget> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  List<String> labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "+", "0", "-"];

  late TextEditingController pinController;

  Repository? _repo = null;

  @override
  void initState() {
    pinController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    pinController.dispose();
    _repo?.dispose();
    super.dispose();
  }

  Future<void> _tryAuth() async {
    try {
      var client = lcw.DefaultApi(lcw.ApiClient(basePath: widget.host));
      client.apiClient.addDefaultHeader("Pin", pinController.text);
      final prefs = await SharedPreferences.getInstance();
      final int addServiceValue = prefs.getInt("AddServiceValue") ?? 0;

      var args = Map<PageArgCode, dynamic>();
      var repo = LeaCentralRepository(client);
      args[PageArgCode.repository] = repo;

      final user = await repo.getCurrentUser();
      if (user == null) {
        repo.dispose();
        return;
      }
      _repo?.dispose();
      _repo = repo;
      GlobalData.AddServiceValue = addServiceValue;
      SystemChrome.setPreferredOrientations([]);
      Navigator.pushNamed(
        context,
        "/mobile/home",
        arguments: args,
      );
    } catch (e) {}
  }

  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    var appBarPadding = AppBar().preferredSize.height + MediaQuery.of(context).padding.top;
    return Scaffold(
      floatingActionButton: Platform.isAndroid
          ? null
          : FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.exit_to_app_outlined),
            ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                height: appBarPadding,
              ),
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
          Expanded(
            child: Container(
              constraints: BoxConstraints(maxWidth: 500),
              child: GridView.count(
                physics: ClampingScrollPhysics(),
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
                        setState(
                          () {
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
                          },
                        );
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
            ),
          ),
        ],
      ),
    );
  }
}
