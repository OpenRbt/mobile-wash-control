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
            child: Text("Кнопка ${btn.buttonID}"),
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
                    message: "Не удалось вызвать запуск программы, так как нет данных о хэше станции",
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
                      "Активна",
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
