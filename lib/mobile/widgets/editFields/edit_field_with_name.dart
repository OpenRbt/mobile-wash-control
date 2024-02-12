import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditField extends StatelessWidget {
  final String name;
  final TextStyle? style;
  final TextEditingController? controller;
  final bool canEdit;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String val) onChanged;
  final String? Function(String? val) validator;

  const EditField({Key? key, required this.name, required this.style,
    required this.controller, required this.onChanged, required this.validator,
    required this.canEdit, this.inputFormatters, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: Text(
            name,
            style: style,
          ),
        ),
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: TextFormField(
            enabled: canEdit,
            inputFormatters: inputFormatters,
            controller: controller,
            onChanged: onChanged,
            validator: validator,
          ),
        ),
      ],
    );
  }
}
