import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_wash_control/SharedData.dart';
import 'package:mobile_wash_control/application/Application.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
    final theme = Theme.of(context);

    SharedData.RefreshStatus();

    return Scaffold(
      appBar: AppBar(
        title: Text("Доступные серверы"),
        leading: Text("${_packageInfo.version}"),
        bottom: _canCheckServers
            ? PreferredSize(child: SizedBox(), preferredSize: Size(double.maxFinite, 4))
            : PreferredSize(
                child: LinearProgressIndicator(
                  color: theme.colorScheme.onPrimary,
                ),
                preferredSize: Size(double.maxFinite, 4)),
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
