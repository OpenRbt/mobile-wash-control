class LocalNetworkAddress {
  const LocalNetworkAddress({
    required this.interfaceName,
    required this.address,
  });

  final String interfaceName;
  final String address;

  String get prefix => address.substring(0, address.lastIndexOf('.'));
}

class LocalNetworkInfo {
  const LocalNetworkInfo({
    this.addresses = const <LocalNetworkAddress>[],
    this.error,
  });

  final List<LocalNetworkAddress> addresses;
  final String? error;

  LocalNetworkAddress? get primaryAddress {
    if (addresses.isEmpty) {
      return null;
    }
    return addresses.first;
  }
}

class LocalNetworkScanUpdate {
  const LocalNetworkScanUpdate({
    required this.networkInfo,
    required this.hosts,
    required this.scanned,
    required this.total,
    this.currentHost,
    this.error,
    this.completed = false,
  });

  final LocalNetworkInfo networkInfo;
  final List<String> hosts;
  final int scanned;
  final int total;
  final String? currentHost;
  final String? error;
  final bool completed;
}
