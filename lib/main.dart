import 'dart:collection';
import 'dart:core';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:mobile_wash_control/desktop/_DesktopPages.dart' as desktop;
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/mobile/AccountsMenuAdd.dart';
import 'package:mobile_wash_control/mobile/AccountsMenuEdit.dart';
import 'package:mobile_wash_control/mobile/AdvertisingCampagins.dart';
import 'package:mobile_wash_control/mobile/AdvertisingCampaginsCreate.dart';
import 'package:mobile_wash_control/mobile/AdvertisingCampaginsEdit.dart';
import 'package:mobile_wash_control/mobile/MotorMenu.dart';
import 'package:mobile_wash_control/mobile/ProgramMenuAdd.dart';
import 'package:mobile_wash_control/mobile/ProgramMenuEdit.dart';
import 'package:mobile_wash_control/mobile/SettingsDefaultConfigs.dart';
import 'package:mobile_wash_control/mobile/SettingsMenuKasse.dart';
import 'package:mobile_wash_control/mobile/SettingsMenuPost.dart';
import 'package:mobile_wash_control/mobile/AccountsMenu.dart';
import 'package:mobile_wash_control/mobile/AuthPage.dart';
import 'package:mobile_wash_control/mobile/HomePage.dart';
import 'package:mobile_wash_control/mobile/PostMenuEdit.dart';
import 'package:mobile_wash_control/mobile/PostsMenu.dart';
import 'package:mobile_wash_control/mobile/ProgramsMenu.dart';
import 'package:mobile_wash_control/mobile/SettingsMenu.dart';
import 'package:mobile_wash_control/mobile/StatisticsMenu.dart';
import 'package:mobile_wash_control/mobile/IncassationHistory.dart';

