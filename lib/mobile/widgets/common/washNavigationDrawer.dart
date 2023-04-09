import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_wash_control/SharedData.dart';

enum SelectedPage { Main, Programs, Advertisting, Settings, Accounts, Services, Statistics, Motors, Exit, None }

class WashNavigationDrawer extends StatelessWidget {
  final SelectedPage _selected;

  final _destinations = <NavigationDrawerDestination>[
    NavigationDrawerDestination(icon: Icon(Icons.home_outlined), label: Text("Главная")),
    NavigationDrawerDestination(icon: Icon(Icons.schema_outlined), label: Text("Программы")),
    NavigationDrawerDestination(icon: Icon(Icons.discount_outlined), label: Text("Управление скидками")),
    NavigationDrawerDestination(icon: Icon(Icons.settings_outlined), label: Text("Настройки")),
    NavigationDrawerDestination(icon: Icon(Icons.people_outline), label: Text("Учетки")),
    NavigationDrawerDestination(icon: Icon(Icons.power_outlined), label: Text("Сервисы")),
    NavigationDrawerDestination(icon: Icon(Icons.show_chart_outlined), label: Text("Статистика")),
    NavigationDrawerDestination(icon: Icon(Icons.table_chart_outlined), label: Text("Моторесурс")),
    NavigationDrawerDestination(icon: Icon(Icons.exit_to_app_outlined), label: Text("Выход")),
  ];
  final routes = <String>[
    "/mobile/home",
    "/mobile/programs",
    "/mobile/advertisings",
    "/mobile/settings",
    "/mobile/accounts",
    "/mobile/services-auth",
    "/mobile/statistics",
    "/mobile/motors",
  ];

  WashNavigationDrawer({super.key, required SelectedPage selected}) : _selected = selected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return NavigationDrawer(
      children: _destinations,
      selectedIndex: _selected.index,
      onDestinationSelected: (int index) {
        if (index == SelectedPage.Exit.index) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Выход"),
              content: Text("Выйти из приложения?"),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    exit(0);
                  },
                  child: Text("Да"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Нет"),
                )
              ],
            ),
          );
        } else {
          if (routes[index] != routes[0]) {
            SharedData.CanUpdateStatus = false;
          } else {
            SharedData.CanUpdateStatus = true;
          }
          Navigator.pop(context); //Closing Drawer
          Navigator.pushReplacementNamed(Navigator.of(context).context, routes[index], arguments: SharedData.sessionData!);
        }
      },
    );
  }
}
