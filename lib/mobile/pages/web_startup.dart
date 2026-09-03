import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wash_control/application/backend_bootstrap.dart';
import 'package:mobile_wash_control/application/backend_config.dart';

/// Web is always served next to its own backend, so there is nothing to scan
/// for: the origin is checked once and authorization opens right away.
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
          return const Scaffold(body: _StartupSplash());
        }

        if (snapshot.data == true) {
          if (!_openedAuth) {
            _openedAuth = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              Navigator.of(
                context,
              ).pushReplacementNamed('/mobile/auth', arguments: backendUrl);
            });
          }
          return const Scaffold(body: _StartupSplash());
        }

        return Scaffold(
          body: _StartupFailure(backendUrl: backendUrl, onRetry: _retry),
        );
      },
    );
  }
}

class _StartupSplash extends StatelessWidget {
  const _StartupSplash();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 32,
            width: 32,
            child: CircularProgressIndicator(strokeWidth: 3),
          ),
          const SizedBox(height: 24),
          Text(
            'Mobile Wash Control',
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.black54,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _StartupFailure extends StatelessWidget {
  const _StartupFailure({required this.backendUrl, required this.onRetry});

  final String backendUrl;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.error.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.cloud_off_outlined,
                      color: theme.colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '${context.tr('failed')} ${context.tr('connect')}',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    backendUrl,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 28),
                  ElevatedButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh, size: 20),
                    label: Text(context.tr('connect')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
