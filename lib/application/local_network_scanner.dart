import 'package:mobile_wash_control/application/local_network_scan_models.dart';

import 'local_network_scanner_stub.dart'
    if (dart.library.io) 'local_network_scanner_io.dart'
    as implementation;

class LocalNetworkScanner {
  Future<LocalNetworkInfo> getNetworkInfo() {
    return implementation.getNetworkInfo();
  }

  Future<bool> probeHost(
    String host, {
    Duration timeout = const Duration(seconds: 2),
  }) {
    return implementation.probeHost(host, timeout: timeout);
  }

  Stream<LocalNetworkScanUpdate> scan({
    LocalNetworkInfo? networkInfo,
    Duration timeout = const Duration(milliseconds: 800),
    int concurrency = 32,
  }) {
    return implementation.scanLocalNetwork(
      networkInfo: networkInfo,
      timeout: timeout,
      concurrency: concurrency,
    );
  }
}
