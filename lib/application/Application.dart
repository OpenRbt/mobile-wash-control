import 'dart:ui';

import 'package:flutter/material.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile_wash_control/mobile/pages/auth.dart';
import 'package:mobile_wash_control/mobile/pages/current_group.dart';
import 'package:mobile_wash_control/mobile/pages/current_organization.dart';
import 'package:mobile_wash_control/mobile/pages/discounts.dart';
import 'package:mobile_wash_control/mobile/pages/discounts/editDiscount.dart';
import 'package:mobile_wash_control/mobile/pages/home.dart';
import 'package:mobile_wash_control/mobile/pages/motors.dart';
import 'package:mobile_wash_control/mobile/pages/overview.dart';
import 'package:mobile_wash_control/mobile/pages/overview/managePost.dart';
import 'package:mobile_wash_control/mobile/pages/overview/postInkassHistory.dart';
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
import 'package:flutter_localizations/flutter_localizations.dart';

import '../mobile/pages/bonus_status.dart';
import '../mobile/pages/organizations.dart';
import '../mobile/pages/sbp_status.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.unknown,
        },
      ),
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
        "/mobile/home/bonus-status": (context) => BonusStatusPage(),
        "/mobile/home/sbp-status": (context) => SbpStatusPage(),
        "/mobile/home/managePost": (context) => ManagePostPage(),
        "/mobile/home/incassation-history": (context) => IncassationHistoryPage(),
        "/mobile/programs": (context) => ProgramsPage(),
        "/mobile/programs/edit": (context) => EditProgramPage(),
        "/mobile/settings": (context) => SettingsPage(),
        "/mobile/settings/post": (context) => StationPage(),
        "/mobile/settings/kasse": (context) => KassePage(),
        "/mobile/settings/default": (context) => PresetsPage(),
        "/mobile/services": (context) => SettingsServicesPage(),
        "/mobile/services/organizations": (context) => OrganizationsView(),
        "/mobile/services/groups": (context) => CurrentOrganizationView(),
        "/mobile/services/current-organization/current-group": (context) => CurrentGroupView(),
        "/mobile/services-auth": (context) => SettingsServicesRegistrationPage(),
        "/mobile/statistics": (context) => StatisticsPage(),
        "/mobile/motors": (context) => MotorPage(),
        "/mobile/users": (context) => UsersPage(),
        "/mobile/users/edit": (context) => UserEditPage(),
        "/mobile/discounts": (context) => DiscountsPage(),
        "/mobile/discounts/edit": (context) => EditDiscountPage(),
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [const Locale('en'), const Locale('ru')],
    );
  }
}
