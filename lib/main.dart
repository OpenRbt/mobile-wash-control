import 'dart:core';
//import 'dart:io';

import 'package:mobile_wash_control/AccountsMenu.dart';
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
      title: 'Flutter Demo',
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
        primarySwatch: Colors.green,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => MyHomePage(title: "Welcome"),
        "/testScan": (context) => ServersPage(
              servers: null,
              serversValid: [],
            ),
        "/home": (context) => HomePage(),
        "/home/editPost": (context) => EditPostMenu(postID: null),
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
          try {
            var args = new Args();
            args.id = 1;
            args.startDate = new DateTime.now()
                .add(new Duration(days: -30))
                .millisecondsSinceEpoch;
            args.endDate = new DateTime.now().millisecondsSinceEpoch;
            StationReport res = await _api.stationReportDates(args);
            print(res);
          } catch (e) {
            print(
                "Exception when calling DefaultApi->station-report-dates: $e\n");
          }

          try {
            var args = new Args1();
            args.id = 1;
            var res = await _api.stationReportCurrentMoney(args);
            print(res);
          } catch (e) {
            print(
                "Exception when calling DefaultApi->station-report-current-money: $e\n");
          }

          try {
            StatusReport statusReport = await _api.status();
            print(statusReport);
          } catch (e) {
            print("Exception when calling DefaultApi->status: $e\n");
          }

          try {
            StatusCollectionReport statusCollectionReport =
                await _api.statusCollection();
            print(statusCollectionReport);
          } catch (e) {
            print(
                "Exception when calling DefaultApi->/status-collection: $e\n");
          }

          try {
            var args = new Args2();
            args.amount = 10;
            args.hash = "somehash";
            var res = await _api.addServiceAmount(args);
            print(res);
          } catch (e) {
            print(
                "Exception when calling DefaultApi->add-service-amount: $e\n");
          }

          try {
            var args = new Args3();
            args.id = -1;
            args.hash = "somehash";
            args.name = "somename";
            var res = await _api.setStation(args);
            print(res);
          } catch (e) {
            print("Exception when calling DefaultApi->set-station: $e\n");
          }

          try {
            var args = new Args4();
            args.id = -1;
            var res = await _api.delStation(args);
            print(res);
          } catch (e) {
            print("Exception when calling DefaultApi->del-station: $e\n");
          }

          try {
            var args = new RelayReport();
            args.hash = "somehash";
            args.relayStats = List.generate(3, (index) {
              var tmp = new RelayStat();
              tmp.relayID = index;
              tmp.switchedCount = index * 5;
              tmp.totalTimeOn = index * 30;
              return tmp;
            });
            var res = await _api.saveRelay(args);
            print(res);
          } catch (e) {
            print("Exception when calling DefaultApi->save-relay: $e\n");
          }

          try {
            var args = new Args5();
            args.hash = "somehash";
            var res = await _api.loadRelay(args);
            print(res);
          } catch (e) {
            print("Exception when calling DefaultApi->load-relay: $e\n");
          }

          try {
            var args = new MoneyReport();
            args.hash = "somehash";
            args.banknotes = 100;
            args.carsTotal = 200;
            args.coins = 300;
            args.electronical = 400;
            args.service = 500;
            var res = await _api.saveMoney(args);
            print(res);
          } catch (e) {
            print("Exception when calling DefaultApi->save-money: $e\n");
          }

          try {
            var args = new Args6();
            args.id = -1;
            var res = await _api.saveCollection(args);
            print(res);
          } catch (e) {
            print("Exception when calling DefaultApi->save-collection: $e\n");
          }

          try {
            var args = new Args7();
            args.hash = "somehash";
            var res = await _api.loadMoney(args);
            print(res);
          } catch (e) {
            print("Exception when calling DefaultApi->load-money: $e\n");
          }

          try {
            var args = new Args8();
            args.hash = "somehash";
            args.keyPair = new KeyPair();
            args.keyPair.key = "somekey";
            args.keyPair.value = "somevalue";
            var res = await _api.save(args);
            print(res);
          } catch (e) {
            print("Exception when calling DefaultApi->load: $e\n");
          }

          try {
            var args = new Args9();
            args.key = "somekey";
            args.hash = "somehash";
            var res = await _api.load(args);
            print(res);
          } catch (e) {
            print("Exception when calling DefaultApi->save: $e\n");
          }

          try {
            var args = new Args10();
            args.hash = "somehash";
            var res = await _api.ping(args);
            print(res);
          } catch (e) {
            print("Exception when calling DefaultApi->Ping: $e\n");
          }

          try {
            var res = await _api.getPing();
            print(res);
          } catch (e) {
            print("Exception when calling DefaultApi->getPing: $e\n");
          }

          try {
            var res = await _api.info();
            print(res);
          } catch (e) {
            _serversValid[i] = false;
            print("Exception when calling DefaultApi->info: $e\n");
          }
          try {
            var args = new Args11();
            args.hash = "somehash";
            var res = await _api.stationByHash(args);
            print(res);
          } catch (e) {
            print("Exception when calling DefaultApi->station-by-hash: $e\n");
          }

          try {
            var args = new Args12();
            args.hash = "somehash";
            args.keyPair = new KeyPair();
            args.keyPair.key = "somekey";
            args.keyPair.value = "somevalue";
            var res = _api.saveIfNotExists(args);
            print(res);
          } catch (e) {
            print(
                "Exception when calling DefaultApi->save-if-not-exists: $e\n");
          }

          try {
            var res = await _api.stationsVariables();
            print(res);
          } catch (e) {
            print(
                "Exception when calling DefaultApi->stations-variables: $e\n");
          }

          try {
            var args = new Args13();
            args.stationID = -1;
            var res = _api.openStation(args);
            print(res);
          } catch (e) {
            print("Exception when calling DefaultApi->open-station: $e\n");
          }

          try {
            var args = new Args14();
            args.stationID = -1;
            var res = _api.programs(args);
            print(res);
          } catch (e) {
            print("Exception when calling DefaultApi->programs: $e\n");
          }

          try {
            var args = new Args15();
            args.stationID = -1;
            args.programID = 1;
            args.name = "somename";
            var res = _api.setProgramName(args);
            print(res);
          } catch (e) {
            print("Exception when calling DefaultApi->set-program-name: $e\n");
          }

          try {
            var args = new Args16();
            args.stationID = 1;
            args.programID = 9;
            var res = await _api.programRelays(args);
            print(res);
          } catch (e) {
            print("Exception when calling DefaultApi->program-relays: $e\n");
          }

          try {
            var args = new Args17();
            args.stationID = -1;
            args.programID = 1;
            args.relays = List.generate(8, (index) {
              var conf = new RelayConfig();
              conf.id = index;
              conf.timeon = index * 10;
              conf.timeoff = index * 10 + 10;
              conf.prfelight = index * 10;
              return conf;
            });
            var res = _api.setProgramRelays(args);
            print(res);
          } catch (e) {
            print(
                "Exception when calling DefaultApi->set-program-relays: $e\n");
          }

          try {
            var res = await _api.kasse();
            print(res);
          } catch (e) {
            print("Exception when calling DefaultApi->kasse: $e\n");
          }

          try {
            var args = new KasseConfig();
            args.tax = "TAX_VAT110";
            args.receiptItemName = "someitemname";
            args.cashier = "IVANOV IVAN IVANOVICH";
            args.cashierINN = "123456789012";
            var res = await _api.setKasse(args);
            print(res);
          } catch (e) {
            print("Exception when calling DefaultApi->set-kasse: $e\n");
          }
        }

        setState(() {
          _scanMSG += "Found ${_servers.length} servers";
          _canScan = true;
        });
      });
    } else {
      setState(() {
        _scanMSG = "Not connected to WiFi";
        _canScan = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildServersButton(),
            Text(_canScan ? _scanMSG : ""),
            RaisedButton(
                child: Text("Home"),
                onPressed: () {
                  Navigator.pushNamed(context, "/home");
                }),
            RaisedButton(
                child: Text("EditPost"),
                onPressed: () {
                  Navigator.pushNamed(context, "/home/editPost",
                      arguments: PostMenuArgs(-1));
                }),
            RaisedButton(
                child: Text("programs"),
                onPressed: () {
                  Navigator.pushNamed(context, "/home/programs");
                }),
            RaisedButton(
                child: Text("settings"),
                onPressed: () {
                  Navigator.pushNamed(context, "/home/settings");
                }),
            RaisedButton(
                child: Text("statistics"),
                onPressed: () {
                  Navigator.pushNamed(context, "/home/statistics");
                }),
            RaisedButton(
                child: Text("dozatrons"),
                onPressed: () {
                  Navigator.pushNamed(context, "/home/dozatrons");
                }),
            RaisedButton(
                child: Text("posts"),
                onPressed: () {
                  Navigator.pushNamed(context, "/home/posts");
                }),
            RaisedButton(
                child: Text("accounts"),
                onPressed: () {
                  Navigator.pushNamed(context, "/home/accounts");
                }),
            RaisedButton(
                child: Text("TestClient"),
                onPressed: () {
                  var api_instance = new DefaultApi();
                  var args = new Args2(); // Args2 |

                  try {
                    api_instance.addServiceAmount(args);
                  } catch (e) {
                    print(
                        "Exception when calling DefaultApi->addServiceAmount: $e\n");
                  }
                }),
          ],
        ),
      ),
      floatingActionButton: _buildScanButton(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildServersButton() {
    return new RaisedButton(
        color: _servers.length < 1 ? Colors.redAccent : Colors.green,
        child: new Text(_canScan
            ? (_servers.length < 1 ? "No servers found" : "Open server list")
            : "Scanning"),
        onPressed: (!_canScan || _servers.length < 1)
            ? null
            : () {
                //await _scanLan();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ServersPage(
                              servers: _servers,
                              serversValid: _serversValid,
                            )));
              });
  }

  Widget _buildScanButton() {
    return new FloatingActionButton(
      backgroundColor: _canScan ? Colors.green : Colors.yellow,
      splashColor: Colors.greenAccent,
      onPressed: _canScan
          ? () {
              _scanLan();
            }
          : () {
              print("cant_scan");
            },
      tooltip: 'Scan servers',
      child: Icon(Icons.network_check),
    );
  }
}
