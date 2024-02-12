import 'package:flutter/material.dart';

class DropDownWithButton extends StatelessWidget {

  final void Function(String val) onChanged;
  final Future<void> Function() onPressed;
  final String currentValue;
  final List<String> values;
  final String buttonText;

  const DropDownWithButton({Key? key, required this.onChanged,
    required this.onPressed, required this.currentValue,
    required this.values, required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          fit: FlexFit.loose,
          child: DropdownButtonFormField(
            isExpanded: true,
            value: currentValue,
            items: List.generate(
              values.length,
                  (index) => DropdownMenuItem(
                value: values[index],
                child: Text(values[index]),
              ),
            ),
            onChanged: (Object? value) async {
              onChanged(value.toString());
            },
          ),
        ),
        Flexible(
          flex: 3,
          fit: FlexFit.loose,
          child: ElevatedButton(
            child: Text(buttonText),
            onPressed: () async {
              await onPressed();
            },
          )
        ),
      ],
    );
  }
}
