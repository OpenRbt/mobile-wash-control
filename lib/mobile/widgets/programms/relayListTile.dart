import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RelayListTile extends StatelessWidget {
  final int id;
  final TextEditingController relay;
  final TextEditingController relayPreflight;

  const RelayListTile({super.key, required this.id, required this.relay, required this.relayPreflight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Center(child: Text("$id")),
          VerticalDivider(),
          Flexible(
            fit: FlexFit.tight,
            child: TextField(
              controller: relay,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              onChanged: (val) {
                if (val.isEmpty) {
                  relay.text = "0";
                } else {
                  if (int.parse(val) > 100) {
                    relay.text = "100";
                  }
                }
              },
            ),
          ),
          VerticalDivider(),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: TextField(
              controller: relayPreflight,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              onChanged: (val) {
                if (val.isEmpty) {
                  relayPreflight.text = "0";
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
    );
  }
}
