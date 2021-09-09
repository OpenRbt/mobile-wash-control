import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';

class AdvertisingCampagins extends StatefulWidget {
  @override
  _AdvertisingCampaginsState createState() => _AdvertisingCampaginsState();
}

class _AdvertisingCampaginsState extends State<AdvertisingCampagins> {
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

  ScrollController _scrollController;

  void initState() {
    _scrollController = new ScrollController();
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;

    if (_firstLoad) {
      _loadAdvertisting(sessionData);
      _firstLoad = false;
    }

    final AppBar appBar = AppBar(
      title: Text("Управление скидками"),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.filter_alt),
        )
      ],
    );

    double screenH = MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar,
      drawer: prepareDrawer(context, Pages.Advertisting, sessionData),
      body: Container(
        width: screenW,
        height: screenH,
        child: RawScrollbar(
          controller: _scrollController,
          //isAlwaysShown: true,
          thumbColor: Colors.greenAccent,
          child: ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.zero,
            itemCount: fakeData.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == fakeData.length) {
                return _GetCreateAdvertistingCampaginCard(sessionData, height: 150, width: screenW);
              }
              return _GetAdvertistingCampaginCard(sessionData, index, height: 150, width: screenW);
            },
          ),
        ),
      ),
    );
  }

  Widget _GetCreateAdvertistingCampaginCard(SessionData sessionData, {double height, double width}) {
    return Container(
      width: width,
      padding: EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 2.5),
          ],
          color: Colors.white70,
        ),
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black45)],
                color: Colors.white70,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "Новая скидочная компания",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.horizontal(left: Radius.elliptical(5, 25)),
                      color: Colors.green,
                    ),
                    child: Center(
                      child: Text(
                        "%",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.date_range),
                          Divider(
                            indent: 10,
                            endIndent: 10,
                          ),
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
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.timelapse),
                          Divider(
                            indent: 10,
                            endIndent: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "С:",
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
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.horizontal(left: Radius.elliptical(5, 25)),
                      color: Colors.black12,
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/mobile/advertisings/create", arguments: sessionData);
                      },
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _GetAdvertistingCampaginCard(SessionData sessionData, int index, {double height, double width}) {
    return Container(
      width: width,
      padding: EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 2.5),
          ],
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black45)],
                color: Colors.white70,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        fakeData[index].name ?? "",
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.horizontal(left: Radius.elliptical(5, 25)),
                      color: fakeData[index].enabled ? Colors.green : Colors.red,
                    ),
                    child: Center(
                      child: Text(
                        "${fakeData[index].defaultDiscount ?? "0"} %",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.date_range),
                          Divider(
                            indent: 10,
                            endIndent: 10,
                          ),
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
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.timelapse),
                          Divider(
                            indent: 10,
                            endIndent: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "С:",
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
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.horizontal(left: Radius.elliptical(5, 25)),
                      color: Colors.black12,
                    ),
                    child: MaterialButton(
                      onPressed: () {},
                      child: Icon(Icons.settings),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