import 'package:wifi/wifi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  Intl.defaultLocale = "ru_RU";
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Wash Control',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/",
      routes: Platform.isAndroid ? PagesRoutes.routes["MOBILE"] : PagesRoutes.routes["DESKTOP"],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('ru'),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _scanMSG = "";
  String _localIP = "0.0.0.0";
  String _scanIP = "";
  int _pos = 0;
  bool _wifi = false;
  bool _canScan = true;
  HashSet<String> _servers;

  @override
  void initState() {
    super.initState();
    _servers = new HashSet();
  }

  void _scanLan(bool quick) async {
    _pos = 0;
    setState(() {
      _canScan = false;
    });
    _scanMSG = "";
    _servers = new HashSet();

    var client = HttpClient();
    client.connectionTimeout = Duration(milliseconds: 100);

    if (Platform.isLinux) {
      List<NetworkInterface> interfaces = await NetworkInterface.list(type: InternetAddressType.IPv4);
      print(interfaces);
      NetworkInterface target = interfaces.firstWhere((element) => element.name.contains("en") || element.name.contains("wlan"), orElse: () {
        return null;
      });
      if (target != null) {
        _localIP = target.addresses.first.address;
        _scanIP = _localIP.substring(
          0,
          _localIP.lastIndexOf('.'),
        );
        var subIPS = List.generate(256, (index) {
          return "$index";
        });
        if (quick) {
          client.connectionTimeout = Duration(seconds: 60);
          subIPS.forEach((element) async {
            try {
              if (element == "1" || element == "0" || element == "255") {
                _pos++;
                print("ignoring ... " + element);
                if (_pos == 256) {
                  _canScan = true;
                  setState(() {});
                }
                return;
              }
              final request = await client.get("${_scanIP}.${element}", 8020, "/ping");
              final response = await request.close();
              if (response.statusCode == 200) {
                if (mounted) {
                  _servers.add("${_scanIP}.${element}");
                  print("found connection on $element");
                  setState(() {});
                }
              }
            } catch (e) {
              print(e);
            }
            _pos++;
            if (_pos == 256) {
              _canScan = true;
              setState(() {});
              return;
            }
            setState(() {});
          });

          await Future.delayed(Duration(seconds: 50, milliseconds: 100));
          print("FOUND : ${_servers.length}");
        } else {
          await Future.forEach(subIPS, (element) async {
            print("Try to http://${_scanIP}.${element}:8020/ping");
            try {
              setState(() {
                _pos++;
              });
              final request = await client.get("${_scanIP}.${element}", 8020, "/ping");
              final response = await request.close();
              if (response.statusCode == 200) {
                if (mounted) {
                  _servers.add("${_scanIP}.${element}");
                  setState(() {});
                }
              }
            } catch (e) {}
          });
        }

        if (mounted)
          setState(() {
            _canScan = true;
          });
      } else {
        setState(() {
          _scanMSG = "Нет подключения к сети";
          _canScan = true;
        });
      }
    } else {
      int level = await Wifi.level;
      String localIp = await Wifi.ip;
      _localIP = localIp;
      _scanIP = localIp.substring(
        0,
        localIp.lastIndexOf('.'),
      );
      _wifi = level > 0;
      if (_wifi) {
        var subIPS = List.generate(256, (index) {
          return "$index";
        });

        if (quick) {
          client.connectionTimeout = Duration(seconds: 60);
          subIPS.forEach((element) async {
            try {
              if (element == "1" || element == "0" || element == "255") {
                _pos++;
                print("ignoring ... " + element);
                if (_pos == 256) {
                  _canScan = true;
                  setState(() {});
                }
                return;
              }
              final request = await client.get("${_scanIP}.${element}", 8020, "/ping");
              final response = await request.close();
              if (response.statusCode == 200) {
                if (mounted) {
                  _servers.add("${_scanIP}.${element}");
                  print("found connection on $element");
                  setState(() {});
                }
              }
            } catch (e) {
              print(e);
            }
            _pos++;
            if (_pos == 256) {
              _canScan = true;
              setState(() {});
              return;
            }
            setState(() {});
          });

          await Future.delayed(Duration(seconds: 50, milliseconds: 100));
          print("FOUND : ${_servers.length}");
        } else {
          await Future.forEach(subIPS, (element) async {
            // print("Try to http://${_scanIP}.${element}:8020/ping");
            try {
              setState(() {
                _pos++;
              });
              final request = await client.get("${_scanIP}.${element}", 8020, "/ping");
              final response = await request.close();
              if (response.statusCode == 200) {
                if (mounted) {
                  _servers.add("${_scanIP}.${element}");
                  setState(() {});
                }
              }
            } catch (e) {}
          });
        }

        if (mounted)
          setState(() {
            _canScan = true;
          });
      } else {
        if (mounted)
          setState(() {
            _scanMSG = "Нет подключения к WiFi";
            _canScan = true;
          });
      }
    }
    client.close();
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text("${widget.title}"),
      leading: Text("${DefaultConfig.appVersion}"),
    );

    var screenW = MediaQuery.of(context).size.width;
    var screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 25,
          ),
          SizedBox(
            height: 75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "IP: $_localIP\nTARGET: $_scanIP.*\nSCANNING: ${_scanIP}.${_pos}",
                  style: TextStyle(fontSize: 15),
                ),
                !_canScan
                    ? SizedBox(
                        height: 20,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26, width: 2),
                          ),
                          child: LinearProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.lightGreen),
                            backgroundColor: Colors.black12,
                            value: _pos / 256,
                          ),
                        ),
                      )
                    : SizedBox()
              ],
            ),
          ),
          SizedBox(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RaisedButton(
                      color: _canScan ? Colors.lightGreen : Colors.yellow,
                      splashColor: Colors.lightGreenAccent,
                      child: new Text(_canScan ? ("Поиск серверов") : "Сканирование"),
                      onPressed: () {
                        if (_canScan) _scanLan(false);
                      },
                    ),
                    RaisedButton(
                      color: _canScan ? Colors.lightGreen : Colors.yellow,
                      splashColor: Colors.lightGreenAccent,
                      child: new Text(_canScan ? ("QUICK SCAN") : "Сканирование"),
                      onPressed: () {
                        if (_canScan) _scanLan(true);
                      },
                    )
                  ],
                ),
                Text(
                  _canScan ? _scanMSG : "",
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenH - appBar.preferredSize.height - 141 - 100,
            child: (_servers.length > 0)
                ? ListView.separated(
                    //TODO: remove after
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        height: 5,
                        color: Colors.black38,
                        thickness: 5,
                      );
                    },
                    itemCount: _servers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        tileColor: Colors.black12,
                        title: Text(
                          "Server: " + _servers.elementAt(index),
                          style: TextStyle(fontSize: 30),
                        ),
                        trailing: Icon(
                          Icons.check_circle,
                          color: Colors.lightGreen,
                          size: 30,
                        ),
                        onTap: () {
                          if (Platform.isLinux) {
                            var args = desktop.DAuthArgs("http://" + _servers.elementAt(index) + ":8020");
                            Navigator.pushNamed(context, "/desktop/auth", arguments: args);
                          } else {
                            var args = AuthArgs("http://" + _servers.elementAt(index) + ":8020");
                            Navigator.pushNamed(context, "/mobile/auth", arguments: args);
                          }
                        },
                      );
                    },
                  )
                : Center(),
          )
        ],
      ),
    );
  }
}

