import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/client/api.dart';

class AdvertisingCampaginsCreate extends StatefulWidget {
  @override
  _AdvertisingCampaginsCreateState createState() => _AdvertisingCampaginsCreateState();
}

class _AdvertisingCampaginsCreateState extends State<AdvertisingCampaginsCreate> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _firstLoad = true;
  bool _canSave = true;
  //Values
  int ProgramDiscountValue;

  int DiscountValue;
  String DiscountTitle;

  List<DiscountProgram> DiscountPrograms;

  DateTimeRange DiscountDateRange;
  TimeOfDay DiscountTimeStart;
  TimeOfDay DiscountTimeEnd;

  bool DiscountActive = true;

  List<String> FullDays = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"];
  List<String> Days = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"];
  List<bool> DaysActive;
  //Helpers
  DateFormat _dateFormat;
  //TextFields
  TextEditingController _titleController;
  TextEditingController _discountController;
  TextEditingController _programDiscountController;

  int _timeZone = 0;
  final List<DropdownMenuItem> _timeZoneValues = List.generate(
    12,
    (index) => DropdownMenuItem(
      child: Center(
        child: Text(
          "UTC+${index}",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      value: index * 60,
    ),
  );

  ScrollController _scrollController;

  void initState() {
    _titleController = new TextEditingController();
    _discountController = new TextEditingController();
    _programDiscountController = new TextEditingController();
    _scrollController = new ScrollController();

    _dateFormat = new DateFormat("dd.MM.yyyy");

    InitValues();
  }

  void InitValues() {
    var now = DateTime.now();
    DiscountTitle = "Новая скидочная кампания";
    DiscountDateRange = DateTimeRange(start: DateTime(now.year, now.month, now.day), end: DateTime(now.year, now.month, now.day).add(Duration(days: 1)));
    DiscountTimeStart = TimeOfDay(hour: 0, minute: 0);
    DiscountTimeEnd = TimeOfDay(hour: 23, minute: 59);
    DiscountValue = 0;

    DiscountPrograms = List();
    _titleController.text = DiscountTitle;
    _discountController.text = "${DiscountValue}";

    DaysActive = List.filled(7, false);
  }

  void dispose() {
    _titleController.dispose();
    _discountController.dispose();
    _scrollController.dispose();
    _programDiscountController.dispose();
    super.dispose();
  }

  void _saveAdvertisingCampagin(SessionData sessionData) async {
    _canSave = false;
    try {
      List<AdvertisingCampaignWeekdayEnum> weekDays = List();
      for (int i = 0; i < 7; i++) {
        switch (i) {
          case 6:
            {
              if (DaysActive[i]) {
                weekDays.add(AdvertisingCampaignWeekdayEnum.sunday);
              }
              break;
            }
          case 5:
            {
              if (DaysActive[i]) {
                weekDays.add(AdvertisingCampaignWeekdayEnum.saturday);
              }
              break;
            }
          case 4:
            {
              if (DaysActive[i]) {
                weekDays.add(AdvertisingCampaignWeekdayEnum.friday);
              }
              break;
            }
          case 3:
            {
              if (DaysActive[i]) {
                weekDays.add(AdvertisingCampaignWeekdayEnum.thursday);
              }
              break;
            }
          case 2:
            {
              if (DaysActive[i]) {
                weekDays.add(AdvertisingCampaignWeekdayEnum.wednesday);
              }
              break;
            }
          case 1:
            {
              if (DaysActive[i]) {
                weekDays.add(AdvertisingCampaignWeekdayEnum.tuesday);
              }
              break;
            }
          case 0:
            {
              if (DaysActive[i]) {
                weekDays.add(AdvertisingCampaignWeekdayEnum.monday);
              }
              break;
            }
        }
      }
      var args = AdvertisingCampaign(
        name: DiscountTitle,
        startDate: DiscountDateRange.start.millisecondsSinceEpoch ~/ 1000,
        endDate: DiscountDateRange.end.millisecondsSinceEpoch ~/ 1000,
        timezone: _timeZone,
        enabled: DiscountActive,
        startMinute: DiscountTimeStart.hour * 60 + DiscountTimeStart.minute,
        endMinute: DiscountTimeEnd.hour * 60 + DiscountTimeEnd.minute,
        defaultDiscount: DiscountValue,
        discountPrograms: DiscountPrograms,
        weekday: weekDays,
      );
      var res = await sessionData.client.addAdvertisingCampaign(args: args);

      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
    _canSave = true;
  }

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;

    if (_firstLoad) {
      _firstLoad = false;
    }

    final AppBar appBar = AppBar(
      title: Text(
        "Создание скидочной кампании",
        maxLines: 2,
      ),
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
            _TitleRow(),
            Divider(),
            _EnabledRow(),
            Divider(),
            _DiscountRow(),
            Divider(),
            _TimeZoneRow(),
            Divider(),
            _DateRow(),
            Divider(),
            _TimeRow(),
            Divider(),
            _DaysRow(),
            Divider(),
            _ProgramsDiscountRow(),
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
                            onPressed: () async {
                              if (_canSave) {
                                await _saveAdvertisingCampagin(sessionData);
                              }
                            },
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
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Очистить поля?"),
                                      actions: [
                                        Container(
                                          child: MaterialButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              InitValues();
                                            },
                                            child: Text("Да"),
                                          ),
                                        ),
                                        Container(
                                          child: MaterialButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Нет"),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                              setState(() {});
                            },
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

  Widget _TitleRow() {
    return Container(
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
                  DiscountTitle,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () async {
                  await showTitleDialog();
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Widget> showTitleDialog() {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    _titleController.text = DiscountTitle;
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Название"),
              content: Form(
                key: _formKey,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                  ),
                  controller: _titleController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Введите какое-либо название";
                    }
                    return null;
                  },
                ),
              ),
              actions: [
                Container(
                  child: MaterialButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        DiscountTitle = _titleController.value.text;
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Сохранить"),
                  ),
                ),
                Container(
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Отмена"),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  Widget _DiscountRow() {
    return Container(
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
                  "${DiscountValue} %",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                ),
                onPressed: () async {
                  await showDiscountDialog();
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Widget> showDiscountDialog() {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    _discountController.text = "${DiscountValue}";
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Базовая скидка"),
              content: Form(
                key: _formKey,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                  ),
                  controller: _discountController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  validator: (String value) {
                    int discountValue = int.tryParse(_discountController.value.text);
                    if (value.isEmpty) {
                      return "Введите скидку";
                    }
                    if (discountValue > 100) {
                      return "Скидка не может быть больше 100 %";
                    }
                    if (discountValue < 0) {
                      return "Скидка не может быть отрицательной";
                    }
                    return null;
                  },
                ),
              ),
              actions: [
                Container(
                  child: MaterialButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        DiscountValue = int.parse(_discountController.value.text);
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Сохранить"),
                  ),
                ),
                Container(
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Отмена"),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  Widget _DateRow() {
    return Container(
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
                          _dateFormat.format(DiscountDateRange.start),
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
                          _dateFormat.format(DiscountDateRange.end),
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
                onPressed: () async {
                  await _showDateDialog();
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDateDialog() async {
    var res = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
      initialDateRange: DiscountDateRange,
      initialEntryMode: DatePickerEntryMode.input,
    );
    if (res != null) {
      DiscountDateRange = res;
    }
    setState(() {});
  }

  Widget _TimeRow() {
    return Container(
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
                          "${DiscountTimeStart.format(context)}",
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
                          "${DiscountTimeEnd.format(context)}",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
                onPressed: () async {
                  await showTimeDialog();
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Widget> showTimeDialog() {
    TimeOfDay tmpStart = DiscountTimeStart;
    TimeOfDay tmpEnd = DiscountTimeEnd;
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Время действия"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [BoxShadow()],
                      color: Colors.white,
                    ),
                    child: MaterialButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "С: ",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${tmpStart.format(context)}",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      onPressed: () async {
                        var res = await showTimePicker(
                          context: context,
                          initialEntryMode: TimePickerEntryMode.dial,
                          initialTime: tmpStart,
                        );
                        if (res != null) {
                          tmpStart = res;
                        }
                        setState(() {});
                      },
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [BoxShadow()],
                      color: Colors.white,
                    ),
                    child: MaterialButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "По: ",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${tmpEnd.format(context)}",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      onPressed: () async {
                        var res = await showTimePicker(
                          context: context,
                          initialEntryMode: TimePickerEntryMode.dial,
                          initialTime: tmpEnd,
                        );
                        if (res != null) {
                          tmpEnd = res;
                        }
                        setState(() {});
                      },
                    ),
                  )
                ],
              ),
              actions: [
                Container(
                  child: MaterialButton(
                    onPressed: () {
                      DiscountTimeStart = tmpStart;
                      DiscountTimeEnd = tmpEnd;
                      Navigator.pop(context);
                    },
                    child: Text("Сохранить"),
                  ),
                ),
                Container(
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Отмена"),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  Widget _DaysRow() {
    return Container(
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
                  children: List.generate(7, (index) {
                    return Text(
                      Days[index],
                      style: TextStyle(color: DaysActive[index] ? Colors.green : Colors.red),
                    );
                  }),
                ),
                onPressed: () async {
                  await showDaysDialog();
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Widget> showDaysDialog() {
    List<bool> tmpDays = List.from(DaysActive);
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Дни акции"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(Days.length, (index) {
                  return CheckboxListTile(
                    value: tmpDays[index],
                    onChanged: (val) {
                      tmpDays[index] = val;
                      setState(() {});
                    },
                    title: Text(FullDays[index]),
                  );
                }),
              ),
              actions: [
                Container(
                  child: MaterialButton(
                    onPressed: () {
                      DaysActive = tmpDays;
                      Navigator.pop(context);
                    },
                    child: Text("Сохранить"),
                  ),
                ),
                Container(
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Отмена"),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  Widget _ProgramsDiscountRow() {
    return Container(
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
                  "${DiscountPrograms.length} шт",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                ),
                onPressed: () async {
                  await showProgramsDiscountDialog();
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Widget> showProgramsDiscountDialog() {
    List<DropdownMenuItem> DropDownItems = [
      DropdownMenuItem(
        child: Text("-"),
        value: -1,
      )
    ]..addAll(List.generate(GlobalData.Programs.length, (index) {
        return DropdownMenuItem(
          child: Text(GlobalData.Programs[index].name),
          value: GlobalData.Programs[index].id,
        );
      }));

    Set<int> ignoreItems = Set()
      ..addAll(List.generate(DiscountPrograms.length, (index) {
        return DiscountPrograms[index].programID;
      }));

    List<DiscountProgram> DiscountProgramsTmp = List.from(DiscountPrograms);

    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Скидки по программам"),
              content: Container(
                child: RawScrollbar(
                  controller: _scrollController,
                  isAlwaysShown: false,
                  thumbColor: Colors.greenAccent,
                  interactive: true,
                  child: ListView.separated(
                    physics: ClampingScrollPhysics(),
                    padding: EdgeInsets.all(5),
                    controller: _scrollController,
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.white,
                      );
                    },
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Container(
                          decoration: BoxDecoration(
                            //border: Border.all(),
                            boxShadow: [BoxShadow(blurRadius: 3)],
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.zero,
                          child: MaterialButton(
                            padding: EdgeInsets.zero,
                            onPressed: () async {
                              await showCreateProgramDiscount(DiscountProgramsTmp, DropDownItems.where((element) => !ignoreItems.contains(element.value)).toList(), ignoreItems);
                              setState(() {});
                            },
                            child: Column(children: [
                              Container(
                                height: 25,
                                color: Colors.black26,
                                child: Center(
                                  child: Text(
                                    "Программа",
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ),
                              ),
                              Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  boxShadow: [BoxShadow()],
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text("Добавить"),
                                ),
                              ),
                              Container(
                                height: 25,
                                color: Colors.black26,
                                child: Center(
                                  child: Text(
                                    "Скидка",
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ),
                              ),
                              Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  boxShadow: [BoxShadow()],
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    "0 %",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        );
                      }
                      int DiscountID = index - 1;
                      return Container(
                        decoration: BoxDecoration(
                          //border: Border.all(),
                          boxShadow: [BoxShadow(blurRadius: 3)],
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.zero,
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          onPressed: () async {
                            await showEditProgramDiscount(
                              DiscountProgramsTmp,
                              DropDownItems.where((element) => !ignoreItems.contains(element.value) || element.value == DiscountProgramsTmp[DiscountID].programID).toList(),
                              ignoreItems,
                              DiscountID,
                            );
                            setState(() {});
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 25,
                                color: Colors.lightGreen,
                                child: Center(
                                  child: Text(
                                    "Программа",
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ),
                              ),
                              Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  boxShadow: [BoxShadow()],
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    "${GlobalData.Programs.firstWhere((element) => element.id == DiscountProgramsTmp[DiscountID].programID).name}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Container(
                                height: 25,
                                color: Colors.lightGreen,
                                child: Center(
                                  child: Text(
                                    "Скидка",
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ),
                              ),
                              Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  boxShadow: [BoxShadow()],
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    "${DiscountProgramsTmp[DiscountID].discount} %",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: DiscountProgramsTmp.length + 1,
                  ),
                ),
              ),
              actions: [
                Container(
                  child: MaterialButton(
                    onPressed: () {
                      DiscountPrograms = DiscountProgramsTmp;
                      Navigator.pop(context);
                    },
                    child: Text("Сохранить"),
                  ),
                ),
                Container(
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Отмена"),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  Future<Widget> showCreateProgramDiscount(List<DiscountProgram> discountProgramsList, List<DropdownMenuItem> dropDownItems, Set<int> ignoreItems) {
    int dropDownValue = dropDownItems[0].value;
    _programDiscountController.text = "0";
    ProgramDiscountValue = 0;

    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Новая скидка"),
              contentPadding: EdgeInsets.zero,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 25,
                    color: Colors.lightGreen,
                    child: Center(
                      child: Text(
                        "Программа",
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      boxShadow: [BoxShadow()],
                      color: Colors.white,
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      items: dropDownItems,
                      value: dropDownValue,
                      onChanged: (val) {
                        dropDownValue = val;
                        setState(() {});
                      },
                    ),
                  ),
                  Container(
                    height: 25,
                    color: Colors.lightGreen,
                    child: Center(
                      child: Text(
                        "Скидка",
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      boxShadow: [BoxShadow()],
                      color: Colors.white,
                    ),
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      onPressed: () async {
                        await showProgramDiscountDialog();
                        setState(() {});
                      },
                      child: Text(
                        "${ProgramDiscountValue} %",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                Container(
                  child: MaterialButton(
                    onPressed: () {
                      if (dropDownValue != -1 && discountProgramsList.where((element) => element.programID == dropDownValue).length == 0) {
                        discountProgramsList.add(DiscountProgram(programID: dropDownValue, discount: ProgramDiscountValue));
                        ignoreItems.add(dropDownValue);
                      }
                      Navigator.pop(context);
                    },
                    child: Text("Сохранить"),
                  ),
                ),
                Container(
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Отмена"),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  Future<Widget> showEditProgramDiscount(List<DiscountProgram> discountProgramsList, List<DropdownMenuItem> dropDownItems, Set<int> ignoreItems, int index) {
    int dropDownValue = discountProgramsList[index].programID;
    _programDiscountController.text = "0";
    ProgramDiscountValue = discountProgramsList[index].discount;

    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Редактирование скидки"),
              contentPadding: EdgeInsets.zero,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 25,
                    color: Colors.lightGreen,
                    child: Center(
                      child: Text(
                        "Программа",
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      boxShadow: [BoxShadow()],
                      color: Colors.white,
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      items: dropDownItems,
                      value: dropDownValue,
                      onChanged: (val) {
                        dropDownValue = val;
                        setState(() {});
                      },
                    ),
                  ),
                  Container(
                    height: 25,
                    color: Colors.lightGreen,
                    child: Center(
                      child: Text(
                        "Скидка",
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      boxShadow: [BoxShadow()],
                      color: Colors.white,
                    ),
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      onPressed: () async {
                        await showProgramDiscountDialog();
                        setState(() {});
                      },
                      child: Text(
                        "${ProgramDiscountValue} %",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                Container(
                  child: MaterialButton(
                    onPressed: () {
                      if (dropDownValue != -1 && (discountProgramsList.indexWhere((element) => element.programID == dropDownValue) == index || !discountProgramsList.any((element) => element.programID == dropDownValue))) {
                        discountProgramsList[index] = DiscountProgram(programID: dropDownValue, discount: ProgramDiscountValue);
                        ignoreItems.add(dropDownValue);
                      }
                      Navigator.pop(context);
                    },
                    child: Text("Сохранить"),
                  ),
                ),
                Container(
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Отмена"),
                  ),
                ),
                Container(
                  child: MaterialButton(
                    onPressed: () {
                      ignoreItems.remove(discountProgramsList[index].programID);
                      discountProgramsList.removeAt(index);
                      Navigator.pop(context);
                    },
                    child: Text("Удалить"),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  Future<Widget> showProgramDiscountDialog() {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    _programDiscountController.text = "${ProgramDiscountValue}";
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Скидка для программы"),
              content: Form(
                key: _formKey,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                  ),
                  controller: _programDiscountController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  validator: (String value) {
                    int discountValue = int.tryParse(_programDiscountController.value.text);
                    if (value.isEmpty) {
                      return "Введите скидку";
                    }
                    if (discountValue > 100) {
                      return "Скидка не может быть больше 100 %";
                    }
                    if (discountValue < 0) {
                      return "Скидка не может быть отрицательной";
                    }
                    return null;
                  },
                ),
              ),
              actions: [
                Container(
                  child: MaterialButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        ProgramDiscountValue = int.parse(_programDiscountController.value.text);
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Сохранить"),
                  ),
                ),
                Container(
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Отмена"),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  Widget _EnabledRow() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Text(
                "Активна",
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
                  "Скидка ${DiscountActive ? "" : "не "}активна",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: DiscountActive ? Colors.green : Colors.red,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                ),
                onPressed: () async {
                  DiscountActive = !DiscountActive;
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _TimeZoneRow() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Text(
                "TimeZone",
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
              child: DropdownButton(
                isExpanded: true,
                items: _timeZoneValues,
                value: _timeZone,
                onChanged: (val) {
                  _timeZone = val;
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
