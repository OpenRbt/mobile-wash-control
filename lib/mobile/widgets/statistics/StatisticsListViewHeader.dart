import 'package:flutter/material.dart';

class StatisticsListViewHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 2,
          child: Center(
            child: Text(
              "Пост",
              style: theme.textTheme.titleLarge,
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: Center(child: Icon(Icons.circle_outlined)),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: Center(child: Icon(Icons.money)),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: Center(child: Icon(Icons.credit_card_outlined)),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 2,
          child: Center(
            child: Text(
              "Сервисные",
              style: theme.textTheme.titleLarge,
            ),
          ),
        ),
      ],
    );
  }
}
