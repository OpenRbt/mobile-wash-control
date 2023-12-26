import 'package:flutter/material.dart';

class UniversalCard extends StatelessWidget {

  final String title;
  final String titleData;
  final String? subTitle;
  final String? subTitleData;
  final void Function()? onPressed;

  const UniversalCard({super.key, this.onPressed, required this.title, required this.titleData, this.subTitle, this.subTitleData,});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ExpansionTile(
        title: Text("$title: ${titleData} "),
        trailing: subTitle == null ? const SizedBox(width: 0, height: 0,) :
        Text("$subTitle: ${subTitleData ?? ""} "),
        subtitle: const Row(
        ),
        childrenPadding: const EdgeInsets.all(8.0),
        expandedAlignment: Alignment.center,
        expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton.icon(
                onPressed: onPressed,
                icon: const Icon(Icons.settings_outlined),
                label: const Text("Управление"),
              )
            ],
          )
        ],
      ),
    );
  }
}
