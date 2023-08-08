import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/common/ProgressButton.dart';
import 'package:mobile_wash_control/mobile/widgets/common/snackBars.dart';
import 'package:mobile_wash_control/mobile/widgets/common/washNavigationDrawer.dart';
import 'package:mobile_wash_control/repository/repository.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:url_launcher/url_launcher.dart';

import '../../utils/common.dart';

class SettingsServicesRegistrationPage extends StatefulWidget {
  @override
  State<SettingsServicesRegistrationPage> createState() => _SettingsServicesRegistrationPageState();
}

class _SettingsServicesRegistrationPageState extends State<SettingsServicesRegistrationPage> {
  FirebaseAuth auth = FirebaseAuth.instanceFor(app: Firebase.app("openwashing"));
  DesktopAuthBridge authBridge = DesktopAuthBridge(FirebaseAuth.instanceFor(app: Firebase.app("openwashing")));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final args = ModalRoute.of(context)!.settings.arguments as Map<PageArgCode, dynamic>;
    final repository = args[PageArgCode.repository] as Repository;

    return Scaffold(
      appBar: AppBar(title: Text("Авторизация в сервисах")),
      drawer: WashNavigationDrawer(selected: SelectedPage.Services, repository: repository),
      body: Center(
        child: StreamBuilder(
          stream: auth.userChanges(),
          builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.data != null) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text("Продолжить"),
                      onPressed: () async {
                        Common.SetAuthToken((await snapshot.data!.getIdToken() ?? ""));

                        var args = Map<PageArgCode, dynamic>();
                        args[PageArgCode.repository] = repository;

                        Navigator.pushReplacementNamed(
                          context,
                          "/mobile/services",
                          arguments: args,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProgressButton(
                      onPressed: () async {
                        if (Platform.isAndroid) {
                          await GoogleSignIn().signOut();
                        }
                        if (Platform.isLinux) {
                          await authBridge.signOut();
                        }
                        await auth.signOut();
                      },
                      child: Text("Выйти из учетной записи ${snapshot.data!.email ?? ""}"),
                    ),
                  ),
                ],
              );
            } else {
              return ProgressButton(
                onPressed: () async {
                  if (Platform.isAndroid) {
                    try {
                      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

                      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

                      final credential = GoogleAuthProvider.credential(
                        accessToken: googleAuth?.accessToken,
                        idToken: googleAuth?.idToken,
                      );

                      await auth.signInWithCredential(credential);
                    } catch (err) {
                      log(err.toString());
                      ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Не удалось авторизоваться"));
                    }
                  } else {
                    try {
                      oauth2.Credentials credentials = await authBridge.login();

                      AuthCredential authCredential = GoogleAuthProvider.credential(
                        idToken: credentials.idToken,
                        accessToken: credentials.accessToken,
                      );

                      await auth.signInWithCredential(authCredential);
                    } catch (err) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "Не удалось авторизоваться"));
                    }
                  }
                },
                child: Text("Войти с помощью Google"),
              );
            }
          },
        ),
      ),
    );
  }
}

const String googleAuthApi = "https://accounts.google.com/o/oauth2/v2/auth";
const String googleTokenApi = "https://oauth2.googleapis.com/token";
const String revokeTokenUrl = 'https://oauth2.googleapis.com/revoke';

const _redirectURL = "http://localhost:";

class DesktopAuthBridge {
  final FirebaseAuth auth;

  DesktopAuthBridge(this.auth);

  HttpServer? redirectServer;
  String? accessToken;

  Future<oauth2.Credentials> login() async {
    await redirectServer?.close();

    redirectServer = await HttpServer.bind("localhost", 0);
    final redirectUrl = _redirectURL + redirectServer!.port.toString();

    oauth2.Client authorizerdClient = await _authorizeClient(Uri.parse(redirectUrl));
    accessToken = authorizerdClient.credentials.accessToken;
    return authorizerdClient.credentials;
  }

  Future<oauth2.Client> _authorizeClient(Uri redirectURL) async {
    var grant = oauth2.AuthorizationCodeGrant(
      const String.fromEnvironment("linux_client_id"),
      Uri.parse(googleAuthApi),
      Uri.parse(googleTokenApi),
      httpClient: JsonAcceptingHttpClient(),
      secret: const String.fromEnvironment("linux_client_secret"),
    );

    var authUrl = grant.getAuthorizationUrl(redirectURL, scopes: ["email"]);
    await _redirect(authUrl);
    var responseQueryParams = await _listen();
    var client = await grant.handleAuthorizationResponse(responseQueryParams);

    return client;
  }

  Future<void> _redirect(Uri authUri) async {
    if (await canLaunchUrl(authUri)) {
      await launchUrl(authUri);
    } else {
      throw Exception('cant launch authUrl');
    }
  }

  Future<Map<String, String>> _listen() async {
    print("listen start");
    var request = await redirectServer!.first;
    var params = request.uri.queryParameters;

    request.response.statusCode = HttpStatus.ok;
    request.response.headers.contentType = ContentType("text", "html", charset: "utf-8");
    request.response.writeln('''
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <meta charset="utf-8"> 
        <title>MobileWashControl</title>
      </head>
      <body>
        <center>
          <h1>
            Авторизация завершена, вернитесь в приложение!
          </h1>
        </center>
      </body>
    </html>
    ''');

    await request.response.close();
    await redirectServer!.close();
    redirectServer = null;
    return params;
  }

  Future<bool> signOut() async {
    final Uri uri = Uri.parse(revokeTokenUrl).replace(queryParameters: {"token": accessToken});
    final http.Response response = await http.post(uri);
    accessToken = null;
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

class JsonAcceptingHttpClient extends http.BaseClient {
  final _httpClient = http.Client();
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Accept'] = 'application/json';

    return _httpClient.send(request);
  }
}
