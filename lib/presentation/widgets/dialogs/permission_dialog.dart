import 'package:flutter/material.dart';

void permissionDialog({
  required BuildContext context,
  required Future<void> Function() givePermission,
}) {
  showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Предупреждение'),
          content: Text(
              'Необходимо разрешить установку из сторонних источников'
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('context.tr('cancel')')
            ),
            TextButton(
                onPressed: () async {
                  await givePermission();
                  Navigator.pop(context);
                },
                child: Text('Ок')
            )
          ],
        );
      }
  );
}