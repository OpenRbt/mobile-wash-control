import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum Pages { Main, Posts, Programs, Dozatrons, Settings, Accounts, Statistics }

//TODO: bottom and top padding for menu items (stretch ListView?), scale menu items to fit menu
Widget prepareDrawer(BuildContext context, Pages selectedPage) {
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
  var styles = new List.filled(texts.length, TextStyle(fontSize: 30));
  styles[selectedPage.index] =
      TextStyle(fontSize: 40, fontWeight: FontWeight.bold);

  var textElements = [];
  for (int i = 0; i < texts.length; i++) {
    textElements.add(Text(texts[i], style: styles[i]));
  }

  var screenWidth = MediaQuery.of(context).size.width;
  var screenHeight = MediaQuery.of(context).size.height;
  //var safeTopPadding = MediaQuery.of(context).padding.top; //statusbar height
  //var safeBottomPadding = MediaQuery.of(context).padding.top; //buttons? height

  return SafeArea(
      //minimum: const EdgeInsets.all(16.0), TODO: check if needed on devices with different designs
      child: FittedBox(

          child: Container(
              width: screenWidth * 3 / 4,
              height: screenHeight,
              child: CustomPaint(
                  painter: MyPainter(context),
                  child: ListTileTheme(
                        //tileColor: Colors.green,
                        child: ListView.separated(
                          itemCount: 8,
                          //clipBehavior: Clip.antiAliasWithSaveLayer,
                          itemBuilder: (BuildContext context, int index) {
                            var onTap =
                                index == 7 // TODO: onTap for each button
                                    ? () {
                                        //Navigator.pushNamed(context, "/");
                                        Navigator.of(context).pop();
                                        Navigator.pop(context);
                                      }
                                    : null;
                            return ListTile(
                                title: textElements[index], onTap: onTap);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: screenHeight / 32,
                            );
                          },

                        ),
                      )))));
}

class MyPainter extends CustomPainter {
  MyPainter(this.context) : super();
  BuildContext context;

  @override
  void paint(Canvas canvas, Size size) {
    size = size.width < size.height ? size : Size(size.height * 3 / 4, size.width);
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