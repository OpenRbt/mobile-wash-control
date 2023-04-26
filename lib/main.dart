import 'dart:core';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_wash_control/application/Application.dart';
import 'package:mobile_wash_control/firebase_options.dart';
import 'package:mobile_wash_control/openapi/wash-admin-client/api.dart';
import 'package:mobile_wash_control/utils/common.dart';

final RouteObserver<PageRoute> routeObserver = new RouteObserver<PageRoute>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app;
  try {
    app = Firebase.app("openwashing");
  } catch (e) {
    app = await Firebase.initializeApp(name: "openwashing", options: DefaultFirebaseOptions.currentPlatform);
  }

  Common.washServersApi = WashServersApi(ApiClient(
    basePath: 'http://app.openwashing.com:8070',
    authentication: HttpBearerAuth(),
  ));

  Intl.defaultLocale = "ru_RU";
  runApp(
    Application(),
  );
}
