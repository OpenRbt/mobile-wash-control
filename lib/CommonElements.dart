import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';
import 'client/api.dart';

enum Pages { Main, Programs, Settings, Accounts, Statistics }

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
    "/mobile/home/programs",
    "/mobile/home/settings",
    "/mobile/home/accounts",
    "/mobile/home/statistics",
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

void showInfoSnackBar(
GlobalKey<ScaffoldState> scaffoldKey, ValueWrapper isSnackBarActive,
String text, Color color) async{
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