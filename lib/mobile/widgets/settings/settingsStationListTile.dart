import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/repository/repository.dart';

class SettingsStationListTile extends StatelessWidget {
  final int index;
  final Station station;
  final Repository repository;
  final void Function()? onPressed;

  const SettingsStationListTile({super.key, required this.station, required this.index, required this.repository, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isOnline = station?.status == "online";

    return ExpansionTile(
      leading: IconButton(
        icon: Icon(Icons.edit_outlined),
        onPressed: onPressed,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            station.name ?? "Пост $index",
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
              "Хэш",
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
                "Температура",
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
        )
      ],
    );
  }
}
