import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/repository/repository.dart';

enum SelectedPage { Main, Programs, Discounts, Settings, Accounts, Services, Statistics, Motors, Exit, None }

class WashNavigationDrawer extends StatelessWidget {
  final SelectedPage _selected;
  final Repository _repository;

  final _destinations = <NavigationDrawerDestination>[
    NavigationDrawerDestination(icon: Icon(Icons.home_outlined), label: Text("Главная")),
    NavigationDrawerDestination(icon: Icon(Icons.schema_outlined), label: Text("Программы")),
    NavigationDrawerDestination(icon: Icon(Icons.discount_outlined), label: Text("Управление скидками")),
    NavigationDrawerDestination(icon: Icon(Icons.settings_outlined), label: Text("Настройки")),
    NavigationDrawerDestination(icon: Icon(Icons.people_outline), label: Text("Пользователи")),
    NavigationDrawerDestination(icon: Icon(Icons.power_outlined), label: Text("Сервисы")),
    NavigationDrawerDestination(icon: Icon(Icons.show_chart_outlined), label: Text("Статистика")),
    NavigationDrawerDestination(icon: Icon(Icons.table_chart_outlined), label: Text("Моторесурс")),
    NavigationDrawerDestination(icon: Icon(Icons.exit_to_app_outlined), label: Text("Выход")),
  ];

  final routes = <String>[
    "/mobile/home",
    "/mobile/programs",
    "/mobile/discounts",
    "/mobile/settings",
    "/mobile/users",
    "/mobile/services-auth",
    "/mobile/statistics",
    "/mobile/motors",
  ];

  WashNavigationDrawer({super.key, required SelectedPage selected, required Repository repository})
      : _selected = selected,
        _repository = repository;

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
          Navigator.pop(context); //Closing Drawer

          if (index != _selected.index) {
            var args = Map<PageArgCode, dynamic>();
            args[PageArgCode.repository] = _repository;
            Navigator.pushReplacementNamed(Navigator.of(context).context, routes[index], arguments: args);
          }
        }
      },
    );
  }
}
