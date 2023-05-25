import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/repository/repository.dart';

class ConfirmRunProgramDialog extends StatelessWidget {
  final RunProgramConfig config;
  final Repository repository;

  ConfirmRunProgramDialog({required this.config, required this.repository});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: Text("Запуск программы"),
      content: RichText(
        text: TextSpan(
          text: "Запустить программу ",
          style: theme.textTheme.bodyMedium,
          children: [
            TextSpan(
              text: "${config.programName ?? config.programID.toString()}",
              style: theme.textTheme.bodyMedium!.copyWith(fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),
            ),
            TextSpan(
              text: " на посту ",
            ),
            TextSpan(
              text: "${config.stationID} (${config.stationHash})",
              style: theme.textTheme.bodyMedium!.copyWith(fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),
            ),
            TextSpan(
              text: "?",
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            await repository.runProgram(config, context: context);
            Navigator.pop(context);
          },
          child: Text(
            "Подтвердить",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Отмена",
          ),
        ),
      ],
    );
  }
}
