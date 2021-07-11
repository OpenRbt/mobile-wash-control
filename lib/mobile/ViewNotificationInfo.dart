import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_wash_control/client/api.dart';

class ViewNotificationInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final StationEvent event = ModalRoute.of(context).settings.arguments as StationEvent;

    Color eventColor = (event.status ?? "") == "ERROR" ? Colors.deepOrange : Colors.red;
    DateTime eventDate = DateTime.fromMicrosecondsSinceEpoch((event.ctime ?? 0) * 1000);

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;

    final appBar = AppBar(
      title: Text(
        "Просмотр события",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: eventColor,
      foregroundColor: Colors.white,
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        height: screenH,
        width: screenW,
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  height: 50,
                  width: screenW / 3,
                  child: Text(
                    "ID Поста:",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  height: 50,
                  width: screenW / 2,
                  child: Text(
                    "${event.stationID ?? 0}",
                    style: TextStyle(fontSize: 24),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  height: 50,
                  width: screenW / 3,
                  child: Text(
                    "Модуль:",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  height: 50,
                  width: screenW / 2,
                  child: Text(
                    event.module ?? "НЕИЗВЕСТЕН",
                    style: TextStyle(fontSize: 24),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  height: 50,
                  width: screenW / 3,
                  child: Text(
                    "Статус:",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  height: 50,
                  width: screenW / 2,
                  child: Text(
                    event.status ?? "НЕИЗВЕСТЕН",
                    style: TextStyle(fontSize: 24, color: eventColor),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  height: 50,
                  width: screenW / 3,
                  child: Text(
                    "Дата:",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  height: 50,
                  width: screenW / 2,
                  child: Text(
                    DateFormat('dd.MM.yyyy HH:mm:ss').format(eventDate),
                    style: TextStyle(
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
            Divider(
              thickness: 3,
            ),
            Container(
              height: 50,
              width: screenW,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: screenW / 2,
                    child: Text(
                      "Информация",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: screenW,
              child: Text(
                event.info ?? "Нет информации о событии",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
                overflow: TextOverflow.visible,
              ),
            ),
            Divider(
              thickness: 3,
            ),
          ],
        ),
      ),
    );
  }
}
