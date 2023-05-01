import 'package:flutter/material.dart';

class ScanHostListTile extends StatelessWidget {
  final bool inProgress;

  final Function()? onPressed;
  final String host;

  const ScanHostListTile({super.key, required this.host, this.onPressed, required this.inProgress});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget icon;

    if (inProgress) {
      icon = Container(
        height: theme.iconTheme.size ?? 24,
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      icon = Icon(
        Icons.check_circle_outline,
        color: Colors.green,
      );
    }
    return ListTile(
      title: Text(host),
      leading: icon,
      onTap: onPressed,
    );
  }
}
