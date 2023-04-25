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

  @override
  void dispose() {
    hosts.dispose();
    _hostField.dispose();
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
    scanTargets.remove(lanIP!);
    hosts.value = scanTargets;

    return;
  }

  Future<bool> _scanHost(String host) async {
    try {
      var client = HttpClient();
      client.connectionTimeout = Duration(seconds: 3);
      final res = await client.get(host, 8020, "/ping");
      final response = await res.close();
      if (response.statusCode != 200) {
        return false;
      }
      return true;
    } catch (e) {}
    return false;
  }

  Future<bool> _scanManual(String host) async {
    try {
      var client = HttpClient();
      client.connectionTimeout = Duration(seconds: 3);
      final res = await client.get(host, 8020, "/ping");
      final response = await res.close();
      if (response.statusCode != 200) {
        manualHost = null;
        return false;
      }
      manualHost = host;
      return true;
    } catch (e) {}
    manualHost = null;
    return false;
  }

  String? manualHost;

  String? lanIP;
  String? lanBroadcast;
  String? lanGateway;

  bool _canCheckInfo = true;

  ValueNotifier<List<String>> hosts = ValueNotifier([]);

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
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("IP: ${lanIP ?? ""}"),
                    Text("Broadcast: ${lanBroadcast ?? ""}"),
                    Text("Шлюз: ${lanGateway ?? ""}"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: _canCheckInfo ? _initNetworkInfo : null,
                          label: Text("Обновить данные сети"),
                          icon: Container(
                            height: 24,
                            width: 24,
                            child: Icon(Icons.refresh_outlined),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: _findServers,
                          label: Text("Сканировать"),
                          icon: Container(
                            height: 24,
                            width: 24,
                            child: Icon(Icons.search_rounded),
                          ),
                        ),
                        Platform.isLinux
                            ? Column(
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
                                                              Navigator.pushNamed(context, "/mobile/auth",
                                                                      arguments: "http://${manualHost ?? ""}:8020")
                                                                  .then((value) {}, onError: (value) {});
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
                              )
                            : Container(),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Text(
            "Сканирование сети",
            style: theme.textTheme.titleLarge,
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: hosts,
              builder: (BuildContext context, List<String> value, Widget? child) {
                return ListView(
                  children: List.generate(
                    hosts.value.length,
                    (index) => ScanHostListTile(
                      action: _scanHost(value[index]),
                      host: value[index],
                      onPressed: () {
                        Navigator.pushNamed(context, "/mobile/auth", arguments: "http://" + value[index] + ":8020")
                            .then((value) {}, onError: (value) {});
                      },
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
