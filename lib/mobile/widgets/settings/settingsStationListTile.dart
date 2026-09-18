import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsStationListTile extends StatelessWidget {
  final int index;
  final Station station;
  final double? temperature;
  final VoidCallback? onPressed;

  const SettingsStationListTile({
    super.key,
    required this.station,
    required this.index,
    this.temperature,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOnline = station.status == "online";

    return ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            station.name ?? "${context.tr('post')} $index",
            style: theme.textTheme.titleLarge,
          ),
          Icon(
            Icons.circle,
            color: isOnline ? Colors.green : Colors.red,
          ),
        ],
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Text(
              "${context.tr('hash')}: ${station.hash ?? '-'}",
            ),
          ),
        ],
      ),
      childrenPadding: const EdgeInsets.all(8),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                context.tr('temperature'),
                style: theme.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(
                temperature != null ? temperature!.toString() : "-",
              ),
            ),
          ],
        ),
        const Divider(),
        OutlinedButton(
          onPressed: onPressed,
          child: Text(context.tr('open_settings')),
        ),
      ],
    );
  }
}
