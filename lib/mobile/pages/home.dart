import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wash_control/application/backend_bootstrap.dart';
import 'package:mobile_wash_control/application/backend_config.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _hostField = TextEditingController(text: BackendConfig.defaultScanHost);

  PackageInfo _packageInfo = PackageInfo(
    appName: '',
    packageName: '',
    version: '',
    buildNumber: '',
    buildSignature: '',
  );

  @override
  void dispose() {
    _hostField.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Future<bool> _scanManual(String host) async {
    final valid = await BackendBootstrap.validate(BackendConfig.baseUrlForHost(host));
    if (valid) {
      manualHost = host;
    }
    return valid;
  }

  String? manualHost;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Mobile Wash Control"),
        leading: Text("${_packageInfo.version}"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            child: ExpansionTile(
              initiallyExpanded: true,
              title: Text(
                "${context.tr('scanning')} localhost",
                style: theme.textTheme.titleLarge,
              ),
              children: [
                StatefulBuilder(
                  builder: (
                    BuildContext context,
                    void Function(void Function()) setState,
                  ) {
                    return FutureBuilder(
                      future: _scanManual(_hostField.value.text),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<bool> snapshot,
                      ) {
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
                            label: Text("${context.tr('scanning')}..."),
                          );
                        } else {
                          button = TextButton.icon(
                            icon:
                                snapshot.data ?? false
                                    ? Icon(Icons.check)
                                    : Icon(Icons.search_rounded),
                            onPressed: () {
                              setState(() {});
                            },
                            label: Text(context.tr('scan')),
                          );
                        }
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                constraints: BoxConstraints(
                                  minWidth: 100,
                                  maxWidth: 300,
                                ),
                                child: TextField(
                                  controller: _hostField,
                                  readOnly: true,
                                ),
                              ),
                            ),
                            Container(
                              width: 300,
                              child: StatefulBuilder(
                                builder: (
                                  BuildContext context,
                                  void Function(void Function()) setState,
                                ) {
                                  return FutureBuilder(
                                    future: _scanManual(_hostField.value.text),
                                    builder: (
                                      BuildContext context,
                                      AsyncSnapshot<bool> snapshot,
                                    ) {
                                      TextButton button;

                                      if (snapshot.connectionState !=
                                          ConnectionState.done) {
                                        button = TextButton.icon(
                                          icon: Container(
                                            height: theme.iconTheme.size ?? 24,
                                            child: FittedBox(
                                              fit: BoxFit.fitHeight,
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          ),
                                          onPressed: null,
                                          label: Text(context.tr('scanning')),
                                        );
                                      } else {
                                        button = TextButton.icon(
                                          icon:
                                              snapshot.data ?? false
                                                  ? Icon(Icons.check)
                                                  : Icon(Icons.search_rounded),
                                          onPressed: () {
                                            setState(() {});
                                          },
                                          label: Text(context.tr('scan')),
                                        );
                                      }

                                      return Row(
                                        children: [
                                          Flexible(
                                            child: button,
                                            fit: FlexFit.tight,
                                            flex: 1,
                                          ),
                                          Flexible(
                                            child:
                                                snapshot.data ?? false
                                                    ? Container(
                                                      constraints:
                                                          BoxConstraints(
                                                            minWidth: 100,
                                                            maxWidth: 100,
                                                          ),
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pushNamed(
                                                            context,
                                                            "/mobile/auth",
                                                            arguments:
                                                                BackendConfig.baseUrlForHost(manualHost ?? ""),
                                                          ).then(
                                                            (value) {},
                                                            onError: (value) {},
                                                          );
                                                        },
                                                        child: Text(
                                                          context.tr('connect'),
                                                        ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
