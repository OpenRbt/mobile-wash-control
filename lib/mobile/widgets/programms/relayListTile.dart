import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_wash_control/entity/entity.dart';

class RelayListTile extends StatelessWidget {
  final int id;
  final TextEditingController relay;
  final TextEditingController relayPreflight;

  final RelayConfig relayConfig;

  const RelayListTile({super.key, required this.id, required this.relay, required this.relayPreflight, required this.relayConfig});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        Text(
          "Реле: $id",
          style: theme.textTheme.titleLarge,
        ),
        Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text(
                "% реле",
                style: theme.textTheme.bodyLarge,
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: TextField(
                controller: relay,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  if (val.isEmpty) {
                  } else {
                    if (int.parse(val) > 100) {
                      relay.text = "100";
                    }
                  }
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text(
                "% реле прокачки",
                style: theme.textTheme.bodyLarge,
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: TextField(
                controller: relayPreflight,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  if (val.isEmpty) {
                  } else {
                    if (int.parse(val) > 100) {
                      relayPreflight.text = "100";
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
