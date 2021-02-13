import 'dart:core';
import 'package:mobile_wash_control/client/api.dart';
//import 'dart:io';

import 'package:mobile_wash_control/AccountsMenu.dart';
import 'package:mobile_wash_control/AuthPage.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/DozatronsMenu.dart';
import 'package:mobile_wash_control/HomePage.dart';
import 'package:mobile_wash_control/EditPostMenu.dart';
import 'package:mobile_wash_control/PostsMenu.dart';
import 'package:mobile_wash_control/ProgramsMenu.dart';
import 'package:mobile_wash_control/ServersPage.dart';
import 'package:mobile_wash_control/SettingsMenu.dart';
import 'package:mobile_wash_control/StatisticsMenu.dart';

import 'package:wifi/wifi.dart';
import 'package:ping_discover_network/ping_discover_network.dart';

import 'package:flutter/material.dart';
import 'package:mobile_wash_control/client/api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Wash Control',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.lightGreen,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/",
      routes: {
        "/auth": (context) => AuthPage(),
        "/": (context) => MyHomePage(title: "Главная страница"),
        "/testScan": (context) => ServersPage(
              servers: null,
              serversValid: [],
            ),
        "/home": (context) => HomePage(),
        "/home/editPost": (context) => EditPostMenu(),
        "/home/programs": (context) => ProgramsMenu(),
        "/home/settings": (context) => SettingsMenu(),
        "/home/statistics": (context) => StatisticsMenu(),
        "/home/dozatrons": (context) => DozatronsMenu(),
        "/home/posts": (context) => PostsMenu(),
        "/home/accounts": (context) => AccountsMenu(),
      },
      //home: MyHomePage(title: 'Welcome'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _scanMSG = "";
  bool _wifi = false;
  bool _canScan = true;
  List<String> _servers = new List<String>();
  List<bool> _serversValid = new List<bool>();
  final DefaultApi _api = DefaultApi();

  void _scanLan() async {
    setState(() {
      _canScan = false;
    });
    _scanMSG = "";
    _servers = new List();
    _serversValid = new List();
    String ssid = await Wifi.ssid;
    int level = await Wifi.level;
    String localIp = await Wifi.ip;

    _wifi = level > 0;
    if (_wifi) {
      final stream = NetworkAnalyzer.discover2(
          localIp.substring(0, localIp.lastIndexOf('.')), 8020);
      stream.listen((NetworkAddress address) {
        if (address.exists) {
          _servers.add("${address.ip}");
        }
      }).onDone(() async {
        _serversValid = List.generate(_servers.length, (index) {
          return false;
        });
        for (int i = 0; i < _servers.length; i++) {
          _api.apiClient.basePath = "http://" + _servers[i] + ":8020";

          _serversValid[i] = true;

          // try {
          //   var args = new Args10();
          //   args.hash = "somehash";
          //   var res = await _api.ping(args);
          //   print(res);
          // } catch (e) {
          //   print("Exception when calling DefaultApi->Ping: $e\n");
          // }

          try {
            var res = await _api.getPing();
            print(res);
          } catch (e) {
            _serversValid[i] = false;
            print("Exception when calling DefaultApi->getPing: $e\n");
          }

          // try {
          //   var res = await _api.info();
          //   print(res);
          // } catch (e) {
          //   _serversValid[i] = false;
          //   print("Exception when calling DefaultApi->info: $e\n");
          // }
        }

        setState(() {
          _scanMSG = _servers.length > 0
              ? "Доступные серверы: "
              : "Не найдено серверов";
          _canScan = true;
        });
      });
    } else {
      setState(() {
        _scanMSG = "Нет подключения к WiFi";
        _canScan = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text(widget.title),
    );

    var screenW = MediaQuery.of(context).size.width;
    var screenH = MediaQuery.of(context).size.height;

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: appBar,
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(
                height: 100,
                width: screenW,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildServersButton(),
                    Text(
                      _canScan ? _scanMSG : "",
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                )),
            SizedBox(
              height: screenH - appBar.preferredSize.height - 150,
              child: ListView.separated(
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
                      "Server: " + _servers[index],
                      style: TextStyle(fontSize: 30),
                    ),
                    trailing: Icon(
                      _serversValid[index] ? Icons.check_circle : Icons.circle,
                      color:
                          _serversValid[index] ? Colors.lightGreen : Colors.red,
                      size: 30,
                    ),
                    onTap: _serversValid[index]
                        ? () {
                            var api = DefaultApi();
                            api.apiClient.addDefaultHeader("Pin", "1234");
                            api.apiClient.basePath =
                                "http://" + _servers[index] + ":8020";
                            var session = SessionData("0000", api);
                            Navigator.pushNamed(context, "/home",
                                arguments: session);
                          }
                        : null,
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: _buildScanButton(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildServersButton() {
    return new RaisedButton(
      color: _canScan ? Colors.lightGreen : Colors.yellow,
      splashColor: Colors.lightGreenAccent,
      child: new Text(_canScan ? ("Поиск серверов") : "Сканирование"),
      onPressed: _canScan
          ? () {
              _scanLan();
            }
          : () {
              print("cant_scan");
            },
    );
  }

  Widget _buildScanButton() {
    return new FloatingActionButton(
      backgroundColor: Colors.lightGreen,
      splashColor: Colors.lightGreenAccent,
      onPressed: () {
        Navigator.pushNamed(context, '/home',
            arguments: SessionData("0000", DefaultApi()));
      },
      tooltip: '',
      child: Icon(Icons.home),
    );
  }
}
