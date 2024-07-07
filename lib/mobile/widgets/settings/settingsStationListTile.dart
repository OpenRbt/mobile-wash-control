import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/repository/repository.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsStationListTile extends StatelessWidget {
  final int index;
  final Station station;
  final Repository repository;
  final void Function()? onPressed;

  const SettingsStationListTile(
      {super.key, required this.station, required this.index, required this.repository, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isOnline = station?.status == "online";
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
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text(
              context.tr('hash'),
              style: theme.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Text(
              station?.hash ?? "-",
              style: theme.textTheme.bodyLarge,
            ),
          ),
        ],
      ),
      childrenPadding: EdgeInsets.all(8),
      children: [
        Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text(
                context.tr('temperature'),
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: FutureBuilder(
                future: repository.getStationTemperature(station.id),
                builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  String tempString = (snapshot.data ?? "").replaceAll('"', '');

                  double? temp = double.tryParse(tempString ?? "");
                  return Text(temp?.toString() ?? "-");
                },
              ),
            ),
          ],
        ),
        Divider(),
        OutlinedButton(
          onPressed: onPressed,
          child: Text(context.tr('open_settings')),
        ),
      ],
    );
  }
}
