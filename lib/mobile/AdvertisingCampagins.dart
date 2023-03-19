import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';
import 'package:mobile_wash_control/mobile/AdvertisingCampaginsEdit.dart';

class AdvertisingCampagins extends StatefulWidget {
  @override
  _AdvertisingCampaginsState createState() => _AdvertisingCampaginsState();
}

class _AdvertisingCampaginsState extends State<AdvertisingCampagins> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  //Helpers
  DateFormat _dateFormat;
  //
  bool _showByDates = false;
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(Duration(days: 1)),
  );
  bool _hideCompleted = false;
  bool _sortByEndDate = false;

  List<String> Days = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"];
  bool _firstLoad = true;

  List<AdvertisingCampaign> adCampagins = List();

  void _loadAdvertisting(SessionData sessionData) async {
    try {
      var args = ArgAdvertisingCampagin();
      if (_showByDates) {
        args.startDate = dateRange.start.millisecondsSinceEpoch ~/ 1000;
        args.endDate = dateRange.end.millisecondsSinceEpoch ~/ 1000;
      }
      adCampagins = await sessionData.client.advertisingCampaign(args: args);
      adCampagins.sort((a, b) => a.id.compareTo(b.id));

      if (_hideCompleted) {
        var now = DateTime.now().add(Duration(days: 1)).millisecondsSinceEpoch;
        adCampagins = adCampagins.where((e) => (e.endDate ?? 0) * 1000 < now).toList();
      }
      if (_sortByEndDate) {
        adCampagins.sort((a, b) => a.endDate.compareTo(b.endDate));
      }
    } catch (e) {
      print(e);
    }
    setState(() {});
  }

  ScrollController _scrollController;

  void initState() {
    _dateFormat = new DateFormat("dd.MM.yyyy");
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
      title: Text(
        "Управление скидками",
        maxLines: 2,
      ),
      actions: [
        IconButton(
          onPressed: () {
            _loadAdvertisting(sessionData);
          },
          icon: Icon(Icons.refresh),
        ),
        IconButton(
          onPressed: () async {
            await _showFilterDialog();
            _loadAdvertisting(sessionData);
          },
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
            physics: ClampingScrollPhysics(),
            controller: _scrollController,
            padding: EdgeInsets.zero,
            itemCount: adCampagins.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == adCampagins.length) {
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
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(7, (index) {
                  return Text(
                    Days[index],
                  );
                }),
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
                        Navigator.pushNamed(context, "/mobile/advertisings/create", arguments: sessionData).then((value) => _loadAdvertisting(sessionData));
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
                        adCampagins[index].name ?? "",
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.horizontal(left: Radius.elliptical(5, 25)),
                      color: (adCampagins[index].enabled ?? false) ? Colors.green : Colors.red,
                    ),
                    child: Center(
                      child: Text(
                        "${adCampagins[index].defaultDiscount ?? 0} %",
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
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(7, (i) {
                  bool activeDay = false;
                  switch (i) {
                    case 0:
                      {
                        activeDay = adCampagins[index].weekday.contains(AdvertisingCampaignWeekdayEnum.monday);
                        break;
                      }
                    case 1:
                      {
                        activeDay = adCampagins[index].weekday.contains(AdvertisingCampaignWeekdayEnum.tuesday);
                        break;
                      }
                    case 2:
                      {
                        activeDay = adCampagins[index].weekday.contains(AdvertisingCampaignWeekdayEnum.wednesday);
                        break;
                      }
                    case 3:
                      {
                        activeDay = adCampagins[index].weekday.contains(AdvertisingCampaignWeekdayEnum.thursday);
                        break;
                      }
                    case 4:
                      {
                        activeDay = adCampagins[index].weekday.contains(AdvertisingCampaignWeekdayEnum.friday);
                        break;
                      }
                    case 5:
                      {
                        activeDay = adCampagins[index].weekday.contains(AdvertisingCampaignWeekdayEnum.saturday);
                        break;
                      }
                    case 6:
                      {
                        activeDay = adCampagins[index].weekday.contains(AdvertisingCampaignWeekdayEnum.sunday);
                        break;
                      }
                  }
                  return Text(
                    Days[i],
                    style: TextStyle(color: activeDay ? Colors.green : Colors.red),
                  );
                }),
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
                                _dateFormat.format(DateTime.fromMillisecondsSinceEpoch((adCampagins[index].startDate ?? 0) * 1000, isUtc: true)),
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
                                _dateFormat.format(DateTime.fromMillisecondsSinceEpoch((adCampagins[index].endDate ?? 0) * 1000, isUtc: true)),
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
                                TimeOfDay(
                                  hour: (adCampagins[index].startMinute ?? 0) ~/ 60,
                                  minute: (adCampagins[index].startMinute ?? 0) % 60,
                                ).format(context),
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
                                TimeOfDay(
                                  hour: (adCampagins[index].endMinute ?? 0) ~/ 60,
                                  minute: (adCampagins[index].endMinute ?? 0) % 60,
                                ).format(context),
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        height: 50,
                        width: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(left: Radius.elliptical(5, 25)),
                          color: Colors.black12,
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            AdvertisingCampaginsEditArgs args = AdvertisingCampaginsEditArgs(sessionData, adCampagins[index]);
                            Navigator.pushNamed(context, "/mobile/advertisings/edit", arguments: args).then((value) => _loadAdvertisting(sessionData));
                          },
                          child: Icon(Icons.settings),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showFilterDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Параметры отображения"),
              contentPadding: EdgeInsets.only(left: 10, right: 10),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("По датам:"),
                      TextButton(
                        onPressed: () {
                          _showByDates = !_showByDates;
                          setState(() {});
                        },
                        child: Text(
                          _showByDates ? "Да" : "Нет",
                          style: TextStyle(color: _showByDates ? Colors.green : Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Период: "),
                      TextButton(
                        onPressed: () async {
                          var res = await showDateRangePicker(
                            context: context,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2050),
                            initialDateRange: dateRange,
                            initialEntryMode: DatePickerEntryMode.input,
                          );
                          if (res != null) {
                            dateRange = res;
                          }
                        },
                        child: Text("${_dateFormat.format(dateRange.start)} - ${_dateFormat.format(dateRange.end)}"),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("По дате окончания:"),
                      TextButton(
                        onPressed: () {
                          _sortByEndDate = !_sortByEndDate;
                          setState(() {});
                        },
                        child: Text(
                          _sortByEndDate ? "Да" : "Нет",
                          style: TextStyle(color: _sortByEndDate ? Colors.green : Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Скрывать завершенные:"),
                      TextButton(
                        onPressed: () {
                          _hideCompleted = !_hideCompleted;
                          setState(() {});
                        },
                        child: Text(
                          _hideCompleted ? "Да" : "Нет",
                          style: TextStyle(color: _hideCompleted ? Colors.green : Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Закрыть"),
                )
              ],
            );
          },
        );
      },
    );
  }
}
