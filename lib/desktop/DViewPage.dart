import 'package:flutter/material.dart';
import 'package:mobile_wash_control/desktop/DHomePage.dart';
import 'package:mobile_wash_control/desktop/DStatisticsPage.dart';
import 'package:mobile_wash_control/mobile/AccountsMenu.dart';
import 'package:mobile_wash_control/mobile/CommonElements.dart';
import 'package:flutter/services.dart';
import 'package:mobile_wash_control/client/api.dart';
import 'package:mobile_wash_control/mobile/ProgramsMenu.dart';
import 'package:mobile_wash_control/mobile/SettingsMenu.dart';
import 'dart:io';

class DViewPage extends StatefulWidget {
  @override
  _DViewPageState createState() => _DViewPageState();
}

class _DViewPageState extends State<DViewPage> {
  Pages _currentPage = Pages.Main;
  final List<String> _pagesNames = [
    "Главная",
    "Программы",
    "Настройки",
    "Учетки",
    "Статистика",
    "Выход"
  ];
  final Map<String, Pages> _pagesMap = {
    "Главная": Pages.Main,
    "Программы": Pages.Programs,
    "Настройки": Pages.Settings,
    "Учетки": Pages.Accounts,
    "Статистика": Pages.Statistics,
    "Выход": Pages.None
  };
  final Map<Pages, Widget> _pagesWidgets = {
    Pages.Main: DHomePage(),
    Pages.Programs: ProgramsMenu(),
    Pages.Settings: SettingsMenu(),
    Pages.Accounts: AccountsMenu(),
    Pages.Statistics: DStatisticsPage(),
    Pages.None: null
  };

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;

    var screenW = MediaQuery.of(context).size.width;
    var screenH = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Row(
      children: [
        SizedBox(
          height: screenH,
          width: screenW > 1280 ? screenW / 4 : 320,
          child: DecoratedBox(
            child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      _pagesNames[index],
                      style: TextStyle(
                        fontSize: _currentPage == _pagesMap[_pagesNames[index]]
                            ? 32
                            : 16,
                      ),
                    ),
                    onTap: (index < _pagesNames.length - 1)
                        ? () {
                            setState(() {
                              _currentPage = _pagesMap[_pagesNames[index]];
                            });
                          }
                        : () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Выход"),
                                content: Text("Выйти из приложения?"),
                                actionsPadding: EdgeInsets.all(10),
                                actions: [
                                  RaisedButton(
                                    onPressed: () {
                                      exit(0);
                                    },
                                    child: Text("Да"),
                                  ),
                                  RaisedButton(
                                    color: Colors.lightGreen,
                                    textColor: Colors.white,
                                    disabledColor: Colors.grey,
                                    disabledTextColor: Colors.black,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Нет"),
                                  )
                                ],
                              ),
                            );
                          },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: screenH / 24,
                  );
                },
                itemCount: _pagesNames.length),
            decoration: BoxDecoration(
              color: Colors.black12,
              border: Border.all(
                color: Colors.lightGreen,
              ),
            ),
          ),
        ),
        SizedBox(
          height: screenH,
          width: screenW > 1280 ? screenW / 4 * 3 : 960,
          child: DecoratedBox(
            child: _pagesWidgets[_currentPage] ?? Center(),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.lightGreen,
              ),
            ),
          ),
        )
      ],
    ));
  }
}
