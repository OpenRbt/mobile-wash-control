import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';
import 'client/api.dart';
import 'package:flutter/services.dart';

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
    "/home",
    "/home/programs",
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
                                //clipBehavior: Clip.antiAlias,
                                itemBuilder: (BuildContext context, int index) {
                                  var onTap = index == texts.length - 1
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
                                          Navigator.of(context)
                                              .pop(); //Closing current screen
                                          Navigator.pop(
                                              context); //Closing Drawer
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
                                    height:
                                        screenHeight / (isPortrait ? 12 : 24),
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

Widget buildForm(
    {TextStyle style,
    TextInputType keyboardType,
    List<TextInputFormatter> inputFormatters,
    InputDecoration decoration,
    TextEditingController controller,
    String Function(String) validator,
    @required Future<String> Function(String) onSubmitted}) {
  return Builder(builder: (BuildContext context) {
    return TextField(
        style: style ?? null,
        keyboardType: keyboardType ?? null,
        inputFormatters: inputFormatters ?? null,
        decoration: decoration ?? null,
        controller: controller ?? null,
        onSubmitted: (newValue) async {
          var valid = validator == null ? null : validator(newValue);
          if (valid == null) {
            var err = await onSubmitted(newValue);
            if (err == null)
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('Обработка данных...')));
            else
              showErrorDialog(context, err);
          } else
            showErrorDialog(context, valid);
        });
  });
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
          ));
}
