import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/SharedData.dart';
import 'package:mobile_wash_control/client/api.dart';

class AdvertisingCampaginsEditArgs {
  final SessionData sessionData;
  AdvertisingCampaign campaign;

  AdvertisingCampaginsEditArgs(this.sessionData, this.campaign);
}

class AdvertisingCampaginsEdit extends StatefulWidget {
  @override
  _AdvertisingCampaginsEditState createState() => _AdvertisingCampaginsEditState();
}

class _AdvertisingCampaginsEditState extends State<AdvertisingCampaginsEdit> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _firstLoad = true;
  bool _canSave = true;
  //OldData
  late AdvertisingCampaign data;
  //Values
  late int? programDiscountValue;

  late int discountValue;
  late String discountTitle;

  late List<DiscountProgram> discountPrograms;

  late DateTimeRange discountDateRange;
  late TimeOfDay discountTimeStart;
  late TimeOfDay discountTimeEnd;

  bool DiscountActive = true;

  final List<String> _fullDays = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"];
  final List<String> _days = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"];
  late List<bool> DaysActive;
  //Helpers
  late DateFormat _dateFormat;
  //TextFields
  late TextEditingController _titleController;
  late TextEditingController _discountController;
  late TextEditingController _programDiscountController;

  late ScrollController _scrollController;

  void initState() {
    _titleController = new TextEditingController();
    _discountController = new TextEditingController();
    _programDiscountController = new TextEditingController();
    _scrollController = new ScrollController();

    _dateFormat = new DateFormat("dd.MM.yyyy");
  }

  void initValues() {
    discountTitle = data.name ?? "";
    discountDateRange = DateTimeRange(start: DateTime.fromMillisecondsSinceEpoch(data.startDate * 1000), end: DateTime.fromMillisecondsSinceEpoch(data.endDate * 1000));
    discountTimeStart = TimeOfDay(hour: (data.startMinute ?? 0) ~/ 60, minute: (data.startMinute ?? 0) % 60);
    discountTimeEnd = TimeOfDay(hour: (data.endMinute ?? 0) ~/ 60, minute: (data.endMinute ?? 0) % 60);
    discountValue = data.defaultDiscount ?? 0;

    discountPrograms = data.discountPrograms ?? [];

    _titleController.text = discountTitle ?? "";
    _discountController.text = "${discountValue ?? 0}";

    DiscountActive = data.enabled ?? false;

    DaysActive = List.generate(7, (index) {
      switch (index) {
        case 0:
          {
            return data.weekday.contains(AdvertisingCampaignWeekdayEnum.monday);
          }
        case 1:
          {
            return data.weekday.contains(AdvertisingCampaignWeekdayEnum.tuesday);
          }
        case 2:
          {
            return data.weekday.contains(AdvertisingCampaignWeekdayEnum.wednesday);
          }
        case 3:
          {
            return data.weekday.contains(AdvertisingCampaignWeekdayEnum.thursday);
          }
        case 4:
          {
            return data.weekday.contains(AdvertisingCampaignWeekdayEnum.friday);
          }
        case 5:
          {
            return data.weekday.contains(AdvertisingCampaignWeekdayEnum.saturday);
          }
        case 6:
          {
            return data.weekday.contains(AdvertisingCampaignWeekdayEnum.sunday);
          }
        default :
          return false;
      }
    });
  }

  void dispose() {
    _titleController.dispose();
    _discountController.dispose();
    _scrollController.dispose();
    _programDiscountController.dispose();
    super.dispose();
  }

  Future<void> _saveAdvertisingCampagin(SessionData sessionData) async {
    _canSave = false;
    try {
      List<AdvertisingCampaignWeekdayEnum> weekDays = [];
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
        id: data.id,
        name: discountTitle,
        startDate: discountDateRange.start.millisecondsSinceEpoch ~/ 1000,
        endDate: discountDateRange.end.millisecondsSinceEpoch ~/ 1000,
        enabled: DiscountActive,
        startMinute: discountTimeStart.hour * 60 + discountTimeStart.minute,
        endMinute: discountTimeEnd.hour * 60 + discountTimeEnd.minute,
        defaultDiscount: discountValue,
        discountPrograms: discountPrograms,
        weekday: weekDays,
      );
      await sessionData.client.editAdvertisingCampaign(args);
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
    _canSave = true;
  }

  Future<void> _deleteAdvertisingCampagin(SessionData sessionData) async {
    _canSave = false;
    try {
      ArgDelAdvertisingCampagin args = ArgDelAdvertisingCampagin(id: data.id ?? -1);
      await sessionData.client.delAdvertisingCampaign(args);
    } catch (e) {
      print(e);
    }
    _canSave = true;
  }

  @override
  Widget build(BuildContext context) {
    final AdvertisingCampaginsEditArgs args = ModalRoute.of(context)?.settings.arguments as AdvertisingCampaginsEditArgs;

    if (_firstLoad) {
      data = args.campaign;
      initValues();
      _firstLoad = false;
    }

    final AppBar appBar = AppBar(
      title: Text(
        "Редактирование скидочной кампании",
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
                                await _saveAdvertisingCampagin(args.sessionData);
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
                              bool delete = false;
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Удалить кампанию?"),
                                      actions: [
                                        Container(
                                          child: MaterialButton(
                                            onPressed: () async {
                                              if (_canSave) {
                                                delete = true;
                                                await _deleteAdvertisingCampagin(args.sessionData);
                                                Navigator.pop(context);
                                              }
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
                              if (delete) {
                                Navigator.pop(context);
                              }
                              setState(() {});
                            },
                            child: Text(
                              "Удалить",
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
                  discountTitle,
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

  Future<dynamic> showTitleDialog() {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    _titleController.text = discountTitle;
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
                  validator: (String? value) {
                    bool val = value?.isEmpty ?? true;
                    if (val) {
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
                      if (_formKey.currentState!.validate()) {
                        discountTitle = _titleController.value.text;
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
                  "${discountValue} %",
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

  Future<dynamic> showDiscountDialog() {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    _discountController.text = "${discountValue}";
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
                  validator: (String? value) {
                    int? discountValue = int.tryParse(_discountController.value.text);
                    bool val = value?.isEmpty ?? true;
                    if (val) {
                      return "Введите скидку";
                    }
                    int discountVal = discountValue ?? 0;
                    if (discountVal > 100) {
                      return "Скидка не может быть больше 100 %";
                    }
                    if (discountVal < 0) {
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
                      if (_formKey.currentState!.validate()) {
                        discountValue = int.parse(_discountController.value.text);
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
                          _dateFormat.format(discountDateRange.start),
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
                          _dateFormat.format(discountDateRange.end),
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
      initialDateRange: discountDateRange,
      initialEntryMode: DatePickerEntryMode.input,
    );
    if (res != null) {
      discountDateRange = res;
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
                          "${discountTimeStart.format(context)}",
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
                          "${discountTimeEnd.format(context)}",
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

  Future<dynamic> showTimeDialog() {
    TimeOfDay tmpStart = discountTimeStart;
    TimeOfDay tmpEnd = discountTimeEnd;
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
                      discountTimeStart = tmpStart;
                      discountTimeEnd = tmpEnd;
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
                      _days[index],
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

  Future<dynamic> showDaysDialog() {
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
                children: List.generate(_days.length, (index) {
                  return CheckboxListTile(
                    value: tmpDays[index],
                    onChanged: (val) {
                      tmpDays[index] = val!;
                      setState(() {});
                    },
                    title: Text(_fullDays[index]),
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
    return ValueListenableBuilder(
      valueListenable: SharedData.Programs,
      builder: (BuildContext context, values, child) {
        if (SharedData.Programs.value == null) {
          SharedData.RefreshPrograms();
          return child ?? Container();
        }
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
                      "${discountPrograms.length} шт",
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
      },
      child: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Future<dynamic> showProgramsDiscountDialog() {
    List<DropdownMenuItem> DropDownItems = [
      DropdownMenuItem(
        child: Text("-"),
        value: -1,
      )
    ]..addAll(List.generate(SharedData.Programs.value.length, (index) {
        return DropdownMenuItem(
          child: Text(SharedData.Programs.value[index].name ?? ""),
          value: SharedData.Programs.value[index].id,
        );
      }));

    Set<int> ignoreItems = Set()
      ..addAll(List.generate(discountPrograms.length, (index) {
        return discountPrograms[index].programID ?? -1;
      }));

    List<DiscountProgram> DiscountProgramsTmp = List.from(discountPrograms);

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
                  thumbVisibility: false,
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
                                    "${SharedData.Programs.value.firstWhere((element) => element.id == DiscountProgramsTmp[DiscountID].programID).name}",
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
                      discountPrograms = DiscountProgramsTmp;
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

  Future<dynamic> showCreateProgramDiscount(List<DiscountProgram> discountProgramsList, List<DropdownMenuItem> dropDownItems, Set<int> ignoreItems) {
    int dropDownValue = dropDownItems[0].value;
    _programDiscountController.text = "0";
    programDiscountValue = 0;

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
                        "${programDiscountValue} %",
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
                        discountProgramsList.add(DiscountProgram(programID: dropDownValue, discount: programDiscountValue));
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

  Future<dynamic> showEditProgramDiscount(List<DiscountProgram> discountProgramsList, List<DropdownMenuItem> dropDownItems, Set<int> ignoreItems, int index) {
    int? dropDownValue = discountProgramsList[index].programID;
    _programDiscountController.text = "0";
    programDiscountValue = discountProgramsList[index].discount;

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
                        "${programDiscountValue} %",
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
                        ignoreItems.remove(discountProgramsList[index].programID);
                        discountProgramsList[index] = DiscountProgram(programID: dropDownValue, discount: programDiscountValue);
                        ignoreItems.add(dropDownValue ?? 0);
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

  Future<dynamic> showProgramDiscountDialog() {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    _programDiscountController.text = "${programDiscountValue}";
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
                  validator: (String? value) {
                    int? discountValue = int.tryParse(_programDiscountController.value.text);
                    bool val = value?.isEmpty ?? true;
                    if (val) {
                      return "Введите скидку";
                    }
                    int discountVal = discountValue ?? 0;
                    if (discountVal > 100) {
                      return "Скидка не может быть больше 100 %";
                    }
                    if (discountVal < 0) {
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
                      if (_formKey.currentState!.validate()) {
                        programDiscountValue = int.parse(_programDiscountController.value.text);
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
}
