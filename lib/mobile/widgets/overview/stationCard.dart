import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:easy_localization/easy_localization.dart';

class StationCard extends StatelessWidget {
  final Station data;

  final void Function()? onPressed;

  const StationCard({super.key, required this.data, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Color statusColor;
    if (data.hash == null) {
      statusColor = Colors.black26;
    } else if (data.status == "online") {
      statusColor = Colors.green;
    } else if (data.status == null) {
      statusColor = Colors.black45;
    } else {
      statusColor = Colors.red;
    }

    final int displayBalance =
        (data.currentBalance ?? 0) < 0 ? 0 : (data.currentBalance ?? 0);
    final String programName = data.hash != null
        ? data.currentProgramName ?? context.tr('waiting_for_the_customer')
        : "-";

    return Card(
      child: ExpansionTile(
        leading: Container(
          height: 12,
          width: 12,
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                "${context.tr('post')}: ${data.name}",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "${context.tr('balance')}: $displayBalance",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            "${context.tr('program')}: $programName",
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.black54),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        expandedAlignment: Alignment.center,
        expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Divider(height: 1),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "IP: ${data.ip ?? "-"}",
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "${context.tr('hash')}: ${data.hash ?? "-"}",
                      style: theme.textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: onPressed,
                icon: Icon(Icons.settings_outlined, size: 20),
                label: Text(context.tr('management')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
