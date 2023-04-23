import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  void Function()? onLongPressed;
  AuthButton({required this.label, required this.onPressed, this.onLongPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    switch (label) {
      case "+":
        return OutlinedButton(
          onPressed: onPressed,
          child: Icon(Icons.login_outlined),
        );
      case "-":
        return OutlinedButton(
          onPressed: onPressed,
          child: Icon(Icons.backspace_outlined),
        );
      default:
        if (label.isNotEmpty) {
          return OutlinedButton(
            onPressed: onPressed,
            child: Text(
              label,
              style: theme.textTheme.displaySmall,
            ),
          );
        }
        return SizedBox();
    }
  }
}
