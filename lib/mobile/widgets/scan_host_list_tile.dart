import 'package:flutter/material.dart';

class ScanHostListTile extends StatelessWidget {
  final Function()? onPressed;
  final Future<bool> action;
  final String host;

  const ScanHostListTile({super.key, required this.action, required this.host, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder(
      future: action,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        Widget icon;
        final ok = snapshot.data ?? false;

        if (snapshot.connectionState != ConnectionState.done) {
          icon = Container(
            height: theme.iconTheme.size ?? 24,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          icon = Icon(
            ok ? Icons.check_circle_outline : Icons.cancel_outlined,
            color: ok ? Colors.green : Colors.red,
          );
        }

        return ListTile(
          title: Text(host),
          leading: icon,
          onTap: ok ? onPressed : null,
        );
      },
    );
  }
}
