import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class TwoFieldDialog extends StatefulWidget {
  final String title;

  final String firstFieldName;
  final String seconFieldName;

  final TextEditingController firstController;
  final TextEditingController secondController;

  final GlobalKey<FormState> validateKey;

  final List<Widget> actions;

  const TwoFieldDialog({
    super.key,
    required this.title,
    required this.firstFieldName,
    required this.seconFieldName,
    required this.firstController,
    required this.secondController,
    required this.validateKey,
    required this.actions
  });

  @override
  State<TwoFieldDialog> createState() => _TwoFieldDialogState();
}

class _TwoFieldDialogState extends State<TwoFieldDialog> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: Text(widget.title),
      content: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width - 20,
            maxHeight: 230
        ),
        child: Form(
          key: widget.validateKey,
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Text(
                      widget.firstFieldName,
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: TextFormField(
                      controller: widget.firstController,
                        validator: (String? value) {
                          return value!.isEmpty ? '${context.tr('field_must_not_be_empty')}' : null;
                        }
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Text(
                      widget.seconFieldName,
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: TextFormField(
                      maxLines: null,
                      controller: widget.secondController,
                      obscureText: false,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: widget.actions,
    );
  }
}
