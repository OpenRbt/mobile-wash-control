import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_wash_control/SharedData.dart';
import 'package:mobile_wash_control/application/Application.dart';
import 'package:mobile_wash_control/mobile/AuthPage.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wifi_iot/wifi_iot.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> with RouteAware {
  PackageInfo _packageInfo = PackageInfo(
    appName: '',
    packageName: '',
    version: '',
    buildNumber: '',
    buildSignature: '',
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  void didPopNext() {
    SharedData.StopTimers();
  }

  String _scanMSG = "";
  String _localIP = "0.0.0.0";
  String _scanIP = "";
  int _pos = 0;
  bool _wifi = false;
  bool _canScan = true;
  late HashSet<String> _servers;

  @override
  void initState() {
    super.initState();
    _servers = new HashSet();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
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
      List<NetworkInterface?> interfaces = await NetworkInterface.list(type: InternetAddressType.IPv4);
      NetworkInterface? target = interfaces.firstWhere((element) => element!.name.contains("en") || element.name.contains("wlan"), orElse: () {
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
      int level = await WiFiForIoTPlugin.getCurrentSignalStrength() ?? 0;
      print("Wi-fi strength level: " + level.toString()); // прям на роутере: -14; очень близко: -31; относительно близко: -56; достаточно далеко: -76
      String? localIp = await WiFiForIoTPlugin.getIP();
      _localIP = localIp ?? "";
      _scanIP = localIp?.substring(
            0,
            localIp.lastIndexOf('.'),
          ) ??
          "";
      _wifi = level > -90 && level != 0;
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

  Future<void> _initNetworkInfo() async {
    setState(() {
      _canCheckInfo = false;
    });
    try {
      final info = NetworkInfo();

      lanIP = await info.getWifiIP();
      lanBroadcast = await info.getWifiBroadcast();
      lanGateway = await info.getWifiGatewayIP();
    } catch (e) {
      print(e);
    }
    setState(() {
      _canCheckInfo = true;
    });
    return;
  }

  Future<void> _findServers() async {
    hosts.value = [];
    setState(() {
      _canCheckServers = false;
    });

    try {
      var client = HttpClient();
      client.connectionTimeout = Duration(milliseconds: 500);

      var scanIP = lanIP!.substring(
        0,
        lanIP!.lastIndexOf('.'),
      );

      var subIPS = List.generate(256, (index) {
        return "$index";
      });

      subIPS.remove(lanBroadcast!);
      subIPS.remove(lanGateway!);
      subIPS.remove(lanIP!);

      subIPS.forEach(
        (element) {
          scanPos.value = "$scanIP.$element";
          client.get("$scanIP.$element", 8020, "/ping").then(
                (request) => request.close().then(
                  (response) {
                    if (response.statusCode == 200) {
                      hosts.value = List.from(hosts.value)..add("$scanIP.$element");
                    }
                  },
                ),
              );
        },
      );
    } catch (e) {
      print(e);
    }

    await Future.delayed(Duration(seconds: 3));
    setState(() {
      _canCheckServers = true;
    });
    return;
  }

  String? lanIP;
  String? lanBroadcast;
  String? lanGateway;

  bool _canCheckInfo = true;
  bool _canCheckServers = true;

  int maxScan = 1;
  ValueNotifier<String> scanPos = ValueNotifier("");

  ValueNotifier<List<String>> hosts = ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text("Доступные серверы"),
      leading: Text("${_packageInfo.version}"),
    );

    var screenW = MediaQuery.of(context).size.width;
    var screenH = MediaQuery.of(context).size.height;

    var theme = Theme.of(context);

    return Scaffold(
      appBar: appBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("IP:"),
                        Text(lanIP ?? ""),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Broadcast:"),
                        Text(lanBroadcast ?? ""),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Шлюз:"),
                        Text(lanGateway ?? ""),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton.icon(
                          onPressed: _canCheckInfo ? _initNetworkInfo : null,
                          label: Text("Обновить"),
                          icon: Container(
                            height: 24,
                            width: 24,
                            child: Icon(Icons.refresh_outlined),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: _canCheckServers ? _findServers : null,
                          label: Text("Сканировать"),
                          icon: Container(
                            height: 24,
                            width: 24,
                            child: Icon(Icons.search_rounded),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          _canCheckServers
              ? SizedBox(
                  height: 5,
                )
              : ValueListenableBuilder(
                  valueListenable: scanPos,
                  builder: (BuildContext context, String value, Widget? child) {
                    return LinearProgressIndicator();
                  },
                ),
          Text(
            "Доступные сервера",
            style: theme.textTheme.titleLarge,
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: hosts,
              builder: (BuildContext context, List<String> value, Widget? child) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: Text(
                            value[index],
                            style: theme.textTheme.titleMedium,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, "/mobile/auth", arguments: "http://" + value[index] + ":8020").then((value) {}, onError: (value) {});
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
