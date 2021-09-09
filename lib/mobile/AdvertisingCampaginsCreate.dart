import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';

class AdvertisingCampaginsCreate extends StatefulWidget {
  @override
  _AdvertisingCampaginsCreateState createState() => _AdvertisingCampaginsCreateState();
}

class _AdvertisingCampaginsCreateState extends State<AdvertisingCampaginsCreate> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);

  List<AdvertisingCampaign> adCampagins = List();
  bool _firstLoad = true;

  void _loadAdvertisting(SessionData sessionData) async {
    try {
      var args = ArgAdvertisingCampagin();
      adCampagins = await sessionData.client.advertisingCampaign(args: args);
    } catch (e) {
      print(e);
    }
    setState(() {});
  }

  List<AdvertisingCampaign> fakeData = List.generate(10, (index) {
    return AdvertisingCampaign(
      id: index + 1,
      name: "Advertisting Campagin ${index + 1}",
      enabled: true,
      defaultDiscount: 10,
      weekday: [AdvertisingCampaignWeekdayEnum.monday, AdvertisingCampaignWeekdayEnum.friday],
    );
  });

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;

    if (_firstLoad) {
      _loadAdvertisting(sessionData);
      _firstLoad = false;
    }

    final AppBar appBar = AppBar(
      title: Text("Управление скидками"),
    );

    double screenH = MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar,
      body: Container(
        width: screenW,
        height: screenH,
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Text(
                        "Название",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow()],
                        color: Colors.white,
                      ),
                      child: TextButton(
                        child: Text(
                          "Новая скидочная кампания",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Text(
                        "Скидка",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow()],
                        color: Colors.white,
                      ),
                      child: TextButton(
                        child: Text(
                          "000 %",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Icon(Icons.date_range),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow()],
                        color: Colors.white,
                      ),
                      child: MaterialButton(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "С: ",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "__.__.____",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "По: ",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "__.__.____",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Icon(Icons.timelapse),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow()],
                        color: Colors.white,
                      ),
                      child: MaterialButton(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "С: ",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "__:__",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "По: ",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "__:__",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Text(
                        "Дни",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow()],
                        color: Colors.white,
                      ),
                      child: MaterialButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Пн",
                              style: TextStyle(color: Colors.green),
                            ),
                            Text(
                              "Вт",
                              style: TextStyle(color: Colors.green),
                            ),
                            Text(
                              "Ср",
                              style: TextStyle(color: Colors.green),
                            ),
                            Text(
                              "Чт",
                              style: TextStyle(color: Colors.green),
                            ),
                            Text(
                              "Пт",
                              style: TextStyle(color: Colors.green),
                            ),
                            Text(
                              "Сб",
                              style: TextStyle(color: Colors.green),
                            ),
                            Text(
                              "Вс",
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Text(
                        "Скидки по программам",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow()],
                        color: Colors.white,
                      ),
                      child: TextButton(
                        child: Text(
                          "0 шт",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 50,
                          width: screenW / 3,
                          decoration: BoxDecoration(
                            boxShadow: [BoxShadow(color: Colors.green, blurRadius: 1)],
                            color: Colors.lightGreen,
                          ),
                          child: MaterialButton(
                            onPressed: () {},
                            child: Text(
                              "Сохранить",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: screenW / 3,
                          decoration: BoxDecoration(
                            boxShadow: [BoxShadow(color: Colors.green, blurRadius: 1)],
                            color: Colors.red,
                          ),
                          child: MaterialButton(
                            onPressed: () {},
                            child: Text(
                              "Очистить",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
