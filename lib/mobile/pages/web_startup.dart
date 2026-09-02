import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wash_control/application/backend_bootstrap.dart';
import 'package:mobile_wash_control/application/backend_config.dart';

class WebStartupPage extends StatefulWidget {
  const WebStartupPage({super.key});

  @override
  State<WebStartupPage> createState() => _WebStartupPageState();
}

class _WebStartupPageState extends State<WebStartupPage> {
  late Future<bool> _validation;
  bool _openedAuth = false;

  @override
  void initState() {
    super.initState();
    _validation = BackendBootstrap.validate(BackendConfig.webBaseUrl);
  }

  void _retry() {
    setState(() {
      _openedAuth = false;
      _validation = BackendBootstrap.validate(BackendConfig.webBaseUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    final backendUrl = BackendConfig.webBaseUrl;

    return FutureBuilder<bool>(
      future: _validation,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.data == true) {
          if (!_openedAuth) {
            _openedAuth = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              Navigator.of(context).pushReplacementNamed(
                '/mobile/auth',
                arguments: backendUrl,
              );
            });
          }
          return const SizedBox.shrink();
        }

        final theme = Theme.of(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Mobile Wash Control'),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${context.tr('failed')} ${context.tr('connect')}',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    backendUrl,
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _retry,
                    icon: const Icon(Icons.refresh),
                    label: Text(context.tr('connect')),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
