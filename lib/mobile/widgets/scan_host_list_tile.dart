import 'package:flutter/material.dart';

class ScanHostListTile extends StatelessWidget {
  final bool inProgress;

  final Function()? onPressed;
  final String host;
  final String? label;

  const ScanHostListTile({
    super.key,
    required this.host,
    this.onPressed,
    this.label,
    required this.inProgress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget icon;

    if (inProgress) {
      icon = const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(strokeWidth: 2.4),
      );
    } else {
      icon = const Icon(Icons.check_circle_outline, color: Colors.green);
    }

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: SizedBox(height: 24, width: 24, child: Center(child: icon)),
        title: Text(
          host,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle:
            label == null
                ? null
                : Text(
                  label!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.black54,
                  ),
                ),
        trailing: const Icon(Icons.chevron_right, color: Colors.black38),
        onTap: onPressed,
      ),
    );
  }
}
