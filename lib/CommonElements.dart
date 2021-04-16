import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';
import 'package:mobile_wash_control/client/api.dart';

enum Pages { Main, Programs, Settings, Accounts, Statistics, None }

class SessionData {
  final DefaultApi client;

  SessionData(this.client);
}

Widget prepareDrawer(
    BuildContext context, Pages selectedPage, SessionData sessionData) {
  var texts = [
    "Главная",
    "Программы",
    "Настройки",
    "Учетки",
    "Статистика",
    "Выход"
  ];

  var routes = [
    "/mobile/home",
    "/mobile/programs",
    "/mobile/settings",
    "/mobile/accounts",
    "/mobile/statistics",
  ];

  var styles = new List.filled(
    texts.length,
    TextStyle(fontSize: 30),
  );
  styles[selectedPage.index] =
      TextStyle(fontSize: 40, fontWeight: FontWeight.bold);

  var textElements = [];
  for (int i = 0; i < texts.length; i++) {
    textElements.add(
      Text(texts[i], style: styles[i]),
    );
  }

  var screenWidth = MediaQuery.of(context).size.width;
  var screenHeight = MediaQuery.of(context).size.height;
  var isPortrait = screenWidth < screenHeight;

  return SafeArea(
    minimum: const EdgeInsets.only(top: 8.0, bottom: 8.0),
    child: ScrollConfiguration(
      behavior: MyScrollingBehavior(),
      child: FittedBox(
        child: Container(
          width: screenWidth *
              3 /
              4 *
              (isPortrait ? 1 : screenHeight / screenWidth),
          height: screenHeight,
          child: CustomPaint(
            painter: MyPainter(context),
            child: ListTileTheme(
              style: ListTileStyle.drawer,
              child: Flex(direction: Axis.horizontal, children: [
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: texts.length,
                    itemBuilder: (BuildContext context, int index) {
                      var onTap = index == texts.length - 1
                          ? () {
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
                            }
                          : () {
                              Navigator.pop(context); //Closing Drawer
                              Navigator.pushReplacementNamed(
                                  Navigator.of(context).context, routes[index],
                                  arguments: sessionData);
                            };
                      return ListTile(title: textElements[index], onTap: onTap);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: screenHeight / (isPortrait ? 12 : 24),
                      );
                    },
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    ),
  );
}

class MyPainter extends CustomPainter {
  MyPainter(this.context) : super();
  BuildContext context;

  @override
  void paint(Canvas canvas, Size size) {
    size = size.width < size.height
        ? size
        : Size(size.height * 3 / 4, size.width * 3 / 4);
    final sizeB = Size(size.width * 2, size.height + size.height * 0.5);
    var rect = Offset(-size.width, -size.height * 0.25) & sizeB;
    canvas.drawOval(rect, Paint()..color = Colors.white);
    canvas.drawOval(
        rect,
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class MyScrollingBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

void showErrorDialog(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Ошибка"),
      content: Text(text),
      actionsPadding: EdgeInsets.all(10),
      actions: [
        RaisedButton(
          color: Colors.lightGreen,
          textColor: Colors.white,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Ок"),
        )
      ],
    ),
  );
}

class ValueWrapper {
  var value;
  ValueWrapper(this.value);
}

void showInfoSnackBar(GlobalKey<ScaffoldState> scaffoldKey,
    ValueWrapper isSnackBarActive, String text, Color color) async {
  if (isSnackBarActive.value) {
    return;
  }
  if (scaffoldKey.currentState == null) {
    await Future.delayed(
      Duration(milliseconds: 200),
    );
    if (scaffoldKey.currentState == null) return;
  }
  isSnackBarActive.value = true;
  scaffoldKey.currentState
      .showSnackBar(
        SnackBar(
          content: Text(
            text ?? ('Успешно выполнено'),
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: color ?? Colors.grey,
          duration: Duration(seconds: 2),
        ),
      )
      .closed
      .then((SnackBarClosedReason reason) {
    isSnackBarActive.value = false;
  }).timeout(Duration(seconds: 4), onTimeout: () {
    isSnackBarActive.value = false;
  });
}

class DefaultConfig {
  static final Map<String, StationsDefaultConfig> configs = {
    "Wash": StationsDefaultConfig([
      _getProgram(1, "wsh-water", 25, false, 100, 100, [
        _getRelay(1, 1000, 0),
        _getRelay(6, 1000, 0),
      ], []),
      _getProgram(2, "wsh-foam", 25, false, 100, 100, [
        _getRelay(1, 1000, 0),
        _getRelay(2, 278, 722), //0.3857 | 278 722
        _getRelay(6, 1000, 0)
      ], []),
      _getProgram(3, "wsh-foam active", 25, false, 100, 100, [
        _getRelay(1, 1000, 0),
        _getRelay(2, 500, 500),
        _getRelay(6, 1000, 0)
      ], []),
      _getProgram(4, "wsh-wax", 25, false, 100, 100, [
        _getRelay(1, 1000, 0),
        _getRelay(4, 284, 716),
        _getRelay(6, 1000, 0),
      ], []),
      _getProgram(5, "wsh-osmosian", 25, false, 100, 100, [
        _getRelay(5, 1000, 0),
        _getRelay(6, 1000, 0),
      ], []),
      _getProgram(6, "wsh-pause", 25, false, 100, 100, [
        _getRelay(6, 1000, 0),
      ], []),
    ], [
      _getProgramButton(1, 1),
      _getProgramButton(2, 2),
      _getProgramButton(3, 3),
      _getProgramButton(4, 4),
      _getProgramButton(5, 5),
      _getProgramButton(6, 6),
    ]),
    "Sensor Screen": StationsDefaultConfig([
      _getProgram(51, "qzr-foam", 25, false, 100, 100, [
        _getRelay(1, 500, 500),
        _getRelay(6, 1000, 0),
        _getRelay(12, 1000, 0),
        _getRelay(14, 1000, 0),
      ], []),
      _getProgram(52, "qzr-shampoo", 25, false, 100, 100, [
        _getRelay(1, 667, 333),
        _getRelay(5, 1000, 0),
        _getRelay(12, 1000, 0),
        _getRelay(14, 1000, 0),
      ], []),
      _getProgram(53, "qzr-water", 25, false, 100, 100, [
        _getRelay(1, 750, 250),
        _getRelay(11, 1000, 0),
        _getRelay(14, 1000, 0),
      ], []),
      _getProgram(54, "qzr-wax", 25, false, 100, 100, [
        _getRelay(1, 800, 200),
        _getRelay(4, 1000, 0),
        _getRelay(12, 1000, 0),
        _getRelay(14, 1000, 0),
      ], []),
      _getProgram(55, "qzr-air", 25, false, 100, 100, [
        _getRelay(14, 1000, 0),
        _getRelay(16, 1000, 0),
      ], []),
      _getProgram(56, "qzr-pause", 25, false, 100, 100, [
        _getRelay(6, 1000, 0),
        _getRelay(14, 1000, 0),
      ], []),
      _getProgram(57, "qzr-openlid", 25, false, 100, 100, [
        _getRelay(2, 1000, 0),
        _getRelay(6, 1000, 0),
        _getRelay(14, 1000, 0),
      ], []),
    ], [
      _getProgramButton(1, 51),
      _getProgramButton(2, 52),
      _getProgramButton(3, 53),
      _getProgramButton(4, 54),
      _getProgramButton(5, 55),
      _getProgramButton(6, 56),
    ]),
    "Moycar": StationsDefaultConfig([
      _getProgram(101, "robo-express", 25, false, 100, 100, [
        _getRelay(1, 1000, 0),
      ], []),
      _getProgram(102, "robo-daily", 25, false, 100, 100, [
        _getRelay(2, 1000, 0),
      ], []),
      _getProgram(103, "robo-premium", 25, false, 100, 100, [
        _getRelay(3, 1000, 0),
      ], []),
      _getProgram(104, "robo-vacuum cleaner and mats", 25, false, 100, 100, [
        _getRelay(11, 1000, 0),
      ], []),
      _getProgram(105, "robo-interior and wheels", 25, false, 100, 100, [
        _getRelay(12, 1000, 0),
      ], []),
      _getProgram(106, "robo-tire", 25, false, 100, 100, [
        _getRelay(13, 1000, 0),
      ], []),
      _getProgram(107, "robo-disks", 25, false, 100, 100, [
        _getRelay(14, 1000, 0),
      ], []),
      _getProgram(108, "robo-drying", 25, false, 100, 100, [
        _getRelay(15, 1000, 0),
      ], []),
    ], [
      _getProgramButton(1, 101),
      _getProgramButton(2, 102),
      _getProgramButton(3, 103),
      _getProgramButton(4, 104),
      _getProgramButton(5, 105),
      _getProgramButton(6, 106),
      _getProgramButton(7, 107),
      _getProgramButton(8, 108),
    ]),
    "Vacuum": StationsDefaultConfig([
      _getProgram(151, "vcm-vacuum", 25, false, 100, 100, [
        _getRelay(1, 1000, 0),
        _getRelay(2, 1000, 0),
        _getRelay(3, 1000, 0),
        _getRelay(4, 1000, 0),
        _getRelay(5, 1000, 0),
        _getRelay(6, 1000, 0),
      ], []),
      _getProgram(156, "vcm-pause", 25, false, 100, 100, [
        _getRelay(6, 1000, 0),
      ], []),
    ], [
      _getProgramButton(1, 151),
      _getProgramButton(2, 156),
    ]),
  };
}

class StationsDefaultConfig {
  List<Program> programs;
  List<InlineResponse2001Buttons> stationPrograms;
  StationsDefaultConfig(this.programs, this.stationPrograms);
}

Program _getProgram(
    int id,
    String name,
    int price,
    bool preflightEnabled,
    int motorSpeedPercent,
    int preflightMotorSpeedPercent,
    List<RelayConfig> relays,
    List<RelayConfig> preflightRelays) {
  Program tmp = Program();

  tmp.id = id;
  tmp.name = name;
  tmp.price = price;
  tmp.preflightEnabled = preflightEnabled;
  tmp.motorSpeedPercent = motorSpeedPercent;
  tmp.preflightMotorSpeedPercent = preflightMotorSpeedPercent;
  tmp.relays = relays;
  tmp.preflightRelays = preflightRelays;

  return tmp;
}

RelayConfig _getRelay(int id, int timeon, int timeoff) {
  RelayConfig tmp = RelayConfig();

  tmp.id = id;
  tmp.timeon = timeon;
  tmp.timeoff = timeoff;

  return tmp;
}

InlineResponse2001Buttons _getProgramButton(int buttonID, int programID) {
  InlineResponse2001Buttons tmp = InlineResponse2001Buttons();

  tmp.buttonID = buttonID;
  tmp.programID = programID;

  return tmp;
}

final List<String> dPagesNames = [
  "Главная",
  "Программы",
  "Настройки",
  "Учетки",
  "Статистика",
  "Выход"
];
final Map<String, Pages> dPagesMap = {
  "Главная": Pages.Main,
  "Программы": Pages.Programs,
  "Настройки": Pages.Settings,
  "Учетки": Pages.Accounts,
  "Статистика": Pages.Statistics,
  "Выход": Pages.None
};
final Map<Pages, String> dPageRoutes = {
  Pages.Main: "/desktop/home",
  Pages.Programs: "/desktop/programs",
  Pages.Settings: "/desktop/settings",
  Pages.Accounts: "/desktop/accounts",
  Pages.Statistics: "/desktop/statistics",
};

Widget DGetDrawer(double height, double width, BuildContext context,
    Pages _currentPage, SessionData sessionData) {
  return SizedBox(
    height: height,
    width: width,
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black12,
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                dPagesNames[index],
                style: TextStyle(
                  fontSize:
                      _currentPage == dPagesMap[dPagesNames[index]] ? 32 : 16,
                ),
              ),
              onTap: (index < dPagesNames.length - 1)
                  ? () {
                      Navigator.pushReplacementNamed(
                          context, dPageRoutes[dPagesMap[dPagesNames[index]]],
                          arguments: sessionData);
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
              height: height / 24,
            );
          },
          itemCount: dPagesNames.length),
    ),
  );
}
