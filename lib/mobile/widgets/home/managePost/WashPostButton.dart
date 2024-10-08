import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/mobile/dialogs/overview/ConfirmRunProgram.dart';
import 'package:mobile_wash_control/mobile/widgets/common/snackBars.dart';
import 'package:mobile_wash_control/repository/repository.dart';

class WashPostButton extends StatelessWidget {
  final String? stationHash;
  final StationButton btn;
  final Repository repository;
  final int stationID;

  const WashPostButton({super.key, required this.btn, required this.stationHash, required this.repository, required this.stationID});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${context.tr('button')} ${btn.buttonID}"),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: ElevatedButton(
            onPressed: () {
              if (stationHash != null) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ConfirmRunProgramDialog(config: RunProgramConfig(stationHash: stationHash!, programID: btn.programID!, programName: btn.programName, stationID: stationID), repository: repository);
                  },
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBars.getErrorSnackBar(
                    message: context.tr('failed_to_cause_the_programme_to_run_because_no_station_hash_data_is_available'),
                  ),
                );
              }
            },
            child: Text(
              "${btn.programID} : ${btn.programName ?? "-"}",
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ValueListenableBuilder(
              valueListenable: repository.getStationsNotifier(),
              builder: (BuildContext context, List<Station>? value, Widget? child) {
                var program = repository.getCurrentProgram(stationID);

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.tr('is_active'),
                      style: theme.textTheme.bodyLarge,
                    ),
                    Checkbox(value: btn.programID == program?.id, onChanged: null)
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
