import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_wash_control/application/backend_config.dart';
import 'package:mobile_wash_control/application/backend_host_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('baseUrlForHost', () {
    test('falls back to the default host when nothing is given', () {
      expect(BackendConfig.baseUrlForHost(''), 'http://localhost:8020');
      expect(BackendConfig.baseUrlForHost('   '), 'http://localhost:8020');
    });

    test('appends the wash server port to a bare address', () {
      expect(
        BackendConfig.baseUrlForHost('192.168.1.12'),
        'http://192.168.1.12:8020',
      );
    });

    test('keeps an explicit port and scheme', () {
      expect(
        BackendConfig.baseUrlForHost('192.168.1.12:9000'),
        'http://192.168.1.12:9000',
      );
      expect(
        BackendConfig.baseUrlForHost('https://wash.example.com/'),
        'https://wash.example.com',
      );
    });
  });

  group('BackendHostStore', () {
    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues(<String, Object>{});
    });

    test('returns null until a host has been saved', () async {
      expect(await BackendHostStore.read(), isNull);
    });

    test('keeps the host the operator connected to', () async {
      await BackendHostStore.save('192.168.1.12');
      expect(await BackendHostStore.read(), '192.168.1.12');
    });

    test('ignores a blank host', () async {
      await BackendHostStore.save('   ');
      expect(await BackendHostStore.read(), isNull);
    });
  });
}
