import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// `upload_settings ` sat in both translation files with a trailing space, so
/// `context.tr('upload_settings')` fell through and the dialog title rendered as the
/// raw key. These checks turn that class of typo into a failing test.
void main() {
  Map<String, dynamic> load(String locale) =>
      jsonDecode(File('assets/translations/$locale.json').readAsStringSync())
          as Map<String, dynamic>;

  final ru = load('ru');
  final en = load('en');

  test('translation keys carry no stray whitespace', () {
    expect(ru.keys.where((k) => k != k.trim()), isEmpty);
    expect(en.keys.where((k) => k != k.trim()), isEmpty);
  });

  test('ru and en cover exactly the same keys', () {
    expect(ru.keys.toSet().difference(en.keys.toSet()), isEmpty);
    expect(en.keys.toSet().difference(ru.keys.toSet()), isEmpty);
  });

  test('no translation value is empty', () {
    expect(ru.entries.where((e) => '${e.value}'.trim().isEmpty), isEmpty);
    expect(en.entries.where((e) => '${e.value}'.trim().isEmpty), isEmpty);
  });

  test('every key used in lib/ exists in the translation files', () {
    final patterns = <RegExp>[
      RegExp(r"""['"]([A-Za-z0-9_.]+)['"]\s*\.tr\(\)"""),
      RegExp(r"""context\.tr\(\s*['"]([A-Za-z0-9_.]+)['"]"""),
    ];

    final missing = <String, String>{};
    for (final entity in Directory('lib').listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      if (entity.path.contains('/openapi/') ||
          entity.path.contains('/generated/')) {
        continue;
      }
      final source = entity.readAsStringSync();
      for (final pattern in patterns) {
        for (final match in pattern.allMatches(source)) {
          final key = match.group(1)!;
          if (!ru.containsKey(key)) missing[key] = entity.path;
        }
      }
    }

    expect(missing, isEmpty, reason: 'missing translation keys: $missing');
  });
}
