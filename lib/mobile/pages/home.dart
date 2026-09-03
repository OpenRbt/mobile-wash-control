import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wash_control/application/backend_config.dart';
import 'package:mobile_wash_control/application/backend_host_store.dart';
import 'package:mobile_wash_control/application/local_network_scan_models.dart';
import 'package:mobile_wash_control/application/local_network_scanner.dart';
import 'package:mobile_wash_control/mobile/widgets/common/content_container.dart';
import 'package:mobile_wash_control/mobile/widgets/scan_host_list_tile.dart';
import 'package:mobile_wash_control/styles/app_theme.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum _ScanStage { connecting, scanning, done }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final LocalNetworkScanner _scanner = LocalNetworkScanner();

  PackageInfo _packageInfo = PackageInfo(
    appName: '',
    packageName: '',
    version: '',
    buildNumber: '',
    buildSignature: '',
  );

  LocalNetworkInfo _networkInfo = const LocalNetworkInfo();
  StreamSubscription<LocalNetworkScanUpdate>? _scanSubscription;
  List<String> _hosts = const <String>[];
  String? _savedHost;
  String _scanHost = '';
  String? _scanError;
  _ScanStage _stage = _ScanStage.connecting;
  bool _autoConnectTried = false;
  int _scanned = 0;
  int _scanTotal = 0;

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    _bootstrap();
  }

  @override
  void dispose() {
    _scanSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    if (!mounted) {
      return;
    }
    setState(() {
      _packageInfo = info;
    });
  }

  /// The server the operator used last is tried before the subnet sweep, so a
  /// restart on a known network goes straight to authorization.
  Future<void> _bootstrap() async {
    final savedHost = await BackendHostStore.read();
    if (!mounted) {
      return;
    }
    setState(() {
      _savedHost = savedHost;
    });

    await _refreshNetworkInfo();
    if (!mounted) {
      return;
    }

    if (savedHost != null && !_autoConnectTried) {
      _autoConnectTried = true;
      setState(() {
        _stage = _ScanStage.connecting;
        _scanHost = savedHost;
      });

      final reachable = await _scanner.probeHost(savedHost);
      if (!mounted) {
        return;
      }
      if (reachable) {
        setState(() {
          _stage = _ScanStage.done;
          _hosts = <String>[savedHost];
        });
        _openServer(savedHost);
        return;
      }
    }

    if (_networkInfo.primaryAddress != null) {
      _findServers();
    } else {
      setState(() {
        _stage = _ScanStage.done;
      });
    }
  }

  Future<void> _refreshNetworkInfo() async {
    setState(() {
      _scanError = null;
    });

    final info = await _scanner.getNetworkInfo();
    if (!mounted) {
      return;
    }

    setState(() {
      _networkInfo = info;
      _scanError = info.error;
    });
  }

  Future<void> _refreshAndScan() async {
    await _refreshNetworkInfo();
    if (!mounted || _networkInfo.primaryAddress == null) {
      return;
    }
    _findServers();
  }

  Future<void> _findServers() async {
    await _scanSubscription?.cancel();
    if (!mounted) {
      return;
    }

    setState(() {
      _hosts = const <String>[];
      _scanHost = '';
      _scanError = null;
      _scanned = 0;
      _scanTotal = 0;
      _stage = _ScanStage.scanning;
    });

    _scanSubscription = _scanner
        .scan(networkInfo: _networkInfo)
        .listen(
          (update) {
            if (!mounted) {
              return;
            }
            setState(() {
              _networkInfo = update.networkInfo;
              _hosts = update.hosts;
              _scanHost = update.currentHost ?? '';
              _scanError = update.error;
              _scanned = update.scanned;
              _scanTotal = update.total;
              if (update.completed) {
                _stage = _ScanStage.done;
              }
            });
          },
          onError: (Object error) {
            if (kDebugMode) {
              debugPrint('Network scan failed: $error');
            }
            if (!mounted) {
              return;
            }
            setState(() {
              _scanError = error.toString();
              _stage = _ScanStage.done;
            });
          },
          onDone: () {
            if (!mounted) {
              return;
            }
            setState(() {
              _stage = _ScanStage.done;
            });
          },
        );
  }

  Future<void> _openServer(String host) async {
    await BackendHostStore.save(host);
    if (!mounted) {
      return;
    }
    setState(() {
      _savedHost = host;
    });
    Navigator.pushNamed(
      context,
      '/mobile/auth',
      arguments: BackendConfig.baseUrlForHost(host),
    ).then((value) {}, onError: (value) {});
  }

  bool get _busy =>
      _stage == _ScanStage.scanning || _stage == _ScanStage.connecting;

  double? get _scanProgress {
    if (_stage != _ScanStage.scanning || _scanTotal == 0) {
      return null;
    }
    return _scanned / _scanTotal;
  }

  String get _statusTitle {
    switch (_stage) {
      case _ScanStage.connecting:
        return '${context.tr('connecting')}...';
      case _ScanStage.scanning:
        return '${context.tr('scanning')}...';
      case _ScanStage.done:
        if (_hosts.isNotEmpty) {
          return context.tr('available_servers');
        }
        if (_networkInfo.primaryAddress == null) {
          return context.tr('network_unavailable');
        }
        return context.tr('servers_not_found');
    }
  }

  String get _statusSubtitle {
    switch (_stage) {
      case _ScanStage.connecting:
        return _scanHost;
      case _ScanStage.scanning:
        return _scanTotal == 0 ? '' : '$_scanned / $_scanTotal';
      case _ScanStage.done:
        if (_networkInfo.primaryAddress == null) {
          return context.tr('check_wifi_connection');
        }
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryAddress = _networkInfo.primaryAddress;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Wash Control'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _packageInfo.version,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onPrimary.withValues(alpha: 0.8),
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: SizedBox(
            height: 3,
            child:
                _busy
                    ? LinearProgressIndicator(
                      value: _scanProgress,
                      backgroundColor: theme.colorScheme.onPrimary.withValues(
                        alpha: 0.25,
                      ),
                      color: theme.colorScheme.onPrimary,
                    )
                    : null,
          ),
        ),
      ),
      body: SafeArea(
        child: ContentContainer(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _StatusCard(
                busy: _busy,
                title: _statusTitle,
                subtitle: _statusSubtitle,
                error: _scanError,
                localAddress: primaryAddress?.address,
                subnet:
                    primaryAddress == null ? null : '${primaryAddress.prefix}.0/24',
                foundCount: _hosts.length,
                onScan: _busy ? null : _refreshAndScan,
              ),
              const SizedBox(height: 20),
              Expanded(child: _buildServerList(theme)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServerList(ThemeData theme) {
    if (_hosts.isEmpty) {
      return _EmptyServerList(
        busy: _busy,
        message:
            _busy ? context.tr('scanning') : context.tr('servers_not_found'),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 24),
      itemCount: _hosts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 4),
      itemBuilder: (BuildContext context, int index) {
        final host = _hosts[index];
        return ScanHostListTile(
          host: host,
          inProgress: false,
          label: host == _savedHost ? context.tr('saved_server') : null,
          onPressed: () => _openServer(host),
        );
      },
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.busy,
    required this.title,
    required this.subtitle,
    required this.error,
    required this.localAddress,
    required this.subnet,
    required this.foundCount,
    required this.onScan,
  });

  final bool busy;
  final String title;
  final String subtitle;
  final String? error;
  final String? localAddress;
  final String? subnet;
  final int foundCount;
  final VoidCallback? onScan;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasError = error != null && error!.isNotEmpty;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _StatusIcon(busy: busy, success: foundCount > 0),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (subtitle.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            if (localAddress != null) ...[
              const SizedBox(height: 20),
              const Divider(height: 1),
              const SizedBox(height: 16),
              _InfoRow(label: 'IP', value: localAddress!),
              if (subnet != null) ...[
                const SizedBox(height: 8),
                _InfoRow(label: context.tr('network_info'), value: subnet!),
              ],
            ],
            if (hasError) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.error.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(AppTheme.controlRadius),
                ),
                child: Text(
                  error!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onScan,
                icon: const Icon(Icons.wifi_find_outlined, size: 20),
                label: Text(context.tr('scan_network')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusIcon extends StatelessWidget {
  const _StatusIcon({required this.busy, required this.success});

  final bool busy;
  final bool success;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = success ? Colors.green : theme.colorScheme.primary;

    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Center(
        child:
            busy
                ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.4,
                    color: color,
                  ),
                )
                : Icon(
                  success ? Icons.check_rounded : Icons.wifi_tethering_outlined,
                  color: color,
                  size: 22,
                ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black54),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _EmptyServerList extends StatelessWidget {
  const _EmptyServerList({required this.busy, required this.message});

  final bool busy;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              busy ? Icons.radar_outlined : Icons.dns_outlined,
              size: 40,
              color: Colors.black26,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
