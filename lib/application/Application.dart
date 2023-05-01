import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile_wash_control/mobile/pages/auth.dart';
import 'package:mobile_wash_control/mobile/pages/discounts.dart';
import 'package:mobile_wash_control/mobile/pages/discounts/editDiscount.dart';
import 'package:mobile_wash_control/mobile/pages/home.dart';
import 'package:mobile_wash_control/mobile/pages/overview/managePost.dart';
import 'package:mobile_wash_control/mobile/pages/overview/postInkassHistory.dart';
import 'package:mobile_wash_control/mobile/pages/motors.dart';
import 'package:mobile_wash_control/mobile/pages/overview.dart';
import 'package:mobile_wash_control/mobile/pages/programs.dart';
import 'package:mobile_wash_control/mobile/pages/programs/editProgram.dart';
import 'package:mobile_wash_control/mobile/pages/servicesAuthPage.dart';
import 'package:mobile_wash_control/mobile/pages/servicesPage.dart';
import 'package:mobile_wash_control/mobile/pages/settings.dart';
import 'package:mobile_wash_control/mobile/pages/settings/kasse.dart';
import 'package:mobile_wash_control/mobile/pages/settings/presets.dart';
import 'package:mobile_wash_control/mobile/pages/settings/station.dart';
import 'package:mobile_wash_control/mobile/pages/statistics.dart';
import 'package:mobile_wash_control/mobile/pages/users.dart';
import 'package:mobile_wash_control/mobile/pages/users/editUser.dart';

//TODO: remove setState in all possible places or isolate them
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
        "/": (context) => Home(), //+
        "/mobile/auth": (context) => Auth(
              host: ModalRoute.of(context)?.settings.arguments as String,
            ),
        "/mobile/home": (context) => OverviewPage(),
        "/mobile/home/managePost": (context) => ManagePostPage(),
        "/mobile/home/incassation-history": (context) => IncassationHistoryPage(),
        "/mobile/programs": (context) => ProgramsPage(),
        "/mobile/programs/edit": (context) => EditProgramPage(),
        "/mobile/settings": (context) => SettingsPage(),
        "/mobile/settings/post": (context) => StationPage(),
        "/mobile/settings/kasse": (context) => KassePage(),
        "/mobile/settings/default": (context) => PresetsPage(),
        "/mobile/services": (context) => SettingsServicesPage(),
        "/mobile/services-auth": (context) => SettingsServicesRegistrationPage(),
        "/mobile/statistics": (context) => StatisticsPage(), //+
        "/mobile/motors": (context) => MotorPage(), //+
        "/mobile/users": (context) => UsersPage(), //+
        "/mobile/users/edit": (context) => UserEditPage(), //+
        "/mobile/discounts": (context) => DiscountsPage(),
        "/mobile/discounts/edit": (context) => EditDiscountPage(),
      },
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: [const Locale('en'), const Locale('ru')],
    );
  }
}
