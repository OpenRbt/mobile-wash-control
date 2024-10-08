import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
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
import 'package:mobile_wash_control/mobile/pages/settings.dart';
import 'package:mobile_wash_control/mobile/pages/settings/kasse.dart';
import 'package:mobile_wash_control/mobile/pages/settings/presets.dart';
import 'package:mobile_wash_control/mobile/pages/settings/station.dart';
import 'package:mobile_wash_control/mobile/pages/statistics.dart';
import 'package:mobile_wash_control/mobile/pages/users.dart';
import 'package:mobile_wash_control/mobile/pages/users/editUser.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../mobile/pages/bonus_status.dart';
import '../mobile/pages/sbp_status.dart';
import '../mobile/pages/script_station.dart';
import '../mobile/pages/scripts_page.dart';

//BLoC architecture pages
import 'package:mobile_wash_control/presentation/pages/services_page.dart';
import 'package:mobile_wash_control/presentation/pages/tasks_page.dart';
import 'package:mobile_wash_control/presentation/pages/updates_station_page.dart';
import 'package:mobile_wash_control/presentation/pages/updates_page.dart';


class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
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

        "/mobile/services-auth": (context) => SettingsServicesRegistrationPage(),
        "/mobile/statistics": (context) => StatisticsPage(),
        "/mobile/motors": (context) => MotorPage(),
        "/mobile/users": (context) => UsersPage(),
        "/mobile/users/edit": (context) => UserEditPage(),
        "/mobile/discounts": (context) => DiscountsPage(),
        "/mobile/discounts/edit": (context) => EditDiscountPage(),

        "/mobile/scripts": (context) => ScriptsPage(),
        "/mobile/scripts/post": (context) => ScriptStationPage(),

        //BLoC architecture pages
        "/mobile/services": (context) => ServicesPage(),

        "/mobile/updates": (context) => UpdatesPage(),
        "/mobile/updates/post": (context) => UpdatesStationPage(),
        
        "/mobile/tasks": (context) => TasksPage(),


      },
    );
  }
}
