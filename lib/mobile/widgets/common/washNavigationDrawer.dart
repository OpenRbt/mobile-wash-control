import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/repository/repository.dart';

import '../../../Common/bonus_common.dart';
import '../../../generated/locale_keys.g.dart';

enum SelectedPage {
  Main,
  Programs,
  Discounts,
  Settings,
  Accounts,
  Services,
  Statistics,
  Motors,
  Scripts,
  Updates,
  Tasks,
  Exit,
  None;

  String getLabel() {
    switch (this) {
      case SelectedPage.Main:
        return 'main'.tr();
      case SelectedPage.Programs:
        return 'programs'.tr();
      case SelectedPage.Discounts:
        return 'discounts_management'.tr();
      case SelectedPage.Settings:
        return 'settings'.tr();
      case SelectedPage.Accounts:
        return 'users'.tr();
      case SelectedPage.Services:
        return 'services'.tr();
      case SelectedPage.Statistics:
        return 'statistics'.tr();
      case SelectedPage.Motors:
        return 'motor_life'.tr();
      case SelectedPage.Scripts:
        return 'scripts'.tr();
      case SelectedPage.Updates:
        return 'updates'.tr();
      case SelectedPage.Tasks:
        return 'updates_tasks'.tr();
      case SelectedPage.Exit:
        return 'exit'.tr();
      case SelectedPage.None:
        return "";
    }
  }

  IconData getIcon() {
    switch (this) {
      case SelectedPage.Main:
        return Icons.home_outlined;
      case SelectedPage.Programs:
        return Icons.schema_outlined;
      case SelectedPage.Discounts:
        return Icons.discount_outlined;
      case SelectedPage.Settings:
        return Icons.settings_outlined;
      case SelectedPage.Accounts:
        return Icons.people_outline;
      case SelectedPage.Services:
        return Icons.power_outlined;
      case SelectedPage.Statistics:
        return Icons.show_chart_outlined;
      case SelectedPage.Motors:
        return Icons.table_chart_outlined;
      case SelectedPage.Scripts:
        return Icons.description_outlined;
      case SelectedPage.Updates:
        return Icons.download_outlined;
      case SelectedPage.Tasks:
        return Icons.task_outlined;
      case SelectedPage.Exit:
        return Icons.exit_to_app_outlined;
      default:
        return Icons.error_outline;
    }
  }

  String getRoute() {
    switch (this) {
      case SelectedPage.Main:
        return "/mobile/home";
      case SelectedPage.Programs:
        return "/mobile/programs";
      case SelectedPage.Discounts:
        return "/mobile/discounts";
      case SelectedPage.Settings:
        return "/mobile/settings";
      case SelectedPage.Accounts:
        return "/mobile/users";
      case SelectedPage.Services:
        return "/mobile/services-auth";
      case SelectedPage.Statistics:
        return "/mobile/statistics";
      case SelectedPage.Motors:
        return "/mobile/motors";
      case SelectedPage.Scripts:
        return "/mobile/scripts";
      case SelectedPage.Updates:
        return "/mobile/updates";
      case SelectedPage.Tasks:
        return "/mobile/tasks";
      case SelectedPage.Exit:
        return "";
      default:
        return "";
    }
  }
}

class WashNavigationDrawer extends StatelessWidget {
  final SelectedPage _selected;
  final Repository _repository;

  var _availablePages = [
    SelectedPage.Main,
    SelectedPage.Programs,
    SelectedPage.Settings,
    SelectedPage.Discounts,
    SelectedPage.Accounts,
    SelectedPage.Statistics,
    SelectedPage.Motors,
    SelectedPage.Services,
    SelectedPage.Scripts,
    SelectedPage.Updates,
    SelectedPage.Tasks,
    SelectedPage.Exit,
  ];

  WashNavigationDrawer({super.key, required SelectedPage selected, required Repository repository})
      : _selected = selected,
        _repository = repository {
    final user = repository.currentUser();
    if ((user?.isOperator ?? false)) {
      _availablePages = [SelectedPage.Main, SelectedPage.Exit];
    }
    _repository.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final user = _repository.currentUser();

    final theme = Theme.of(context);

    return Drawer(
      child: ListView(
        shrinkWrap: true,
        children: [
          DrawerHeader(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${'login'.tr()}: ${user?.login ?? ""}",
                  style: theme.textTheme.titleLarge!.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "• ${user?.lastName ?? ""}",
                  style: theme.textTheme.titleLarge!.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "• ${user?.firstName ?? ""} ",
                  style: theme.textTheme.titleLarge!.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "• ${user?.middleName ?? ""}",
                  style: theme.textTheme.titleLarge!.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      color: theme.colorScheme.onPrimary,
                    ),
                    Text(
                      "${(user?.isAdmin ?? false) ? 'admin'.tr() : ""} ${(user?.isOperator ?? false) ? 'operator'.tr() : ""} ${(user?.isEngineer ?? false) ? 'engineer'.tr() : ""}",
                      style: theme.textTheme.titleLarge!.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),

              ],
            ),
            decoration: BoxDecoration(color: theme.colorScheme.primary),
          ),
          (BonusCommon.washServerApi?.apiClient.basePath ?? "").isNotEmpty ?
          Container(
            color: theme.colorScheme.primary,
            child: Text(

              "${'bonus_server_URL'.tr()}: ${BonusCommon.washServerApi?.apiClient.basePath}",
              style: theme.textTheme.titleLarge!.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ): Text(""),
        ]..addAll(
            List.generate(
              _availablePages.length,
              (index) {
                bool current = _availablePages[index] == _selected;

                return ListTile(
                  title: Text(
                    _availablePages[index].getLabel(),
                    style: theme.textTheme.titleLarge!.copyWith(
                      fontWeight: current ? FontWeight.bold : null,
                      color: current ? theme.colorScheme.primary : null,
                    ),
                  ),
                  trailing: Icon(
                    _availablePages[index].getIcon(),
                    color: current ? theme.colorScheme.primary : null,
                  ),
                  onTap: () {
                    if (_availablePages[index] == SelectedPage.Exit) {
                      if (Platform.isAndroid) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('exit'.tr()),
                            content: Text("${'are_you_sure_you_want_to_exit'.tr()}?"),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  exit(0);
                                },
                                child: Text('yes'.tr()),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('no'.tr()),
                              )
                            ],
                          ),
                        );
                      } else {
                        Navigator.of(context).pop();
                        Navigator.pop(context);
                      }
                      return;
                    }

                    if (!current) {
                      var args = Map<PageArgCode, dynamic>();
                      args[PageArgCode.repository] = _repository;
                      Navigator.pushReplacementNamed(Navigator.of(context).context, _availablePages[index].getRoute(), arguments: args);
                    }
                  },
                );
              },
            ),
          ),
      ),
    );
  }
}