/*
TODO:
  * REWORK:
    DProgramsMenu
    DProgramsMenuEdit
    DProgramsMenuAdd
    DSettingsMenu

  * Layout Fixes:
    DAccountsMenuAdd
    DAccountsMenuEdit
    DStatisticsPage
    DProgramsMenu
 */
class PagesRoutes {
  static final Map<String, Map<String, Widget Function(BuildContext)>> routes = {
    "DESKTOP": {
      "/": (context) => MyHomePage(title: "Главная страница"),
      "/desktop/auth": (context) => desktop.DAuthPage(),
      "/desktop/home": (context) => desktop.DHomePage(),
      "/desktop/home/edit": (context) => desktop.PostMenu(),
      "/desktop/statistics": (context) => desktop.DStatisticsPage(),
      "/desktop/accounts": (context) => desktop.DAccountsMenu(),
      "/desktop/accounts/edit": (context) => desktop.DAccountsMenuEdit(),
      "/desktop/accounts/add": (context) => desktop.DAccountsMenuAdd(),
      "/desktop/programs": (context) => desktop.DProgramsMenu(),
      "/desktop/programs/add": (context) => desktop.AddProgramPage(),
      "/desktop/programs/edit": (context) => desktop.EditProgramPage(),
      "/desktop/settings": (context) => desktop.DSettingsMenu(),
      "/desktop/settings/post": (context) => desktop.DSettingsMenuPost(),
      "/mobile/settings/kasse": (context) => SettingsMenuKasse(),
      "/mobile/settings/default": (context) => SettingsDefaultConfigs(),
      "/dekstop/incassation": (context) => desktop.DIncassationHistory(),
      "/desktop/motors": (context) => desktop.DMotorMenu(),
    },
    "MOBILE": {
      "/": (context) => MyHomePage(title: "Главная страница"),
      "/mobile/auth": (context) => AuthPage(),
      "/mobile/home": (context) => HomePage(),
      "/mobile/editPost": (context) => EditPostMenu(),
      "/mobile/programs": (context) => ProgramsMenu(),
      "/mobile/programs/edit": (context) => ProgramMenuEdit(),
      "/mobile/programs/add": (context) => ProgramMenuAdd(),
      "/mobile/settings": (context) => SettingsMenu(),
      "/mobile/settings/post": (context) => SettingsMenuPost(),
      "/mobile/settings/kasse": (context) => SettingsMenuKasse(),
      "/mobile/settings/default": (context) => SettingsDefaultConfigs(),
      "/mobile/statistics": (context) => StatisticsMenu(),
      "/mobile/motors": (context) => MotorMenu(),
      "/mobile/posts": (context) => PostsMenu(),
      "/mobile/accounts": (context) => AccountsMenu(),
      "/mobile/accounts/edit": (context) => AccountsMenuEdit(),
      "/mobile/accounts/add": (context) => AccountsMenuAdd(),
      "/mobile/incassation": (context) => IncassationHistory(),
      "/mobile/advertisings": (conmtext) => AdvertisingCampagins(),
      "/mobile/advertisings/create": (context) => AdvertisingCampaginsCreate(),
      "/mobile/advertisings/edit": (context) => AdvertisingCampaginsEdit(),
    }
  };
}
