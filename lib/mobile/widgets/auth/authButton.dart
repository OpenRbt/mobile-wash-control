import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  void Function()? onLongPressed;
  AuthButton({required this.label, required this.onPressed, this.onLongPressed});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    switch (label) {
      case "+":
        return TextButton(
          onPressed: onPressed,
          child: Icon(Icons.login_outlined),
        );
      case "-":
        return TextButton(
          onPressed: onPressed,
          onLongPress: onLongPressed,
          child: Icon(Icons.backspace_outlined),
        );
      default:
        if (label.isNotEmpty) {
          return TextButton(
            onPressed: onPressed,
            child: Text(
              label,
              style: theme.textTheme.displaySmall,
            ),
          );
        }
        return SizedBox();
    }

    return label.isNotEmpty
        ? TextButton(
            onPressed: onPressed,
            child: label == "-"
                ? Icon(Icons.backspace_outlined)
                : Text(
                    label,
                    style: theme.textTheme.displaySmall,
                  ),
          )
        : SizedBox();
  }
}
