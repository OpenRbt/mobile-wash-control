import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/io_client.dart';
import 'package:mobile_wash_control/application/backend_bootstrap.dart';
import 'package:mobile_wash_control/application/backend_config.dart';
import 'package:mobile_wash_control/application/local_network_scan_models.dart';

Future<LocalNetworkInfo> getNetworkInfo() async {
  try {
    final interfaces = await NetworkInterface.list(
      type: InternetAddressType.IPv4,
      includeLoopback: false,
      includeLinkLocal: false,
    );
    final addresses = <LocalNetworkAddress>[];

    for (final networkInterface in interfaces) {
      for (final address in networkInterface.addresses) {
        if (_isUsablePrivateIPv4(address.address)) {
          addresses.add(
            LocalNetworkAddress(
              interfaceName: networkInterface.name,
              address: address.address,
            ),
          );
        }
      }
    }

    addresses.sort(_compareAddresses);
    return LocalNetworkInfo(addresses: addresses);
  } catch (error) {
    if (kDebugMode) {
      debugPrint('Network info failed: $error');
    }
    return LocalNetworkInfo(error: error.toString());
  }
}

Future<bool> probeHost(
  String host, {
  Duration timeout = const Duration(seconds: 2),
}) async {
  final client = _probeClient(timeout);
  try {
    return await BackendBootstrap.validate(
      BackendConfig.baseUrlForHost(host),
      client: client,
      timeout: timeout,
    );
  } finally {
    client.close();
  }
}

Stream<LocalNetworkScanUpdate> scanLocalNetwork({
  LocalNetworkInfo? networkInfo,
  Duration timeout = const Duration(milliseconds: 800),
  int concurrency = 32,
}) async* {
  final info = networkInfo ?? await getNetworkInfo();
  final primaryAddress = info.primaryAddress;

  if (primaryAddress == null) {
    yield LocalNetworkScanUpdate(
      networkInfo: info,
      hosts: const <String>[],
      scanned: 0,
      total: 0,
      error: info.error,
      completed: true,
    );
    return;
  }

  final candidates = _scanCandidates(primaryAddress.address);
  final hosts = <String>[];
  final client = _probeClient(timeout);
  var scanned = 0;

  try {
    yield LocalNetworkScanUpdate(
      networkInfo: info,
      hosts: const <String>[],
      scanned: scanned,
      total: candidates.length,
      currentHost: primaryAddress.address,
    );

    for (var index = 0; index < candidates.length; index += concurrency) {
      final batch = candidates.skip(index).take(concurrency).toList();
      final results = await Future.wait(
        batch.map((host) async {
          final valid = await BackendBootstrap.validate(
            BackendConfig.baseUrlForHost(host),
            client: client,
            timeout: timeout,
          );
          return _ScanResult(host, valid);
        }),
      );

      for (final result in results) {
        if (result.valid) {
          hosts.add(result.host);
        }
      }

      scanned += batch.length;
      yield LocalNetworkScanUpdate(
        networkInfo: info,
        hosts: List<String>.unmodifiable(hosts),
        scanned: scanned,
        total: candidates.length,
        currentHost: batch.last,
        completed: scanned >= candidates.length,
      );
    }
  } finally {
    client.close();
  }
}

/// Unreachable addresses have to give the socket back quickly, otherwise a full
/// /24 sweep keeps a few hundred pending connections open on the device.
IOClient _probeClient(Duration timeout) {
  final httpClient =
      HttpClient()
        ..connectionTimeout = timeout
        ..idleTimeout = timeout
        ..maxConnectionsPerHost = 1;
  return IOClient(httpClient);
}

List<String> _scanCandidates(String localAddress) {
  final lastDot = localAddress.lastIndexOf('.');
  if (lastDot <= 0) {
    return const <String>[];
  }

  final prefix = localAddress.substring(0, lastDot);
  final candidates = <String>[
    // A desktop build usually runs on the same machine as the server.
    if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) 'localhost',
    for (var host = 1; host <= 254; host++) '$prefix.$host',
  ];

  return candidates
      .where((host) => host != localAddress)
      .toList(growable: false);
}

bool _isUsablePrivateIPv4(String address) {
  final parts = address.split('.');
  if (parts.length != 4) {
    return false;
  }

  final octets = parts.map(int.tryParse).toList();
  if (octets.any((octet) => octet == null || octet < 0 || octet > 255)) {
    return false;
  }

  final first = octets[0]!;
  final second = octets[1]!;
  if (first == 10) {
    return true;
  }
  if (first == 172 && second >= 16 && second <= 31) {
    return true;
  }
  return first == 192 && second == 168;
}

int _compareAddresses(LocalNetworkAddress left, LocalNetworkAddress right) {
  final scoreCompare = _addressScore(left).compareTo(_addressScore(right));
  if (scoreCompare != 0) {
    return scoreCompare;
  }
  return left.address.compareTo(right.address);
}

int _addressScore(LocalNetworkAddress address) {
  final name = address.interfaceName.toLowerCase();
  var score = 100;

  if (name.contains('wlan') || name.contains('wifi') || name.startsWith('wl')) {
    score -= 50;
  }
  if (address.address.startsWith('192.168.')) {
    score -= 20;
  } else if (address.address.startsWith('10.')) {
    score -= 10;
  }
  return score;
}

class _ScanResult {
  const _ScanResult(this.host, this.valid);

  final String host;
  final bool valid;
}
