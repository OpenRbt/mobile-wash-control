import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';
import 'client/api.dart';

enum Pages { Main, Posts, Programs, Dozatrons, Settings, Accounts, Statistics }

class SessionData {
  final String pin;
  final DefaultApi client;
  SessionData(this.pin, this.client);
}

Widget prepareDrawer(
    BuildContext context, Pages selectedPage, SessionData sessionData) {
  var texts = [
    "Главная",
    "Посты",
    "Программы",
    "Дозатроны",
    "Настройки",
    "Учетки",
    "Статистика",
    "Выход"
  ];

  var routes = [
    "/home",
    "/home/posts",
    "/home/programs",
    "/home/dozatrons",
    "/home/settings",
    "/home/accounts",
    "/home/statistics",
  ];

  var styles = new List.filled(texts.length, TextStyle(fontSize: 30));
  styles[selectedPage.index] =
      TextStyle(fontSize: 40, fontWeight: FontWeight.bold);

  var textElements = [];
  for (int i = 0; i < texts.length; i++) {
    textElements.add(Text(texts[i], style: styles[i]));
  }

  var screenWidth = MediaQuery.of(context).size.width;
  var screenHeight = MediaQuery.of(context).size.height;
  var isPortrait = screenWidth < screenHeight;

  return SafeArea(
      minimum: const EdgeInsets.only(
          top: 16.0,
          bottom:
              16.0), //TODO: check if actually needed on devices with different designs
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
                                itemCount: 8,
                                //clipBehavior: Clip.antiAlias,
                                itemBuilder: (BuildContext context, int index) {
                                  var onTap = index == 7
                                      ? () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    title: Text("Выход"),
                                                    content: Text(
                                                        "Выйти из приложения?"),
                                                    actionsPadding:
                                                        EdgeInsets.all(10),
                                                    actions: [
                                                      RaisedButton(
                                                        onPressed: () {
                                                          exit(0);
                                                        },
                                                        child: Text("Да"),
                                                      ),
                                                      RaisedButton(
                                                          color:
                                                              Colors.lightGreen,
                                                          textColor:
                                                              Colors.white,
                                                          disabledColor:
                                                              Colors.grey,
                                                          disabledTextColor:
                                                              Colors.black,
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text("Нет"))
                                                    ],
                                                  ));
                                        }
                                      : () {
                                          Navigator.pop(context);
                                          Navigator.pushNamed(
                                              context, routes[index],
                                              arguments: sessionData);
                                        };
                                  return ListTile(
                                      title: textElements[index], onTap: onTap);
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    height: screenHeight / 24,
                                  );
                                },
                              ),
                            )
                          ])))))));
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
