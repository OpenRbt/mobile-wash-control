import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/mobile/AccountsMenu.dart';
import 'package:mobile_wash_control/mobile/AccountsMenuAdd.dart';
import 'package:mobile_wash_control/mobile/AccountsMenuEdit.dart';
import 'package:mobile_wash_control/mobile/AdvertisingCampagins.dart';
import 'package:mobile_wash_control/mobile/AdvertisingCampaginsCreate.dart';
import 'package:mobile_wash_control/mobile/AdvertisingCampaginsEdit.dart';
import 'package:mobile_wash_control/mobile/IncassationHistory.dart';
import 'package:mobile_wash_control/mobile/MotorMenu.dart';
import 'package:mobile_wash_control/mobile/PostMenuEdit.dart';
import 'package:mobile_wash_control/mobile/PostsMenu.dart';
import 'package:mobile_wash_control/mobile/ProgramMenuAdd.dart';
import 'package:mobile_wash_control/mobile/SettingsMenuPost.dart';
import 'package:mobile_wash_control/mobile/SettingsServicesPage.dart';
import 'package:mobile_wash_control/mobile/SettingsServicesRegistrationPage.dart';
import 'package:mobile_wash_control/mobile/StatisticsMenu.dart';
import 'package:mobile_wash_control/mobile/pages/auth.dart';
import 'package:mobile_wash_control/mobile/pages/home.dart';
import 'package:mobile_wash_control/mobile/pages/home/managePost.dart';
import 'package:mobile_wash_control/mobile/pages/overview.dart';
import 'package:mobile_wash_control/mobile/pages/programs.dart';
import 'package:mobile_wash_control/mobile/pages/programs/editProgram.dart';
import 'package:mobile_wash_control/mobile/pages/settings.dart';
import 'package:mobile_wash_control/mobile/pages/settings/kasse.dart';
import 'package:mobile_wash_control/mobile/pages/settings/presets.dart';

final RouteObserver<PageRoute> routeObserver = new RouteObserver<PageRoute>();

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mobile Wash Control",
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => Home(),
        "/mobile/auth": (context) => Auth(
              host: ModalRoute.of(context)?.settings.arguments as String,
            ),
        "/mobile/home": (context) => OverviewPage(sessionData: ModalRoute.of(context)?.settings.arguments as SessionData),
        "/mobile/editPost": (context) => ManagePostPage(postMenuArgs: ModalRoute.of(context)?.settings.arguments as PostMenuArgs), //TODO: REMOVE args struct, use Map <String, dynamic>
        "/mobile/programs": (context) => ProgramsPage(),
        "/mobile/programs/edit": (context) => EditProgramPage(
              editArgs: ModalRoute.of(context)?.settings.arguments as EditProgramArgs,
            ), //TODO: REMOVE args struct, use Map <String, dynamic>
        "/mobile/programs/add": (context) => ProgramMenuAdd(), //TODO: rework, merge with "/mobile/programs/edit"
        "/mobile/settings": (context) => SettingsPage(),
        "/mobile/settings/post": (context) => SettingsMenuPost(), //TODO: rework
        "/mobile/settings/kasse": (context) => KassePage(),
        "/mobile/settings/default": (context) => PresetsPage(),
        "/mobile/services": (context) => SettingsServicesPage(sessionData: ModalRoute.of(context)?.settings.arguments as SessionData), //TODO: rework
        "/mobile/services-auth": (context) => SettingsServicesRegistrationPage(), //TODO: rework
        "/mobile/statistics": (context) => StatisticsMenu(), //TODO: rework
        "/mobile/motors": (context) => MotorMenu(), //TODO: rework
        "/mobile/posts": (context) => PostsMenu(), //TODO: rework
        "/mobile/accounts": (context) => AccountsMenu(), //TODO: rework
        "/mobile/accounts/edit": (context) => AccountsMenuEdit(), //TODO: rework
        "/mobile/accounts/add": (context) => AccountsMenuAdd(), //TODO: rework
        "/mobile/incassation": (context) => IncassationHistory(), //TODO: rework
        "/mobile/advertisings": (conmtext) => AdvertisingCampagins(), //TODO: rework
        "/mobile/advertisings/create": (context) => AdvertisingCampaginsCreate(), //TODO: rework
        "/mobile/advertisings/edit": (context) => AdvertisingCampaginsEdit(), //TODO: rework
      },
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: [const Locale('en'), const Locale('ru')],
      navigatorObservers: <NavigatorObserver>[routeObserver],
    );
  }
}
