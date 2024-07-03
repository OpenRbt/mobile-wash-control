import 'package:flutter/material.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/mobile/widgets/common/ProgressButton.dart';
import 'package:mobile_wash_control/repository/repository.dart';

class ConfirmRunProgramDialog extends StatelessWidget {
  final RunProgramConfig config;
  final Repository repository;

  ConfirmRunProgramDialog({required this.config, required this.repository});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: Text(context.tr('program_launching')), 
      content: RichText(
        text: TextSpan(
          text: "${context.tr('launch_program')} ",
          style: theme.textTheme.bodyMedium,
          children: [
            TextSpan(
              text: "${config.programName ?? config.programID.toString()}",
              style: theme.textTheme.bodyMedium!.copyWith(fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),
            ),
            TextSpan(
              text: " ${context.tr('on_post')} ",
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
        ProgressButton(
          onPressed: () async {
            await repository.runProgram(config, context: context);
            Navigator.pop(context);
          },
          child: Text(
            "${context.tr('confirm')}",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            context.tr('cancel'),
          ),
        ),
      ],
    );
  }
}