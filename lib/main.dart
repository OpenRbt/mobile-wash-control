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
  await Firebase.initializeApp(name: "openwashing", options: DefaultFirebaseOptions.currentPlatform);

  Intl.defaultLocale = "ru_RU";
  runApp(
    Application(),
  );
}
