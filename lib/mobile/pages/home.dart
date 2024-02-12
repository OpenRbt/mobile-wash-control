import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_wash_control/mobile/widgets/scan_host_list_tile.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _hostField = TextEditingController();

  PackageInfo _packageInfo = PackageInfo(
    appName: '',
    packageName: '',
    version: '',
    buildNumber: '',
    buildSignature: '',
  );

  ValueNotifier<List<String>> _scanActions = ValueNotifier([]);

  Map<String, bool> _scanActionInProgress = {};

  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scanActions.dispose();
    _hostField.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    _initNetworkInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
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
    var scanIP = lanIP!.substring(
      0,
      lanIP!.lastIndexOf('.'),
    );

    var scanTargets = <String>[];
    if (Platform.isLinux) {
      scanTargets.add("localhost");
    }
    scanTargets.addAll(
      List.generate(
        255,
        (index) {
          return "$scanIP.${index + 1}";
        },
      ),
    );

    scanTargets.remove(lanBroadcast!);
    scanTargets.remove(lanGateway!);
    if (Platform.isAndroid) {
      scanTargets.remove(lanIP!);
    }

    _scanActionInProgress.clear();
    _scanActions.value = List<String>.from(scanTargets);
    scanTargets.forEach((element) {
      _scanHost(element);
    });

    return;
  }

  Future<bool> _scanHost(String host) async {
    _scanActionInProgress[host] = true;
    var client = HttpClient();
    try {
      client.idleTimeout = Duration(seconds: 1);
      client.connectionTimeout = Duration(seconds: 1);
      final res = await client.get(host, 8020, "/ping").timeout(Duration(seconds: 1));
      final response = await res.close();
      if (response.statusCode != 200) {
        _scanActionInProgress[host] = false;
        _scanActions.value = List.from(_scanActions.value)..remove(host);
        _scrollController.jumpTo(0);
        return false;
      }
      _scanActionInProgress[host] = false;
      return true;
    } catch (e) {
      _scanActionInProgress[host] = false;
    }
    client.close();

    _scanActions.value = List.from(_scanActions.value)..remove(host);
    return false;
  }

  Future<bool> _scanManual(String host) async {
    var client = HttpClient();
    try {
      client.idleTimeout = Duration(seconds: 1);
      client.connectionTimeout = Duration(seconds: 1);
      final res = await client.get(host, 8020, "/ping").timeout(Duration(seconds: 1));
      final response = await res.close();
      client.close();
      if (response.statusCode != 200) {
        manualHost = null;
        return false;
      }
      manualHost = host;
      return true;
    } catch (e) {
      _scanActionInProgress[host] = false;
    }
    client.close();

    manualHost = null;
    return false;
  }

  String? manualHost;

  String? lanIP;
  String? lanBroadcast;
  String? lanGateway;

  bool _canCheckInfo = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Доступные серверы"),
        leading: Text("${_packageInfo.version}"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            child: ExpansionTile(
              initiallyExpanded: true,
              title: Text(
                "Информация о сети",
                style: theme.textTheme.titleLarge,
              ),
              childrenPadding: EdgeInsets.all(8),
              children: [
                Text("IP: ${lanIP ?? ""}"),
                Text("Broadcast: ${lanBroadcast ?? ""}"),
                Text("Шлюз: ${lanGateway ?? ""}"),
                TextButton.icon(
                  onPressed: _canCheckInfo ? _initNetworkInfo : null,
                  label: Text("Обновить данные сети"),
                  icon: Container(
                    height: 24,
                    width: 24,
                    child: Icon(Icons.refresh_outlined),
                  ),
                ),
              ],
            ),
          ),
          Card(
            child: ExpansionTile(
              initiallyExpanded: true,
              title: Text(
                "Сканирование",
                style: theme.textTheme.titleLarge,
              ),
              children: [
                StatefulBuilder(
                  builder: (BuildContext context, void Function(void Function()) setState) {
                    return FutureBuilder(
                      future: _scanManual(_hostField.value.text),
                      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        TextButton button;

                        if (snapshot.connectionState != ConnectionState.done) {
                          button = TextButton.icon(
                            icon: Container(
                              height: theme.iconTheme.size ?? 24,
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            onPressed: null,
                            label: Text(
                              "Сканирование...",
                            ),
                          );
                        } else {
                          button = TextButton.icon(
                            icon: snapshot.data ?? false ? Icon(Icons.check) : Icon(Icons.search_rounded),
                            onPressed: () {
                              setState(() {});
                            },
                            label: Text(
                              "Сканировать хост",
                            ),
                          );
                        }
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                constraints: BoxConstraints(minWidth: 100, maxWidth: 300),
                                child: TextField(
                                  controller: _hostField,
                                ),
                              ),
                            ),
                            Container(
                              width: 300,
                              child: StatefulBuilder(
                                builder: (BuildContext context, void Function(void Function()) setState) {
                                  return FutureBuilder(
                                    future: _scanManual(_hostField.value.text),
                                    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                                      TextButton button;

                                      if (snapshot.connectionState != ConnectionState.done) {
                                        button = TextButton.icon(
                                          icon: Container(
                                            height: theme.iconTheme.size ?? 24,
                                            child: FittedBox(
                                              fit: BoxFit.fitHeight,
                                              child: CircularProgressIndicator(),
                                            ),
                                          ),
                                          onPressed: null,
                                          label: Text(
                                            "Сканирование",
                                          ),
                                        );
                                      } else {
                                        button = TextButton.icon(
                                          icon: snapshot.data ?? false ? Icon(Icons.check) : Icon(Icons.search_rounded),
                                          onPressed: () {
                                            setState(() {});
                                          },
                                          label: Text(
                                            "Сканировать хост",
                                          ),
                                        );
                                      }

                                      return Row(
                                        children: [
                                          Flexible(
                                            child: button,
                                            fit: FlexFit.tight,
                                            flex: 2,
                                          ),
                                          Flexible(
                                            child: snapshot.data ?? false
                                                ? Container(
                                                    constraints: BoxConstraints(minWidth: 100, maxWidth: 100),
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pushNamed(context, "/mobile/auth", arguments: "http://${manualHost ?? ""}:8020").then((value) {}, onError: (value) {});
                                                      },
                                                      child: Text(manualHost ?? ""),
                                                    ),
                                                  )
                                                : Container(),
                                            fit: FlexFit.tight,
                                            flex: 1,
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                TextButton.icon(
                  onPressed: _findServers,
                  label: Text("Сканировать сеть"),
                  icon: Container(
                    height: theme.iconTheme.size ?? 24,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Icon(Icons.search_rounded),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Результаты сканирования",
            style: theme.textTheme.titleLarge,
          ),
          Divider(),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _scanActions,
              builder: (BuildContext context, List<String> value, Widget? child) {
                return ListView(
                  controller: _scrollController,
                  children: List.generate(
                    value.length,
                    (index) => ScanHostListTile(
                      host: value[index],
                      inProgress: _scanActionInProgress[value[index]] ?? true,
                      onPressed: !(_scanActionInProgress[value[index]] ?? true)
                          ? () {
                              Navigator.pushNamed(context, "/mobile/auth", arguments: "http://" + value[index] + ":8020").then((value) {}, onError: (value) {});
                            }
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
