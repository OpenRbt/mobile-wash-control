import 'dart:core';
import 'dart:io';
import 'package:http/http.dart';
import 'package:mobile_wash_control/AccountsMenuAdd.dart';
import 'package:mobile_wash_control/AccountsMenuEdit.dart';
import 'package:mobile_wash_control/ProgramMenuAdd.dart';
import 'package:mobile_wash_control/ProgramMenuEdit.dart';
import 'package:mobile_wash_control/SettingsMenuKasse.dart';
import 'package:mobile_wash_control/SettingsMenuPost.dart';
import 'package:mobile_wash_control/AccountsMenu.dart';
import 'package:mobile_wash_control/AuthPage.dart';
import 'package:mobile_wash_control/HomePage.dart';
import 'package:mobile_wash_control/PostMenuEdit.dart';
import 'package:mobile_wash_control/PostsMenu.dart';
import 'package:mobile_wash_control/ProgramsMenu.dart';
import 'package:mobile_wash_control/ServersPage.dart';
import 'package:mobile_wash_control/SettingsMenu.dart';
import 'package:mobile_wash_control/StatisticsMenu.dart';

import 'package:wifi/wifi.dart';

import 'package:flutter/material.dart';

void main() {
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
        "/home/programs/edit": (context) => ProgramMenuEdit(),
        "/home/programs/add": (context) => ProgramMenuAdd(),
        "/home/settings": (context) => SettingsMenu(),
        "/home/settings/post": (context) => SettingsMenuPost(),
        "/home/settings/kasse": (context) => SettingsMenuKasse(),
        "/home/statistics": (context) => StatisticsMenu(),
        "/home/posts": (context) => PostsMenu(),
        "/home/accounts": (context) => AccountsMenu(),
        "/home/accounts/edit": (context) => AccountsMenuEdit(),
        "/home/accounts/add": (context) => AccountsMenuAdd()
      },
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
  List<String> _servers = new List<String>();
  List<bool> _serversValid = new List<bool>();

  void _scanLan() async {
    _pos = 0;
    setState(() {
      _canScan = false;
    });
    _scanMSG = "";
    _servers = new List();
    _serversValid = new List();

    int level = await Wifi.level;
    String localIp = await Wifi.ip;
    _localIP = localIp;
    _scanIP = localIp.substring(
      0,
      localIp.lastIndexOf('.'),
    );
    _wifi = level > 0;
    if (_wifi) {
      List<String> _serversTMP = new List();
      List<bool> _serversValidTMP = new List();
      var subIPS = List.generate(256, (index) {
        return "$index";
      });

      var client = HttpClient();
      client.connectionTimeout = Duration(milliseconds: 100);

      await Future.forEach(subIPS, (element) async {
        print("Try to http://${_scanIP}.${element}:8020/ping");
        try {
          setState(() {
            _pos++;
          });
          final request =
              await client.get("${_scanIP}.${element}", 8020, "/ping");
          final response = await request.close();
          if (response.statusCode == 200) {
            _serversTMP.add("${_scanIP}.${element}");
          }
        } catch (e) {}
      }).then((value) {
        _canScan = true;
        _serversValidTMP = List.filled(_serversTMP.length, true); //TODO: remove
        _servers = _serversTMP;
        _serversValid = _serversValidTMP;
        setState(() {});
      });

      client.close();
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

    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
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
                              border:
                                  Border.all(color: Colors.black26, width: 2),
                            ),
                            child: LinearProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(Colors.lightGreen),
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
              ),
            ),
            SizedBox(
              height: screenH - appBar.preferredSize.height - 141 - 75,
              child: (_servers.length > 0 &&
                      _serversValid.length == _servers.length)
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
                            "Server: " + _servers[index],
                            style: TextStyle(fontSize: 30),
                          ),
                          trailing: Icon(
                            _serversValid[index]
                                ? Icons.check_circle
                                : Icons.circle,
                            color: _serversValid[index]
                                ? Colors.lightGreen
                                : Colors.red,
                            size: 30,
                          ),
                          onTap: _serversValid[index]
                              ? () {
                                  var args = AuthArgs(
                                      "http://" + _servers[index] + ":8020");
                                  Navigator.pushNamed(context, "/auth",
                                      arguments: args);
                                }
                              : null,
                        );
                      },
                    )
                  : Center(),
            )
          ],
        ),
      ),
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
}
