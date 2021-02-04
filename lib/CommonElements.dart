import 'package:flutter/material.dart';

enum Pages { Main, Posts, Programs, Dozatrons, Settings, Accounts, Statistics }

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
      TextStyle(fontSize: 50, fontWeight: FontWeight.bold);

  var textElements = [];
  for (int i = 0; i < texts.length; i++) {
    textElements.add(Text(texts[i], style: styles[i]));
  }

  var screenWidth = MediaQuery.of(context).size.width;
  var screenHeight = MediaQuery.of(context).size.height;

  return SafeArea(
      child: Container(
          width: screenWidth * 3 / 4,
          height: screenHeight,
          decoration: BoxDecoration(
              color: Colors.white,
              //backgroundBlendMode: BlendMode.clear,
              border: Border.all(),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(200),
                  bottomRight: Radius.circular(200))),
          child: ListTileTheme(
            //tileColor: Colors.green,
            child: ListView.separated(

              itemCount: 8,
              itemBuilder: (BuildContext context, int index) {
                var onTap = index == 7 // TODO: onTap for each button
                    ? () {
                        //Navigator.pushNamed(context, "/");
                        Navigator.of(context).pop();
                        Navigator.pop(context);
                      }
                    : null;
                return ListTile(title: textElements[index], onTap: onTap);
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 10,
                );
              },
              padding: EdgeInsets.only(top: screenWidth / 7, bottom: screenWidth / 7),
            ),
          )));
}