import 'package:mobile_wash_control/application/local_network_scan_models.dart';

Future<LocalNetworkInfo> getNetworkInfo() async {
  return const LocalNetworkInfo();
}

Future<bool> probeHost(
  String host, {
  Duration timeout = const Duration(seconds: 2),
}) async {
  return false;
}

Stream<LocalNetworkScanUpdate> scanLocalNetwork({
  LocalNetworkInfo? networkInfo,
  Duration timeout = const Duration(milliseconds: 800),
  int concurrency = 32,
}) async* {
  final info = networkInfo ?? const LocalNetworkInfo();
  yield LocalNetworkScanUpdate(
    networkInfo: info,
    hosts: const <String>[],
    scanned: 0,
    total: 0,
    completed: true,
  );
}
