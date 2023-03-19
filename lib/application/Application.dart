import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/mobile/AccountsMenu.dart';
import 'package:mobile_wash_control/mobile/AccountsMenuAdd.dart';
import 'package:mobile_wash_control/mobile/AccountsMenuEdit.dart';
import 'package:mobile_wash_control/mobile/AdvertisingCampagins.dart';
import 'package:mobile_wash_control/mobile/AdvertisingCampaginsCreate.dart';
import 'package:mobile_wash_control/mobile/AdvertisingCampaginsEdit.dart';
import 'package:mobile_wash_control/mobile/HomePage.dart';
import 'package:mobile_wash_control/mobile/IncassationHistory.dart';
import 'package:mobile_wash_control/mobile/MotorMenu.dart';
import 'package:mobile_wash_control/mobile/PostMenuEdit.dart';
import 'package:mobile_wash_control/mobile/PostsMenu.dart';
import 'package:mobile_wash_control/mobile/ProgramMenuAdd.dart';
import 'package:mobile_wash_control/mobile/ProgramMenuEdit.dart';
import 'package:mobile_wash_control/mobile/ProgramsMenu.dart';
import 'package:mobile_wash_control/mobile/SettingsDefaultConfigs.dart';
import 'package:mobile_wash_control/mobile/SettingsMenu.dart';
import 'package:mobile_wash_control/mobile/SettingsMenuKasse.dart';
import 'package:mobile_wash_control/mobile/SettingsMenuPost.dart';
import 'package:mobile_wash_control/mobile/SettingsServicesPage.dart';
import 'package:mobile_wash_control/mobile/SettingsServicesRegistrationPage.dart';
import 'package:mobile_wash_control/mobile/StatisticsMenu.dart';
import 'package:mobile_wash_control/mobile/pages/auth.dart';
import 'package:mobile_wash_control/mobile/pages/home.dart';

final RouteObserver<PageRoute> routeObserver = new RouteObserver<PageRoute>();

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mobile Wash Control",
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => Home(),
        "/mobile/auth": (context) => Auth(
              host: ModalRoute.of(context)?.settings.arguments as String,
            ),
        "/mobile/home": (context) => HomePage(),
        "/mobile/editPost": (context) => EditPostMenu(),
        "/mobile/programs": (context) => ProgramsMenu(),
        "/mobile/programs/edit": (context) => ProgramMenuEdit(),
        "/mobile/programs/add": (context) => ProgramMenuAdd(),
        "/mobile/settings": (context) => SettingsMenu(),
        "/mobile/settings/post": (context) => SettingsMenuPost(),
        "/mobile/settings/kasse": (context) => SettingsMenuKasse(),
        "/mobile/settings/default": (context) => SettingsDefaultConfigs(),
        "/mobile/services": (context) => SettingsServicesPage(sessionData: ModalRoute.of(context)?.settings.arguments as SessionData),
        "/mobile/services-auth": (context) => SettingsServicesRegistrationPage(),
        "/mobile/statistics": (context) => StatisticsMenu(),
        "/mobile/motors": (context) => MotorMenu(),
        "/mobile/posts": (context) => PostsMenu(),
        "/mobile/accounts": (context) => AccountsMenu(),
        "/mobile/accounts/edit": (context) => AccountsMenuEdit(),
        "/mobile/accounts/add": (context) => AccountsMenuAdd(),
        "/mobile/incassation": (context) => IncassationHistory(),
        "/mobile/advertisings": (conmtext) => AdvertisingCampagins(),
        "/mobile/advertisings/create": (context) => AdvertisingCampaginsCreate(),
        "/mobile/advertisings/edit": (context) => AdvertisingCampaginsEdit(),
      },
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: [const Locale('en'), const Locale('ru')],
      navigatorObservers: <NavigatorObserver>[routeObserver],
    );
  }
}
