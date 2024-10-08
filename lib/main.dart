import 'dart:core';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wash_control/application/Application.dart';
import 'package:mobile_wash_control/firebase_options.dart';

import 'generated/codegen_loader.g.dart';

final RouteObserver<PageRoute> routeObserver = new RouteObserver<PageRoute>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(name: "openwashing", options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('ru'),
        Locale('en'),
      ],
      startLocale: Locale('en'),
      path: 'assets/translations',
      fallbackLocale: Locale('ru'),
      assetLoader: const CodegenLoader(),
      child: Application(),
    ),
  );

}
