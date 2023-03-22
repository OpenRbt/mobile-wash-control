import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/SharedData.dart';
import 'package:mobile_wash_control/client/api.dart';
import 'package:mobile_wash_control/mobile/pages/programs/editProgram.dart';

class ProgramListTile extends StatelessWidget {
  final Function()? onPress;
  final Program program;

  const ProgramListTile({super.key, this.onPress, required this.program});

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = SharedData.sessionData!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Center(child: Text("${program.id}")),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Center(
                child: Text(
                  "${program.name ?? ""}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Center(child: Text("${"${(program.preflightEnabled ?? false) ? "Да" : "Нет"}"}")),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Center(child: Text("${"${(program.isFinishingProgram ?? false) ? "Да" : "Нет"}"}")),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: LayoutBuilder(
                  builder: (context, constraint) {
                    return Icon(
                      Icons.settings_outlined,
                    );
                  },
                ),
                onPressed: () {
                  var args = EditProgramArgs(program.id, program.name ?? "");
                  Navigator.pushNamed(context, "/mobile/programs/edit", arguments: args).then(
                    (value) => SharedData.RefreshPrograms(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
