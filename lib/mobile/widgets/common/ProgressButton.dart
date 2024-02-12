import 'package:flutter/material.dart';

enum ButtonState { idle, working }

class ProgressButton extends StatefulWidget {
  final Function? onPressed;
  final Text child;

  const ProgressButton({super.key, required this.onPressed, required this.child});

  @override
  State<StatefulWidget> createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton> {
  ButtonState state = ButtonState.idle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    switch (state) {
      case ButtonState.idle:
        return ElevatedButton.icon(
          onPressed: widget.onPressed != null
              ? () {
                  setState(() {
                    state = ButtonState.working;
                  });
                }
              : null,
          icon: Container(
            height: theme.iconTheme.size ?? 24,
            width: theme.iconTheme.size ?? 24,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Icon(Icons.arrow_right_outlined),
            ),
          ),
          label: widget.child,
        );
      case ButtonState.working:
        return FutureBuilder(
          future: Future(() async {
            if (widget.onPressed != null) {
              await widget.onPressed!();
            } else {
              await Future.delayed(Duration(seconds: 1));
            }
          }),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            Widget icon;

            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                icon = Container(
                  height: theme.iconTheme.size ?? 24,
                  width: theme.iconTheme.size ?? 24,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: CircularProgressIndicator(color: theme.colorScheme.onPrimary),
                  ),
                );
                break;
              case ConnectionState.done:
                icon = Icon(Icons.arrow_right_outlined);
                Future.delayed(Duration(milliseconds: 500), () {
                  if (mounted) {
                    setState(() {
                      state = ButtonState.idle;
                    });
                  }
                });
                break;
            }

            return ElevatedButton.icon(
              onPressed: null,
              icon: icon,
              label: widget.child,
            );
          },
        );
    }
  }
}
