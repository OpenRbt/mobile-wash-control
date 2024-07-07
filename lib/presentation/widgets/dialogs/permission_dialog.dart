import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

void permissionDialog({
  required BuildContext context,
  required Future<void> Function() givePermission,
}) {
  showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(context.tr('warning')),
          content: Text(
              context.tr('you_must_allow_installation_from_third_party_sources')
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('${context.tr('cancel')}')
            ),
            TextButton(
                onPressed: () async {
                  await givePermission();
                  Navigator.pop(context);
                },
                child: Text(context.tr('ok'))
            )
          ],
        );
      }
  );
}